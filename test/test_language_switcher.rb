# frozen_string_literal: true

require 'jekyll'
require 'tmpdir'
require 'fileutils'

class LanguageSwitcherTest
  attr_reader :failures, :passes

  def initialize
    @passes = 0
    @failures = []
  end

  def assert(condition, message)
    if condition
      @passes += 1
      print '.'
    else
      @failures << message
      print 'F'
    end
  end

  def assert_equal(expected, actual, message)
    assert(expected == actual, "#{message} (Expected: #{expected.inspect}, got: #{actual.inspect})")
  end

  def assert_includes(collection, item, message)
    assert(collection && collection.include?(item), "#{message} (Expected to find #{item.inspect} in content)")
  end

  def refute_includes(collection, item, message)
    assert(collection && !collection.include?(item), "#{message} (Expected NOT to find #{item.inspect} in content)")
  end

  def run
    puts "\nRunning Language Switcher Test Suite..."

    test_file_existence
    test_layout_integration
    test_scss_rules
    test_rendering_behavior

    puts "\n\nResults:"
    puts "Passed: #{@passes}"
    puts "Failures: #{@failures.length}"

    if @failures.any?
      puts "\nFailure Details:"
      @failures.each_with_index do |f, i|
        puts "  #{i + 1}) #{f}"
      end
      exit 1
    else
      puts "\nAll tests passed successfully!"
      exit 0
    end
  end

  private

  def root_dir
    File.expand_path('..', __dir__)
  end

  def test_file_existence
    include_path = File.join(root_dir, '_includes', 'language-switcher.html')
    assert(File.exist?(include_path), "File _includes/language-switcher.html must exist")
  end

  def test_layout_integration
    en_layout = File.read(File.join(root_dir, '_layouts', 'resume-en.html'))
    ar_layout = File.read(File.join(root_dir, '_layouts', 'resume-ar.html'))
    default_layout = File.read(File.join(root_dir, '_layouts', 'default.html'))

    assert_includes(en_layout, 'language-switcher.html', "_layouts/resume-en.html must include language-switcher.html")
    assert_includes(ar_layout, 'language-switcher.html', "_layouts/resume-ar.html must include language-switcher.html")
    assert_includes(default_layout, 'language-switcher.html', "_layouts/default.html must include language-switcher.html")
  end

  def test_scss_rules
    layout_scss = File.read(File.join(root_dir, '_sass', '_layout.scss'))
    rtl_scss = File.read(File.join(root_dir, '_sass', '_resume-rtl.scss'))
    main_scss = File.read(File.join(root_dir, 'assets', 'css', 'main.scss'))

    assert_includes(layout_scss, '.language-switcher', "_sass/_layout.scss must define .language-switcher styles")
    assert_includes(layout_scss, 'position: fixed', "_sass/_layout.scss must position .language-switcher fixed")
    assert_includes(layout_scss, 'left: 1.25rem', "_sass/_layout.scss must position .language-switcher at left: 1.25rem")

    assert_includes(rtl_scss, '.language-switcher', "_sass/_resume-rtl.scss must mirror .language-switcher styles")
    assert_includes(rtl_scss, 'right: 1.25rem', "_sass/_resume-rtl.scss must mirror .language-switcher to right: 1.25rem")

    assert_includes(main_scss, '@use "layout"', "assets/css/main.scss must import @use 'layout'")
  end

  def test_rendering_behavior
    include_file = File.join(root_dir, '_includes', 'language-switcher.html')
    return unless File.exist?(include_file)

    Dir.mktmpdir('jekyll_test_site') do |site_dir|
      Dir.mktmpdir('jekyll_test_dest') do |dest_dir|
        # Copy theme _includes, _layouts, _sass, _data into temp site
        %w[_includes _layouts _sass _data].each do |d|
          src = File.join(root_dir, d)
          FileUtils.cp_r(src, site_dir) if File.exist?(src)
        end

        # Create test pages
        File.write(File.join(site_dir, 'resume-en.html'), <<~HTML)
          ---
          layout: resume-en
          permalink: /resume/en/
          lang: en
          t_id: resume
          ---
        HTML

        File.write(File.join(site_dir, 'resume-ar.html'), <<~HTML)
          ---
          layout: resume-ar
          permalink: /resume/ar/
          lang: ar
          t_id: resume
          ---
        HTML

        File.write(File.join(site_dir, 'disabled-page.html'), <<~HTML)
          ---
          layout: resume-en
          permalink: /resume/disabled/
          lang: en
          language_switcher: false
          ---
        HTML

        File.write(File.join(site_dir, 'error-test.html'), <<~HTML)
          ---
          layout: error
          permalink: /error-test.html
          ---
        HTML

        # Base config
        config = Jekyll.configuration({
          'source' => site_dir,
          'destination' => dest_dir,
          'quiet' => true,
          'resume_language_switcher' => true,
          'resume_en_url' => '/resume/en/',
          'resume_ar_url' => '/resume/ar/'
        })

        site = Jekyll::Site.new(config)
        site.process

        # Test English resume output
        en_out_file = File.join(dest_dir, 'resume', 'en', 'index.html')
        assert(File.exist?(en_out_file), "English resume fixture should build")
        if File.exist?(en_out_file)
          en_html = File.read(en_out_file)
          assert_includes(en_html, 'class="language-switcher no-print"', "EN resume contains .language-switcher.no-print")
          assert_includes(en_html, 'class="lang-switch-btn"', "EN resume contains .lang-switch-btn")
          assert_includes(en_html, 'href="/resume/ar/"', "EN resume switcher links to Arabic resume URL")
          assert_includes(en_html, 'عربي', "EN resume switcher button label displays 'عربي'")
          assert_includes(en_html, 'aria-label="التحويل إلى اللغة العربية"', "EN resume switcher has Arabic aria-label")
          assert_includes(en_html, 'title="العربية"', "EN resume switcher has Arabic title")
        end

        # Test Arabic resume output
        ar_out_file = File.join(dest_dir, 'resume', 'ar', 'index.html')
        assert(File.exist?(ar_out_file), "Arabic resume fixture should build")
        if File.exist?(ar_out_file)
          ar_html = File.read(ar_out_file)
          assert_includes(ar_html, 'class="language-switcher no-print"', "AR resume contains .language-switcher.no-print")
          assert_includes(ar_html, 'class="lang-switch-btn"', "AR resume contains .lang-switch-btn")
          assert_includes(ar_html, 'href="/resume/en/"', "AR resume switcher links to English resume URL")
          assert_includes(ar_html, 'EN', "AR resume switcher button label displays 'EN'")
          assert_includes(ar_html, 'aria-label="Switch language to English"', "AR resume switcher has English aria-label")
          assert_includes(ar_html, 'title="English"', "AR resume switcher has English title")
        end

        # Test page-level override
        disabled_out_file = File.join(dest_dir, 'resume', 'disabled', 'index.html')
        if File.exist?(disabled_out_file)
          disabled_html = File.read(disabled_out_file)
          refute_includes(disabled_html, 'lang-switch-btn', "Page with language_switcher: false must not render switcher")
        end

        # Test error layout suppression
        error_out_file = File.join(dest_dir, 'error-test.html')
        if File.exist?(error_out_file)
          error_html = File.read(error_out_file)
          refute_includes(error_html, 'lang-switch-btn', "Error layout must not render language switcher")
        end

        # Test site-wide config override
        site.config['resume_language_switcher'] = false
        site.process
        if File.exist?(en_out_file)
          disabled_site_html = File.read(en_out_file)
          refute_includes(disabled_site_html, 'lang-switch-btn', "Site with resume_language_switcher: false must not render switcher")
        end
      end
    end
  end
end

LanguageSwitcherTest.new.run
