# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "bilingual-jekyll-resume-theme"
  spec.version       = "0.4.0"
  spec.authors       = ["Khaldoon Mutahar"]
  spec.email         = ["contact@mutahar.me"]

  spec.summary       = "A flexible Jekyll theme for creating a clean, data-driven, bilingual (English & Arabic) resume."
  spec.homepage      = "https://www.mutahr.me/bilingual-jekyll-resume-theme"
  spec.license       = "MIT"

  spec.platform      = Gem::Platform::RUBY # Specifies this is a pure Ruby gem (works on all platforms)

  spec.metadata      = {
    "bug_tracker_uri"   => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues",
    "changelog_uri"     => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/kmutahar/bilingual-jekyll-resume-theme#readme",
    "homepage_uri"      =>  spec.homepage,
    "source_code_uri"   => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/",
    "allowed_push_host" => "https://rubygems.org" # Security lock to prevent pushing to wrong host
  }

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_data|_layouts|_includes|_sass|LICENSE|README|CHANGELOG|CODE_OF_CONDUCT|docs)!i) }

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
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.8"
  spec.add_runtime_dependency "jekyll-sitemap", "~> 1.4"
  spec.add_runtime_dependency "jekyll-redirect-from", "~> 0.16"
  spec.add_runtime_dependency "logger", "~> 1.7"  # Future-proof: 'logger' will be removed from the Ruby 3.5.0+ standard library.
end
