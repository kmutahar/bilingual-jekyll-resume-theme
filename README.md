# bilingual-jekyll-resume-theme

[![CI Test Suite](https://github.com/kmutahar/bilingual-jekyll-resume-theme/actions/workflows/ci.yml/badge.svg)](https://github.com/kmutahar/bilingual-jekyll-resume-theme/actions/workflows/ci.yml) [![Latest release](https://img.shields.io/github/v/release/kmutahar/bilingual-jekyll-resume-theme?display_name=tag)](https://github.com/kmutahar/bilingual-jekyll-resume-theme/releases) [![Gem Version](https://badge.fury.io/rb/bilingual-jekyll-resume-theme.svg?icon=si%3Arubygems)](https://badge.fury.io/rb/bilingual-jekyll-resume-theme)

A flexible Jekyll theme for clean, data-driven, multilingual resume/CV websites. Ships English, Arabic, Spanish, French, German, and Urdu; any other language is added from your site alone. Created and maintained by Khaldoon Mutahar. See the latest version on the [Releases page](https://github.com/kmutahar/bilingual-jekyll-resume-theme/releases).
Inspired by and originally forked from [Joel Glovier’s resume template](https://github.com/jglovier/resume-template/). Joel’s version was a basic English-only theme with limited customization (e.g., no section reordering); this project has since evolved into a fully separate theme authored by Khaldoon.

## Features

- **Multilingual support**: One layout (`resume.html`) renders every language, LTR or RTL, from per-language locale files (`_data/locales/<lang>.yml`) with localized UI strings, month names, and fonts (Cairo for Arabic, Noto Nastaliq Urdu for Urdu)
- **Dark mode**: System preference detection (`prefers-color-scheme`) with optional interactive toggle, `localStorage` persistence, and zero-FOUC inline script
- **Data-driven architecture**: All resume content stored in YAML files, supporting multiple data paths and versioning
- **12 resume sections**: Experience, Education, Certifications, Courses, Volunteering, Projects, Skills, Recognition, Associations, Languages, Links, Interests
- **Accessibility features**: Semantic landmarks, keyboard navigation, localized skip links, and labelled social controls. See the [Accessibility Guide](docs/ACCESSIBILITY_GUIDE.md) for coverage and known limitations.
- **Modern favicon suite**: High-resolution favicons (Apple touch icon, 32x32, 16x16, webmanifest) with subpath-safe URLs and `_config.yml` override support
- **Print-friendly**: Optimized for PDF generation and printing with bidirectional text isolation (`dir="ltr"`) for URLs
- **SEO ready**: Built-in support for multilingual SEO, standardized canonical tags via `jekyll-seo-tag`, sitemaps, and feeds
- **JSON Resume Export**: Multilingual builds optionally generate standards-validated JSON Resume files at `/<lang>/resume.json`.
- **Automatic pages**: Missing CV and profile pages are generated for each configured language; hand-authored pages take precedence.
- **Data validation**: `validate-resume` CLI and build-time checks for schemas, dates, URLs, and parity across every configured language

## Quick Start

### Installation

1. Add to your Jekyll site's `Gemfile`, inside `group :jekyll_plugins`. The `:jekyll_plugins` group loads the theme’s bundled generators and validator. Alternatively, explicitly list `bilingual-jekyll-resume-theme` under `plugins:` in `_config.yml` (as the sample does); a plain Gemfile entry plus `theme:` alone is insufficient:
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

1. **Copy sample configuration**: Use `_config.sample.yml` at the repository root as a starting point for your `_config.yml`. Keep a `languages.<lang>` entry for each language you publish and delete the rest.

2. **Copy sample data files**: Copy each language folder you need from `demo/_data/` (`en`, `ar`, `es`, `fr`, `de`, `ur`) to your site's `_data/`. Each holds 13 files, including `header.yml` for the intro paragraph.

3. **Resume pages**: Missing pages are generated automatically: CVs at `languages.<lang>.url`, profiles at `/` for `default_lang` and `/<lang>/` for other languages. When generation is disabled (`resume_auto_generate_pages: false`), create one page per language using the `resume` layout:
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

Visit `http://localhost:4000/en/cv/` (or your configured CV URL). Profile landing pages are also generated automatically; create a `layout: profile` page if you want to hand-author a homepage instead.

## Documentation

### For site owners (using the theme)

| Guide | Read it to |
|---|---|
| [Configuration Guide](docs/CONFIG_GUIDE.md) | Set up `_config.yml`: languages, sections, contact info, social links, avatar, analytics, dark mode. **Start here.** |
| [Data Structure Guide](docs/DATA_GUIDE.md) | Write the 13 YAML data files per language: fields, examples, date formats, `active` flags. |
| [Multilingual Guide](docs/MULTILINGUAL_GUIDE.md) | Override locale strings or fonts, add a language, RTL typography, and the v0.9.0 → v1.0.0 migration table. |
| [Validation Guide](docs/VALIDATION_GUIDE.md) | Run `validate-resume`, read its errors, turn on strict builds and CI. |
| [JSON Resume Export](docs/JSON_RESUME_EXPORT.md) | Publish `/<lang>/resume.json`, control privacy and which fields are exported. |
| [Accessibility Guide](docs/ACCESSIBILITY_GUIDE.md) | See what the theme covers for WCAG 2.2 AA and its known limitations. |

### For theme developers (changing the theme)

| Guide | Read it to |
|---|---|
| [Project Overview](docs/PROJECT_OVERVIEW.md) | Find your way around: architecture, file map, where each feature lives. |
| [Layouts Guide](docs/LAYOUTS_GUIDE.md) | Understand the four layouts and how data reaches them. |
| [Includes Guide](docs/INCLUDES_GUIDE.md) | Understand each include, add a section or a social platform. |
| [SASS/SCSS Guide](docs/SASS_GUIDE.md) | Change styles, dark mode tokens, and RTL overrides. |
| [Testing Guide](docs/TESTING_GUIDE.md) | Run the test suites, see what each covers, add a test. |
| [AGENTS.md](AGENTS.md) · [Feature Roadmap](FEATURE_ROADMAP.md) · [Completed Audit](docs/COMPLETED_AUDIT.md) · [Changelog](CHANGELOG.md) | Contribution rules, planned work, past decisions, release notes. |

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
├── _config.sample.yml # Annotated configuration for consuming sites
├── demo/              # Separate demo-site submodule, including six-language data
└── docs/              # Documentation guides
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

`demo/_data/{en,ar,es,fr,de,ur}/` hold a complete Sherlock Holmes demo resume in six languages, covering all 12 section types. Copy the folders you need to your site.

### Locales

Month names, "Present" labels, section titles, fonts, and text direction come from `_data/locales/<lang>.yml`, shipped inside the gem for all six languages. Override single strings or add a new language from your site's own `_data/locales/`; see the [Multilingual Guide](docs/MULTILINGUAL_GUIDE.md).

## Development

To develop this theme locally:

```bash
# Initialize the demo submodule, then install dependencies
git submodule update --init --recursive
bundle install

# Serve the six-language demo from the demo submodule
bundle exec jekyll serve --source demo --destination _site
# (Or with live reload and incremental builds)
bundle exec jekyll serve --source demo --destination _site --livereload --incremental

# Build static output
bundle exec jekyll build --source demo --destination _site

# Clean cached Jekyll build artifacts
bundle exec jekyll clean

# Validate resume data schemas and parity (CLI or Rake)
./bin/validate-resume demo/_data
bundle exec rake validate

# Check that the theme's own templates only reference real data keys (CLI or Rake)
./bin/check-data-keys demo/_data
bundle exec rake check_data_keys

# Data validator, template key checker, RuboCop, and every test suite
bundle exec rake

# Verify built HTML (separate from the default Rake task)
bundle exec rake "proof[_site,demo/_config.yml]"

# Build the gem
gem build bilingual-jekyll-resume-theme.gemspec

# List packaged files (must include locales and bin, exclude tests)
gem spec bilingual-jekyll-resume-theme-*.gem files
rm -f bilingual-jekyll-resume-theme-*.gem

# Dependency Audit
bundle outdated
bundle update

# Automated Version Release (updates gemspec, changelog, commits, and tags)
./bin/release <version>
./bin/release --bump
```

For more details on resume schema checks, see [VALIDATION_GUIDE.md](docs/VALIDATION_GUIDE.md). Contributor and agent rules are in [AGENTS.md](AGENTS.md).

## Requirements

- Ruby 3.3+; this repository’s CI matrix tests 3.3, 3.4, and 4.0.
- Jekyll `~> 4.4` (4.4 or later, below 5.0), as specified in the gemspec.
- Runtime plugin dependencies (enable them through your site’s `plugins:` list, as in the sample config):
  - `jekyll-feed`
  - `jekyll-seo-tag`
  - `jekyll-sitemap`
  - `jekyll-redirect-from`

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## License

The theme is available as open source under the terms of the [MIT License](LICENSE.txt).

## Support

- 📖 Check the [Documentation Guides](#documentation) for detailed information
- 🐛 Report issues on [GitHub Issues](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues)

---

**Created by Khaldoon Mutahar** | MIT License
