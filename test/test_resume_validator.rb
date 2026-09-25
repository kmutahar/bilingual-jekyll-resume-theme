# frozen_string_literal: true

require "minitest/autorun"

require "fileutils"
require "tmpdir"
require "yaml"
require "jekyll"
require_relative "../lib/bilingual-jekyll-resume-theme/resume_validator"
require_relative "../_plugins/resume_validator"

# Covers the config-driven, locale-file-driven ResumeValidator (Task 5.2 rewrite): language
# resolution from `languages:` config, locale merging (theme _data/locales/<lang>.yml deep-merged
# with the site's <data_dir>/locales/<lang>.yml), locale key-parity warnings, misconfigured-language
# errors, and the Jekyll::Generator plugin wrapper's default-on / strict-mode behavior.
class ResumeValidatorTest < Minitest::Test
  REPO_ROOT = File.expand_path("..", __dir__)
  SAMPLE_DATA_DIR = File.join(REPO_ROOT, "demo", "_data")
  SAMPLE_CONFIG_PATH = File.join(REPO_ROOT, "_config.sample.yml")
  THEME_LOCALES_DIR = File.join(REPO_ROOT, "_data", "locales")

  def setup
    @sample_config = YAML.safe_load_file(SAMPLE_CONFIG_PATH, permitted_classes: [Date, Time])
  end

  # --- Helpers -----------------------------------------------------------------------------

  def write_yaml(path, data)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, YAML.dump(data))
  end

  # Minimal valid header.yml, just enough to avoid unrelated schema warnings/errors so tests
  # can focus on the locale/language behaviour under test.
  def write_minimal_language_dir(data_dir, lang)
    write_yaml(File.join(data_dir, lang, "header.yml"), "intro" => "A sufficiently long introduction paragraph for validation.")
  end

  # --- 1. Six-language discovery from a real config's `languages:` block, end to end -------

  def test_six_language_fixture_discovers_all_languages_and_validates_cleanly
    validator = BilingualJekyllResumeTheme::ResumeValidator.new(SAMPLE_DATA_DIR, config_path: SAMPLE_CONFIG_PATH)
    exit_code = validator.validate(quiet: true, fail_on_warnings: true)

    assert_equal 0, exit_code
    assert_empty validator.errors
    assert_empty validator.warnings
  end

  def test_six_language_fixture_all_locales_matches_configured_languages
    validator = BilingualJekyllResumeTheme::ResumeValidator.new(SAMPLE_DATA_DIR, config_path: SAMPLE_CONFIG_PATH)
    validator.validate(quiet: true)

    assert_equal %w[ar de en es fr ur], validator.discover_languages.sort
  end

  # --- 2. Locale lookup falls back to the theme's gem-root locale ---------------------------

  def test_locale_for_falls_back_to_theme_locale_when_no_site_override
    Dir.mktmpdir("test_locale_fallback_") do |tmp|
      # No <tmp>/locales directory at all: locale_for must resolve purely from the theme.
      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp)

      expected = YAML.safe_load_file(File.join(THEME_LOCALES_DIR, "es.yml"))
      assert_equal expected, validator.locale_for("es")
      assert_equal "Español", validator.locale_for("es")["ui"]["language_name"]
    end
  end

  def test_locale_for_returns_nil_when_neither_theme_nor_site_locale_exists
    Dir.mktmpdir("test_locale_missing_") do |tmp|
      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp)
      assert_nil validator.locale_for("zz")
    end
  end

  # --- 3. Partial site override merges over the theme locale (no missing-key warnings) ------

  def test_partial_site_override_merges_over_theme_locale_without_parity_warnings
    Dir.mktmpdir("test_partial_override_") do |tmp|
      write_minimal_language_dir(tmp, "en")
      write_minimal_language_dir(tmp, "es")
      # Only one key overridden; everything else must still come from the theme's es.yml.
      write_yaml(File.join(tmp, "locales", "es.yml"), "ui" => { "section_titles" => { "experience" => "Mi Experiencia" } })

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      exit_code = validator.validate(languages: %w[en es], quiet: true)

      merged = validator.locale_for("es")
      assert_equal "Mi Experiencia", merged["ui"]["section_titles"]["experience"], "site override key must win"
      assert_equal "Español", merged["ui"]["language_name"], "un-overridden keys must still come from the theme locale"

      assert_empty validator.errors
      refute(validator.warnings.any? { |w| w[:context].to_s.start_with?("Locale es") },
             "a merged (theme + partial override) locale must not warn about missing keys: #{validator.warnings}")
      assert_equal 0, exit_code
    end
  end

  # --- 4. A site array (present_values) fully replaces the theme's array ---------------------

  def test_site_present_values_array_replaces_theme_array_instead_of_merging
    Dir.mktmpdir("test_array_replace_") do |tmp|
      write_yaml(File.join(tmp, "locales", "de.yml"), "present_values" => ["Nur"])

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp)
      aliases = validator.present_aliases_for("de")

      assert_includes aliases, "Nur"
      # Theme de.yml's own present_values ("present", "heute", "aktuell") must be gone, not merged in.
      refute_includes aliases, "heute"
      refute_includes aliases, "aktuell"
      # ui.present ("Heute", theme-only key untouched by the array override) still merges in normally.
      assert_includes aliases, "Heute"
    end
  end

  # --- 5. An incomplete site-only locale (no theme counterpart) warns on missing keys -------

  def test_site_only_locale_with_no_theme_counterpart_warns_on_missing_keys
    Dir.mktmpdir("test_site_only_locale_") do |tmp|
      write_minimal_language_dir(tmp, "en")
      write_minimal_language_dir(tmp, "xx")
      # "xx" has no theme-side _data/locales/xx.yml, so this tiny site file is used as-is.
      write_yaml(File.join(tmp, "locales", "xx.yml"), "ui" => { "present" => "Xx" })

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      validator.validate(languages: %w[en xx], quiet: true)

      xx_warning = validator.warnings.find { |w| w[:context] == "Locale xx" }
      refute_nil xx_warning, "expected a missing-key warning for the incomplete site-only 'xx' locale"
      assert_match(/Missing key\(s\)/, xx_warning[:message])
    end
  end

  # --- 6. Missing locale keys are warnings, never errors -------------------------------------

  def test_missing_locale_keys_warn_but_never_error_and_exit_code_reflects_fail_on_warnings
    Dir.mktmpdir("test_warnings_not_errors_") do |tmp|
      write_minimal_language_dir(tmp, "en")
      write_minimal_language_dir(tmp, "xx")
      write_yaml(File.join(tmp, "locales", "xx.yml"), "ui" => { "present" => "Xx" })

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      exit_code = validator.validate(languages: %w[en xx], quiet: true)

      assert_empty validator.errors
      refute_empty validator.warnings
      assert_equal 0, exit_code, "warnings alone must not fail the build"

      validator2 = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      strict_exit_code = validator2.validate(languages: %w[en xx], quiet: true, fail_on_warnings: true)
      assert_equal 1, strict_exit_code, "fail_on_warnings: true must turn warnings into a failing exit code"
    end
  end

  # --- 7. A declared language with no locale, or no data folder, is an error (exit 1) --------

  def test_declared_language_with_no_resolvable_locale_is_an_error
    Dir.mktmpdir("test_no_locale_") do |tmp|
      write_minimal_language_dir(tmp, "en")
      write_minimal_language_dir(tmp, "zz") # "zz" has no theme locale and no site locale override.

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      exit_code = validator.validate(languages: %w[en zz], quiet: true)

      assert_equal 1, exit_code
      assert(validator.errors.any? { |e| e[:message].include?("No locale found for 'zz'") })
    end
  end

  def test_declared_language_with_no_data_folder_is_an_error
    Dir.mktmpdir("test_no_data_folder_") do |tmp|
      write_minimal_language_dir(tmp, "en")
      # "es" has a theme locale but no data folder at all under tmp.

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      exit_code = validator.validate(languages: %w[en es], quiet: true)

      assert_equal 1, exit_code
      assert(validator.errors.any? { |e| e[:message].include?("does not exist") })
    end
  end

  # --- 8. Plugin default-on behavior and its `validate_resume: false` opt-out ----------------

  # Minimal Jekyll::Site double: the generator only calls #config and #in_source_dir.
  FakeSite = Struct.new(:config, :source_root) do
    def in_source_dir(path)
      File.expand_path(path, source_root)
    end
  end

  def test_generator_validates_by_default_and_strict_mode_raises_on_errors
    Dir.mktmpdir("test_plugin_default_on_") do |tmp|
      FileUtils.mkdir_p(File.join(tmp, "_data")) # data dir exists, but the declared language folder does not.
      config = {
        "data_dir" => "_data",
        "languages" => { "xx" => { "data_path" => "xx" } },
        "validate_resume_strict" => true
        # "validate_resume" intentionally omitted: must default to on.
      }
      site = FakeSite.new(config, tmp)
      generator = BilingualJekyllResumeTheme::ResumeValidatorGenerator.new

      assert_raises(Jekyll::Errors::FatalException) do
        capture_io { generator.generate(site) }
      end
    end
  end

  def test_generator_validate_resume_false_short_circuits_even_in_strict_mode
    Dir.mktmpdir("test_plugin_opt_out_") do |tmp|
      FileUtils.mkdir_p(File.join(tmp, "_data")) # same broken config as above...
      config = {
        "data_dir" => "_data",
        "languages" => { "xx" => { "data_path" => "xx" } },
        "validate_resume_strict" => true,
        "validate_resume" => false # ...but explicitly opted out.
      }
      site = FakeSite.new(config, tmp)
      generator = BilingualJekyllResumeTheme::ResumeValidatorGenerator.new

      capture_io { generator.generate(site) } # must not raise
    end
  end

  # --- 9. Strict mode: raises on errors, stays quiet on a clean run --------------------------

  def test_generator_strict_mode_does_not_raise_on_clean_six_language_data
    config = @sample_config.merge(
      "data_dir" => "demo/_data",
      "validate_resume_strict" => true
    )
    site = FakeSite.new(config, REPO_ROOT)
    generator = BilingualJekyllResumeTheme::ResumeValidatorGenerator.new

    capture_io { generator.generate(site) } # must not raise: demo/_data validates cleanly
  end

  # --- 10. Schema-level negative paths: malformed YAML, invalid URL, inverted dates, ---------
  # --- and a data-file parity mismatch across languages ---------------------------------------

  def test_malformed_yaml_file_is_a_syntax_error_and_fails_the_build
    Dir.mktmpdir("test_malformed_yaml_") do |tmp|
      FileUtils.mkdir_p(File.join(tmp, "en"))
      File.write(File.join(tmp, "en", "header.yml"), "active: true\n  bad indent: [broken\n")

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      exit_code = validator.validate(languages: %w[en], quiet: true)

      assert_equal 1, exit_code
      assert(validator.errors.any? { |e| e[:message].include?("YAML Syntax Error") })
    end
  end

  def test_invalid_url_format_is_an_error
    Dir.mktmpdir("test_invalid_url_") do |tmp|
      write_yaml(File.join(tmp, "en", "links.yml"),
                 [{ "active" => true, "description" => "Bad Link", "url" => "not a valid url" }])

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      exit_code = validator.validate(languages: %w[en], quiet: true)

      assert_equal 1, exit_code
      assert(validator.errors.any? { |e| e[:message].include?("Invalid URL format") })
    end
  end

  def test_inverted_date_range_is_an_error
    Dir.mktmpdir("test_inverted_dates_") do |tmp|
      write_yaml(File.join(tmp, "en", "experience.yml"),
                 [{ "active" => true, "company" => "Acme", "position" => "Engineer",
                    "startdate" => "2020-01-01", "enddate" => "2019-01-01" }])

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      exit_code = validator.validate(languages: %w[en], quiet: true)

      assert_equal 1, exit_code
      assert(validator.errors.any? { |e| e[:message].include?("Date range error") })
    end
  end

  def test_data_file_parity_mismatch_is_flagged_across_languages
    Dir.mktmpdir("test_data_file_parity_") do |tmp|
      write_minimal_language_dir(tmp, "en")
      write_minimal_language_dir(tmp, "ar")
      # education.yml exists only for "en"; "ar" has no counterpart.
      write_yaml(File.join(tmp, "en", "education.yml"),
                 [{ "active" => true, "uni" => "MIT", "degree" => "BSc" }])

      validator = BilingualJekyllResumeTheme::ResumeValidator.new(tmp, primary_locale: "en")
      validator.validate(languages: %w[en ar], quiet: true)

      assert(validator.warnings.any? { |w| w[:context] == "Parity" && w[:message].include?("education.yml") },
             "expected a data-file parity warning for the language missing education.yml")
    end
  end
end
