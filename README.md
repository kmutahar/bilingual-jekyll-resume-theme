# bilingual-jekyll-resume-theme

[![CI Test Suite](https://github.com/kmutahar/bilingual-jekyll-resume-theme/actions/workflows/ci.yml/badge.svg)](https://github.com/kmutahar/bilingual-jekyll-resume-theme/actions/workflows/ci.yml) [![Latest release](https://img.shields.io/github/v/release/kmutahar/bilingual-jekyll-resume-theme?display_name=tag)](https://github.com/kmutahar/bilingual-jekyll-resume-theme/releases) [![Gem Version](https://badge.fury.io/rb/bilingual-jekyll-resume-theme.svg?icon=si%3Arubygems)](https://badge.fury.io/rb/bilingual-jekyll-resume-theme)

A flexible Jekyll theme for clean, data-driven, multilingual resume/CV websites. Ships English, Arabic, Spanish, French, German, and Urdu; any other language is added from your site alone. Created and maintained by Khaldoon Mutahar. See the latest version on the [Releases page](https://github.com/kmutahar/bilingual-jekyll-resume-theme/releases).
Inspired by and originally forked from [Joel Glovier’s resume template](https://github.com/jglovier/resume-template/). Joel’s version was a basic English-only theme with limited customization (e.g., no section reordering); this project has since evolved into a fully separate theme authored by Khaldoon.

## Features

- **Multilingual support**: One layout (`resume.html`) renders every language, LTR or RTL, from per-language locale files (`_data/locales/<lang>.yml`) with localized UI strings, month names, and fonts (Cairo for Arabic, Noto Nastaliq Urdu for Urdu)
- **Dark mode**: System preference detection (`prefers-color-scheme`) with optional interactive toggle, `localStorage` persistence, and zero-FOUC inline script
- **Data-driven architecture**: All resume content stored in YAML files, supporting multiple data paths and versioning
- **12 resume sections**: Experience, Education, Certifications, Courses, Volunteering, Projects, Skills, Recognition, Associations, Languages, Links, Interests
- **WCAG 2.1 AA Accessible**: Full screen reader and keyboard accessibility with `.sr-only` labels and declarative aria attributes
- **Modern favicon suite**: High-resolution favicons (Apple touch icon, 32x32, 16x16, webmanifest) with subpath-safe URLs and `_config.yml` override support
- **Print-friendly**: Optimized for PDF generation and printing with bidirectional text isolation (`dir="ltr"`) for URLs
- **SEO ready**: Built-in support for multilingual SEO, standardized canonical tags via `jekyll-seo-tag`, sitemaps, and feeds
- **Data validation**: `validate-resume` CLI and build-time checks for schemas, dates, URLs, and parity across every configured language

## Quick Start

### Installation

1. Add to your Jekyll site's `Gemfile`, inside `group :jekyll_plugins`. A plain `gem "bilingual-jekyll-resume-theme"` line never requires the theme's `lib/bilingual-jekyll-resume-theme.rb`, so its bundled plugins (the error page generator and build-time validation) silently never run:
```ruby
group :jekyll_plugins do
  gem "bilingual-jekyll-resume-theme"
end
```

2. Add to your `_config.yml`:
```yaml
theme: bilingual-jekyll-resume-theme
```

3. Install dependencies:
```bash
bundle install
```

> **Upgrading from v0.9.0?** v1.0.0 removes the `resume-en` / `resume-ar` layouts and every `*_en` / `*_ar` config key with no compatibility aliases. Follow the migration table in the [Multilingual Guide](docs/MULTILINGUAL_GUIDE.md#breaking-changes--migration-v090-to-v100).

### Basic Setup

1. **Copy sample configuration**: Use `docs/_data/_config.sample.yml` as a starting point for your `_config.yml`. Keep a `languages.<lang>` entry for each language you publish and delete the rest.

2. **Copy sample data files**: Copy each language folder you need from `docs/_data/` (`en`, `ar`, `es`, `fr`, `de`, `ur`) to your site's `_data/`. Each holds 13 files, including `header.yml` for the intro paragraph.

3. **Create resume pages**: One page per language, all using the `resume` layout:
```yaml
---
layout: resume
lang: en
permalink: /en/cv/
t_id: resume
---
```

4. **Run the development server**:
```bash
bundle exec jekyll serve
```

Visit `http://localhost:4000` to see your resume!

## Documentation

This theme is fully documented. Choose the guide that fits your needs:

### 📘 [Configuration Guide](docs/CONFIG_GUIDE.md)
Complete guide to `_config.yml` settings. Learn how to configure sections, contact info, social links, analytics, and more. **Start here for beginners.**

### 🌐 [Multilingual Guide](docs/MULTILINGUAL_GUIDE.md)
Locale files, adding a language, overriding theme strings and fonts, RTL typography, and the **v0.9.0 to v1.0.0 migration table**.

### ✅ [Validation Guide](docs/VALIDATION_GUIDE.md)
The `validate-resume` CLI, build-time validation, rules per section, and CI setup.

### 📊 [Data Structure Guide](docs/DATA_GUIDE.md)
Detailed documentation of all 12 data file types (experience, education, skills, etc.) with examples. Learn how to structure your YAML files and what fields are required vs optional.

### 🎨 [Layouts Guide](docs/LAYOUTS_GUIDE.md)
Deep dive into how layouts work, how data flows through them, and how to create custom layouts. Useful for advanced customization.

### 🧩 [Includes Guide](docs/INCLUDES_GUIDE.md)
Understanding the theme's include system, how sections render, and how to add new sections or customize existing ones.

### 🎨 [SASS/SCSS Guide](docs/SASS_GUIDE.md)
Complete guide to the theme's styling system, how to customize colors/fonts, and how to override styles without forking the theme.

### 🗺️ [Project Overview](docs/PROJECT_OVERVIEW.md)
High-level architecture summary, repository conventions, layout hierarchy, and design philosophy.

### 📜 [Completed Historical Audit](docs/COMPLETED_AUDIT.md)
Permanent engineering record of historical bug fixes, security hardening, and architectural upgrades.

## Project Structure

```text
bilingual-jekyll-resume-theme/
├── _layouts/          # HTML templates (default, resume, profile, error)
├── _includes/         # Reusable components (section dispatcher, date formatter, avatar, toggles)
├── _sass/             # SCSS (LTR main styles, RTL overrides, dark mode tokens, print styles)
├── _plugins/          # Error page generator and build-time resume validator
├── _data/locales/     # Locale dictionaries: en, ar, es, fr, de, ur
├── lib/               # Gem entrypoint and validator engine
├── bin/               # validate-resume CLI
├── assets/            # CSS entrypoints (cv-ltr, cv-rtl), images, favicons
└── docs/              # Documentation, demo pages, and sample files
    ├── _data/         # Sample config and six-language demo data (copy to your site's _data/)
    └── *.md           # Documentation guides
```

## Key Concepts

### Data Paths

Each language reads its data from the folder named by `languages.<lang>.data_path`:
```yaml
languages:
  en:
    data_path: en   # _data/en/*
  ar:
    data_path: ar   # _data/ar/*
```

Use one folder per language even for a single-language site; adding a language later is then one more folder. Dot paths (`"2025-06.v1"`) select nested, versioned datasets, and `""` reads `_data/` itself.

See the [Configuration Guide](docs/CONFIG_GUIDE.md#3-languages) for every per-language key.

### Sample Files

`docs/_data/{en,ar,es,fr,de,ur}/` hold a complete Sherlock Holmes demo resume in six languages, covering all 12 section types. Copy the folders you need to your site.

### Locales

Month names, "Present" labels, section titles, fonts, and text direction come from `_data/locales/<lang>.yml`, shipped inside the gem for all six languages. Override single strings or add a new language from your site's own `_data/locales/`; see the [Multilingual Guide](docs/MULTILINGUAL_GUIDE.md).

## Development

To develop this theme locally:

```bash
# Install dependencies
bundle install

# Serve the six-language demo (sample config + demo overlay pointing data_dir at docs/_data)
bundle exec jekyll serve --config docs/_data/_config.sample.yml,docs/_data/_config.demo.yml

# Build static output
bundle exec jekyll build --config docs/_data/_config.sample.yml,docs/_data/_config.demo.yml

# Validate resume data schemas and parity (CLI or Rake)
./bin/validate-resume docs/_data
bundle exec rake validate

# Check that the theme's own templates only reference real data keys (CLI or Rake)
./bin/check-data-keys docs/_data
bundle exec rake check_data_keys

# Validators, RuboCop, and tests together
bundle exec rake

# Build the gem
gem build bilingual-jekyll-resume-theme.gemspec
```

For more details on resume schema checks, see [VALIDATION_GUIDE.md](docs/VALIDATION_GUIDE.md). Contributor and agent rules are in [AGENTS.md](AGENTS.md).

## Requirements

- Ruby 3.3+ (standard support on Ruby 3.3, 3.4, 4.0+; Ruby <= 3.2 is EOL)
- Jekyll 4.4+ (specified in `bilingual-jekyll-resume-theme.gemspec`)
- Required plugins (automatically included):
  - `jekyll-feed`
  - `jekyll-seo-tag`
  - `jekyll-sitemap`
  - `jekyll-redirect-from`

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## License

The theme is available as open source under the terms of the [MIT License](LICENSE.txt).

## Support

- 📖 Check the [documentation guides](docs/) for detailed information
- 🐛 Report issues on [GitHub Issues](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues)
- 💡 See [PROJECT_OVERVIEW.md](docs/PROJECT_OVERVIEW.md) for a high-level architecture overview
- 📜 See [COMPLETED_AUDIT.md](docs/COMPLETED_AUDIT.md) for historical remediations and architectural decisions

---

**Created by Khaldoon Mutahar** | MIT License

