# bilingual-jekyll-resume-theme

[![Latest release](https://img.shields.io/github/v/release/kmutahar/bilingual-jekyll-resume-theme?display_name=tag)](https://github.com/kmutahar/bilingual-jekyll-resume-theme/releases) [![Gem Version](https://badge.fury.io/rb/bilingual-jekyll-resume-theme.svg?icon=si%3Arubygems)](https://badge.fury.io/rb/bilingual-jekyll-resume-theme)

A flexible Jekyll theme for creating clean, data-driven, multilingual resume/CV websites (including LTR and RTL languages). Created and maintained by Khaldoon Mutahar. See the latest version on the [Releases page](https://github.com/kmutahar/bilingual-jekyll-resume-theme/releases).
Inspired by and originally forked from [Joel Glovier’s resume template](https://github.com/jglovier/resume-template/). Joel’s version was a basic English-only theme with limited customization (e.g., no section reordering); this project has since evolved into a fully separate theme authored by Khaldoon.

## Features

- **Multilingual support**: Unified `resume-multi.html` layout with dynamic `lang` and `dir`
- **Data-driven architecture**: All resume content stored in YAML files, supporting multiple data paths and versioning
- **12 resume sections**: Experience, Education, Certifications, Courses, Volunteering, Projects, Skills, Recognition, Associations, Languages, Links, Interests
- **Print-friendly**: Optimized for PDF generation and printing
- **SEO ready**: Built-in support for multilingual SEO, sitemap, and feed generation
- **Localized UI and dates**: Translation dictionaries in `_data/languages/*.yml` for labels, month names, and present text

## Quick Start

### Installation

1. Add to your Jekyll site's `Gemfile`:
```ruby
gem "bilingual-jekyll-resume-theme"
```

2. Add to your `_config.yml`:
```yaml
theme: bilingual-jekyll-resume-theme
```

3. Install dependencies:
```bash
bundle install
```

### Basic Setup

1. **Copy sample configuration**: Use `docs/_data/_config.sample.yml` as a starting point for your `_config.yml`

2. **Copy sample data files**: 
   - English data: Copy files from `docs/_data/en/` to your `_data/en/` directory (includes `header.yml` for the intro paragraph)
   - Arabic data: Copy files from `docs/_data/ar/` to your `_data/ar/` directory (includes `header.yml` for the Arabic intro paragraph)

3. **Create resume pages**: Create pages using the `resume-multi` layout:
```yaml
---
layout: resume-multi
permalink: /resume/en/
lang: en
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

### 📊 [Data Structure Guide](docs/DATA_GUIDE.md)
Detailed documentation of all 12 data file types (experience, education, skills, etc.) with examples. Learn how to structure your YAML files and what fields are required vs optional.

### 🎨 [Layouts Guide](docs/LAYOUTS_GUIDE.md)
Deep dive into how layouts work, how data flows through them, and how to create custom layouts. Useful for advanced customization.

### 🧩 [Includes Guide](docs/INCLUDES_GUIDE.md)
Understanding the theme's include system, how sections render, and how to add new sections or customize existing ones.

### 🎨 [SASS/SCSS Guide](docs/SASS_GUIDE.md)
Complete guide to the theme's styling system, how to customize colors/fonts, and how to override styles without forking the theme.

## Project Structure

```
bilingual-jekyll-resume-theme/
├── _layouts/          # HTML templates (default, resume-multi, resume-en, resume-ar, profile)
├── _includes/          # Reusable components (sections, headers, analytics)
├── _sass/             # SCSS stylesheets (RTL support, print styles)
├── _data/             # Theme data (includes languages/*.yml dictionaries)
├── assets/            # CSS, images, favicons
└── docs/              # Documentation and sample files
    ├── _data/         # Sample data files (copy to your site's _data/)
    └── *.md           # Documentation guides
```

## Key Concepts

### Data Paths

Use `languages` in your site's `_config.yml` as the source of truth:
```yaml
languages:
  en:
    dir: ltr
    data_path: en
  ar:
    dir: rtl
    data_path: ar
  es:
    dir: ltr
    data_path: es
```
Each page sets `lang`, and `resume-multi` resolves direction and data path automatically.
For backward compatibility, `active_resume_path_en` and `active_resume_path_ar` are still supported.

### Sample Files

The theme includes sample data files in `docs/_data/en/` and `docs/_data/ar/` that you can copy to your site. These files contain:
- Commented examples for all 12 section types
- Required vs optional field explanations
- Multiple examples per section

### Localized Date Support

The theme includes `_data/languages/` dictionaries with month arrays and present aliases. Add your own language dictionary there to localize date output and current-role text.

## Development

To develop this theme locally:

```bash
# Install dependencies
bundle install

# Run development server
bundle exec jekyll serve

# Build the gem
gem build bilingual-jekyll-resume-theme.gemspec
```

For more details, see [WARP.md](WARP.md) or the [Development section](#development) below.

## Requirements

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
- 💡 See [project_overview.md](project_overview.md) for a high-level architecture overview

---

**Created by Khaldoon Mutahar** | Version 0.4.0 | MIT License
