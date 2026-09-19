# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "bilingual-jekyll-resume-theme"
  spec.version       = "0.8.0"
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

  # Autoload theme generator plugins when Jekyll inspects theme runtime dependencies
  class Gem::Specification
    unless method_defined?(:_orig_theme_runtime_dependencies)
      alias_method :_orig_theme_runtime_dependencies, :runtime_dependencies
      def runtime_dependencies
        if name == "bilingual-jekyll-resume-theme" && defined?(Jekyll::Generator)
          plugin = File.join(full_gem_path, "_plugins", "error_pages_generator.rb")
          require plugin if File.exist?(plugin)
        end
        _orig_theme_runtime_dependencies
      end
    end
  end

  tracked_files = `git ls-files -z`.split("\x0")
  spec.files         = (tracked_files + Dir["_plugins/**/*", "lib/**/*"]).uniq.select do |f|
    f.match(%r!^(assets|_data|_layouts|_includes|_sass|_plugins|lib|LICENSE|README|CHANGELOG|CODE_OF_CONDUCT|docs|404|403|500)!i) && File.file?(f)
  end

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
end
