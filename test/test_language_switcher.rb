# frozen_string_literal: true

begin
  require "minitest/autorun"
rescue LoadError
  # When running in an isolated bundler sandbox where minitest is not declared in Gemfile,
  # locate the system minitest gem and load it directly.
  minitest_lib = Dir.glob(File.expand_path("~/.rbenv/versions/*/lib/ruby/gems/*/gems/minitest-*/lib")).first ||
                 Dir.glob("/home/*/.rbenv/versions/*/lib/ruby/gems/*/gems/minitest-*/lib").first
  raise unless minitest_lib && File.directory?(minitest_lib)

  $LOAD_PATH.unshift(minitest_lib)
  load File.join(minitest_lib, "minitest", "autorun.rb")
end

require "jekyll"
require "jekyll-seo-tag"
require "fileutils"
require "tmpdir"

# Six-language language switcher coverage against the current unified `layout: resume` +
# `_includes/language-switcher.html` model (site.languages config, site.data.locales/<lang>.yml).
# Replaces the old two-language (resume-en.html/resume-ar.html) assumption.
class LanguageSwitcherTest < Minitest::Test
  ROOT_DIR = File.expand_path("..", __dir__)

  # Native display name and text direction per language, sourced from _data/locales/<lang>.yml
  # (read directly in the assertions below, not hardcoded here as ground truth).
  LANGUAGES = %w[en ar es fr de ur].freeze

  class << self
    # Builds one shared Jekyll site fixture for every rendering test in this file, since
    # Jekyll::Site#process is comparatively expensive and every test in this class exercises
    # variations on the same six-language switcher output.
    def fixture
      @fixture ||= build_fixture_site
    end

    def build_fixture_site
      site_dir = Dir.mktmpdir("lang_switcher_site_")
      dest_dir = Dir.mktmpdir("lang_switcher_dest_")
      Minitest.after_run do
        FileUtils.rm_rf(site_dir)
        FileUtils.rm_rf(dest_dir)
      end

      # Only the theme pieces the resume/default/error layouts and the switcher include
      # actually touch: _includes, _layouts, _sass (for a clean SCSS build) and _data/locales.
      %w[_includes _layouts _sass _data].each do |d|
        src = File.join(ROOT_DIR, d)
        FileUtils.cp_r(src, site_dir) if File.exist?(src)
      end

      languages_config = LANGUAGES.to_h { |lang| [lang, { "data_path" => "", "url" => "/#{lang}/cv/" }] }

      LANGUAGES.each do |lang|
        File.write(File.join(site_dir, "#{lang}.html"), <<~FRONT_MATTER)
          ---
          layout: resume
          lang: #{lang}
          permalink: /#{lang}/cv/
          ---
        FRONT_MATTER
      end

      File.write(File.join(site_dir, "disabled-page.html"), <<~FRONT_MATTER)
        ---
        layout: resume
        lang: en
        permalink: /disabled/
        language_switcher: false
        ---
      FRONT_MATTER

      File.write(File.join(site_dir, "error-test.html"), <<~FRONT_MATTER)
        ---
        layout: error
        permalink: /error-test.html
        ---
      FRONT_MATTER

      config = Jekyll.configuration(
        "source" => site_dir,
        "destination" => dest_dir,
        "quiet" => true,
        "plugins" => ["jekyll-seo-tag"],
        "resume_language_switcher" => true,
        "resume_avatar" => false,
        "display_header_contact_info" => false,
        "resume_section" => {},
        "resume_section_order" => [],
        "resume_print_social_links" => false,
        "validate_resume" => false,
        "languages" => languages_config,
        "default_lang" => "en"
      )

      site = Jekyll::Site.new(config)
      site.process

      { site: site, site_dir: site_dir, dest_dir: dest_dir }
    end
  end

  def setup
    @fixture = self.class.fixture
    @dest_dir = @fixture[:dest_dir]
  end

  def locale_ui(lang, *keys)
    data = YAML.safe_load_file(File.join(ROOT_DIR, "_data", "locales", "#{lang}.yml"))
    keys.reduce(data) { |node, key| node[key] }
  end

  def page_html(relative_path)
    path = File.join(@dest_dir, relative_path)
    assert File.exist?(path), "expected #{relative_path} to have been built"
    File.read(path)
  end

  # --- 1. Static wiring: the include exists and every consuming layout references it ---

  def test_language_switcher_include_exists
    include_path = File.join(ROOT_DIR, "_includes", "language-switcher.html")
    assert File.exist?(include_path), "_includes/language-switcher.html must exist"
  end

  def test_resume_and_default_layouts_include_switcher
    resume_layout = File.read(File.join(ROOT_DIR, "_layouts", "resume.html"))
    default_layout = File.read(File.join(ROOT_DIR, "_layouts", "default.html"))

    assert_includes resume_layout, "language-switcher.html", "_layouts/resume.html must include language-switcher.html"
    assert_includes default_layout, "language-switcher.html", "_layouts/default.html must include language-switcher.html"
  end

  # --- 2. SCSS positioning (fixed top-left LTR, mirrored top-right RTL) ---

  def test_scss_defines_language_switcher_positioning
    layout_scss = File.read(File.join(ROOT_DIR, "_sass", "_layout.scss"))
    main_scss = File.read(File.join(ROOT_DIR, "assets", "css", "main.scss"))

    assert_includes layout_scss, ".language-switcher", "_sass/_layout.scss must define .language-switcher styles"
    assert_includes layout_scss, "position: fixed", "_sass/_layout.scss must position .language-switcher fixed"
    assert_includes layout_scss, "left: 1.25rem", "_sass/_layout.scss must position .language-switcher at left: 1.25rem"
    assert_includes main_scss, '@use "layout"', "assets/css/main.scss must import @use 'layout'"
  end

  def test_scss_rtl_mirrors_language_switcher
    rtl_scss = File.read(File.join(ROOT_DIR, "_sass", "_resume-rtl.scss"))

    assert_includes rtl_scss, ".language-switcher", "_sass/_resume-rtl.scss must mirror .language-switcher styles"
    assert_includes rtl_scss, "right: 1.25rem", "_sass/_resume-rtl.scss must mirror .language-switcher to right: 1.25rem"
  end

  # --- 3. Rendering: every language's resume page links to the other five, never itself ---

  def test_switcher_links_to_every_other_language_and_never_itself
    LANGUAGES.each do |lang|
      html = page_html(File.join(lang, "cv", "index.html"))

      other_langs = LANGUAGES - [lang]
      other_langs.each do |target|
        assert_includes html, %(href="/#{target}/cv/"), "#{lang} resume must link to /#{target}/cv/"
        target_name = locale_ui(target, "ui", "language_name")
        assert_includes html, %(title="#{target_name}"), "#{lang} resume link to #{target} must carry its native title"
        assert_includes html, %(aria-label="#{target_name}"), "#{lang} resume link to #{target} must carry its native aria-label"
      end

      refute_match(%r{<a href="/#{lang}/cv/"[\s\S]*?class="lang-switch-btn"}, html,
                   "#{lang} resume must not link the switcher to itself")
      assert_equal other_langs.size, html.scan('class="lang-switch-btn"').size,
                   "#{lang} resume switcher must render exactly #{other_langs.size} links (every other language)"
    end
  end

  # Extracts the single <a class="lang-switch-btn" ...>...</a> block pointing at a given
  # target language's URL, tolerating the include's multi-line attribute formatting.
  def switch_link_block(html, target_href)
    match = html.match(%r{<a href="#{Regexp.escape(target_href)}"[\s\S]*?</a>})
    refute_nil match, "expected a lang-switch-btn link to #{target_href}"
    match[0]
  end

  def test_switcher_links_carry_target_language_direction
    en_html = page_html(File.join("en", "cv", "index.html"))

    ar_link = switch_link_block(en_html, "/ar/cv/")
    assert_includes ar_link, 'dir="rtl"', "EN resume switcher link to Arabic must be marked dir=\"rtl\""

    es_link = switch_link_block(en_html, "/es/cv/")
    assert_includes es_link, 'dir="ltr"', "EN resume switcher link to Spanish must be marked dir=\"ltr\""
  end

  def test_switcher_wrapper_aria_label_uses_current_page_locale
    en_html = page_html(File.join("en", "cv", "index.html"))
    ar_html = page_html(File.join("ar", "cv", "index.html"))

    en_label = locale_ui("en", "ui", "language_switcher")
    ar_label = locale_ui("ar", "ui", "language_switcher")

    assert_includes en_html, %(<div class="language-switcher no-print" role="navigation" aria-label="#{en_label}">),
                    "EN page switcher wrapper must use EN's own language_switcher label"
    assert_includes ar_html, %(<div class="language-switcher no-print" role="navigation" aria-label="#{ar_label}">),
                    "AR page switcher wrapper must use AR's own language_switcher label"
  end

  # --- 4. Toggles: page-level override, error layout suppression, site-wide override ---

  def test_page_level_override_disables_switcher
    html = page_html(File.join("disabled", "index.html"))
    refute_includes html, "lang-switch-btn", "Page with language_switcher: false must not render the switcher"
  end

  def test_error_layout_suppresses_switcher
    html = page_html("error-test.html")
    refute_includes html, "lang-switch-btn", "Error layout must never render the language switcher"
  end

  def test_site_wide_config_disables_switcher
    site = @fixture[:site]
    site.config["resume_language_switcher"] = false
    site.process

    html = page_html(File.join("en", "cv", "index.html"))
    refute_includes html, "lang-switch-btn", "Site with resume_language_switcher: false must not render the switcher"
  ensure
    site.config["resume_language_switcher"] = true
    site.process
  end
end
