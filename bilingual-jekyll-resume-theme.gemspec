# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "bilingual-jekyll-resume-theme"
  spec.version       = "0.9.0"
  spec.authors       = ["Khaldoon Mutahar"]
  spec.email         = ["contact@mutahar.me"]

  spec.summary       = "A flexible Jekyll theme for creating a clean, data-driven, bilingual (English & Arabic) resume."
  spec.homepage      = "https://www.mutahr.me/bilingual-jekyll-resume-theme"
  spec.license       = "MIT"

  spec.platform      = Gem::Platform::RUBY # Specifies this is a pure Ruby gem (works on all platforms)
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata      = {
    "bug_tracker_uri"   => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues",
    "changelog_uri"     => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/kmutahar/bilingual-jekyll-resume-theme#readme",
    "homepage_uri"      =>  spec.homepage,
    "source_code_uri"   => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/",
    "allowed_push_host" => "https://rubygems.org" # Security lock to prevent pushing to wrong host
  }

  tracked_files = `git ls-files -z`.split("\x0")
  spec.files         = (tracked_files + Dir["_plugins/**/*", "lib/**/*", "bin/validate-resume"]).uniq.select do |f|
    f.match(%r!^(assets|_data|_layouts|_includes|_sass|_plugins|lib|bin|LICENSE|README|CHANGELOG|CODE_OF_CONDUCT|docs|404|403|500)!i) && File.file?(f) && f != "bin/release"
  end

  spec.bindir        = "bin"
  spec.executables   = ["validate-resume"]

  # --- A helpful message shown to users after installation ---
  spec.post_install_message = <<~MSG
    --------------------------------------------------
    Thank you for installing bilingual-jekyll-resume-theme!
    
    To get started, check the setup instructions:
    https://github.com/kmutahar/bilingual-jekyll-resume-theme#readme
    --------------------------------------------------
  MSG

  # --- UPDATED: Runtime Dependencies ---
  # Allows any version from 4.4.0 up to (but not including) 5.0
  spec.add_runtime_dependency "jekyll", "~> 4.4"

  # --- PLUGIN DEPENDENCIES ---
  spec.add_runtime_dependency "jekyll-feed", "~> 0.17"
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.9"
  spec.add_runtime_dependency "jekyll-sitemap", "~> 1.4"
  spec.add_runtime_dependency "jekyll-redirect-from", "~> 0.16"
  spec.add_runtime_dependency "logger", "~> 1.7"  # Future-proof: 'logger' will be removed from the Ruby 3.5.0+ standard library.

  # --- Development Dependencies (verification tooling; never installed for theme consumers) ---
  spec.add_development_dependency "html-proofer", "~> 5.2"      # `rake proof`: dead links, anchors, images, hreflang
  spec.add_development_dependency "minitest", "~> 5.25"         # `rake test`: unit tests
  spec.add_development_dependency "rubocop", "~> 1.75"          # `rake rubocop`: static analysis
  spec.add_development_dependency "rubocop-performance", "~> 1.25"
  spec.add_development_dependency "rubocop-rake", "~> 0.7"
end
