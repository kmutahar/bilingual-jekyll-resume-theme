# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "bilingual-jekyll-resume-theme"
  spec.version       = "0.3.1"
  spec.authors       = ["Khaldoon Mutahar"]
  spec.email         = ["contact@mutahar.me"]

  spec.summary       = "A flexible Jekyll theme for creating a clean, data-driven, bilingual (English & Arabic) resume."
  spec.homepage      = "https://www.mutahr.me/bilingual-jekyll-resume-theme"
  spec.license       = "MIT"

  spec.metadata      = {
    "bug_tracker_uri"   => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues",
    "changelog_uri"     => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/kmutahar/bilingual-jekyll-resume-theme#readme",
    "homepage_uri"      =>  spec.homepage,
    "source_code_uri"   => "https://github.com/kmutahar/bilingual-jekyll-resume-theme/",
  }

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_data|_layouts|_includes|_sass|LICENSE|README|CHANGELOG|CODE_OF_CONDUCT|docs)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.4"

  # --- PLUGIN DEPENDENCIES ---
  spec.add_runtime_dependency "jekyll-feed"
  spec.add_runtime_dependency "jekyll-seo-tag"
  spec.add_runtime_dependency "jekyll-sitemap"
  spec.add_runtime_dependency "jekyll-redirect-from"
  spec.add_runtime_dependency "logger" # Future-proof: 'logger' will be removed from the Ruby 3.5.0+ standard library.
end