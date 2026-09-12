# CLAUDE.md

This file provides context and guidance to AI coding assistants (Claude, Gemini, etc.) when working with this repository.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Key Features](#key-features)
3. [Common Commands](#common-commands)
4. [High-Level Architecture](#high-level-architecture)
5. [Project Structure](#project-structure)
6. [Data Structure](#data-structure)
7. [Configuration Keys](#configuration-keys)
8. [Plugin Dependencies](#plugin-dependencies)
9. [Key Implementation Details](#key-implementation-details)
10. [Gem Build & Distribution](#gem-build--distribution)
11. [Security & Maintenance](#security--maintenance)
12. [Documentation Index](#documentation-index)
13. [Arabic-Specific Notes](#arabic-specific-notes)
14. [Testing in a Consuming Site](#testing-in-a-consuming-site)
15. [Troubleshooting & Development](#troubleshooting--development)

---

## Project Overview

**bilingual-jekyll-resume-theme** is a Ruby gem / Jekyll theme (v0.7.0) for building clean, data-driven, bilingual (English & Arabic) resume/CV websites. Created and maintained by **Khaldoon Mutahar** (MIT License).

### Key Links
- **RubyGems**: https://rubygems.org/gems/bilingual-jekyll-resume-theme
- **Jekyll requirement**: 4.4+
- **Homepage**: https://www.mutahr.me/bilingual-jekyll-resume-theme
- **GitHub Repository**: https://github.com/kmutahar/bilingual-jekyll-resume-theme
- **Bug Tracker**: https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues
- **Changelog**: https://github.com/kmutahar/bilingual-jekyll-resume-theme/blob/master/CHANGELOG.md
- **Installation**: Add `gem "bilingual-jekyll-resume-theme"` to your Gemfile

### License & Attribution
- **License**: MIT License (see LICENSE.txt)
- **Author**: Khaldoon Mutahar (contact@mutahar.me)
- **Inspired by**: Joel Glovier's resume template (originally forked, now a separate evolved project)
- **Code of Conduct**: See CODE_OF_CONDUCT.md

---

## Key Features

- **Bilingual support**: Separate optimized layouts for English (LTR) and Arabic (RTL) with identical structure
- **Data-driven architecture**: All resume content stored in YAML files with support for multiple data paths and versioning
- **12 resume sections**: Experience, Education, Certifications, Courses, Volunteering, Projects, Skills, Recognition, Associations, Languages, Links, Interests
- **Dynamic section ordering**: Reorder sections via `site.resume_section_order` in `_config.yml`
- **Print-friendly design**: Optimized for PDF generation and physical printing (print-only elements available)
- **SEO ready**: Built-in support for multilingual SEO, sitemap, feed generation via jekyll-seo-tag and jekyll-feed
- **Arabic month support**: Arabic date formatting included out of the box (`_data/ar/months.yml`)
- **Flexible data paths**: Support for nested data paths like `2025-06.20250621-PM` via dot-separated notation
- **Social links integration**: Configurable social platform links with icons and optional Mastodon verification
- **Analytics support**: Optional Google Analytics and Google Tag Manager integration
- **Security monitoring**: Automated Mend/CodeQL scanning for dependency vulnerabilities

---

## Common Commands

### Setup & Development

```bash
# Install dependencies (required before any commands)
bundle install

# Start local development server (runs at http://localhost:4000)
bundle exec jekyll serve

# Build static site (outputs to _site/ directory)
bundle exec jekyll build

# Clean build artifacts before rebuilding
bundle exec jekyll clean

# Build the gem locally
gem build bilingual-jekyll-resume-theme.gemspec

# Install the built gem locally for testing (version from gemspec)
gem install bilingual-jekyll-resume-theme-0.7.0.gem

# Publish gem to RubyGems.org (requires authentication)
gem push bilingual-jekyll-resume-theme-0.7.0.gem
```

### Testing & Verification

```bash
# Check for outdated dependencies
bundle outdated

# Update gems
bundle update

# List all files that would be packaged in the gem
git ls-files -z | tr '\0' '\n' | grep -E '^(assets|_data|_layouts|_includes|_sass|LICENSE|README|CHANGELOG|CODE_OF_CONDUCT|docs)'
```

---

## High-Level Architecture

### Dual-Language Layout System

Two primary resume layouts share identical structure but differ in language and text direction:

| File | Language | Direction | Key Details |
|---|---|---|---|
| `_layouts/resume-en.html` | English | LTR | Load from `site.active_resume_path_en` |
| `_layouts/resume-ar.html` | Arabic | RTL (`dir="rtl"`) | Load from `site.active_resume_path_ar` |

Both layouts:
1. Load resume data from `_data/` via Jekyll's `site.data` object
2. Support configurable data paths via `site.active_resume_path_en` / `site.active_resume_path_ar`
3. Dynamically render sections based on `site.resume_section_order` array in `_config.yml`
4. Loop through section order array, including the appropriate section renderer for each

### Dynamic Section Rendering

Sections are **not hardcoded** in layout files. The layout loops through `site.resume_section_order` and includes:
- `_includes/resume-section-en.html` (English)
- `_includes/resume-section-ar.html` (Arabic)

Each include uses a large conditional block to render the right section from the `section_name` parameter.

**Available section names**: `experience`, `education`, `certifications`, `courses`, `volunteering`, `projects`, `skills`, `recognition`, `associations`, `interests`, `languages`, `links`

**Section control**: Each section can be toggled on/off via `site.resume_section.*` boolean flags in `_config.yml` (e.g., `site.resume_section.experience`).

**Important note**: When adding or modifying a section, update **BOTH** `resume-section-en.html` AND `resume-section-ar.html` files to maintain parity.

### Dynamic Data Loading

In both `resume-en.html` and `resume-ar.html`, Liquid bracket notation iterates over a dot-separated path to resolve nested data objects. This allows numeric or hyphenated keys like `"2025-06"` or `"20250621-PM"`.

#### How it works:
1. `active_resume_path_en` is read from `_config.yml` (e.g., `"en"` or `"2025-06.20250621-PM"`)
2. The path is split by `.` into parts: `["2025-06", "20250621-PM"]`
3. A loop iteratively drills down: `site.data["2025-06"]["20250621-PM"]`
4. The final nested object is assigned to `resume_data`
5. Template accesses `resume_data.experience`, `resume_data.education`, etc.

Example config:
```yaml
active_resume_path_en: "en"   # resolves to site.data.en.*
active_resume_path_ar: "ar"   # resolves to site.data.ar.*
```

**Fallback**: If path is empty or `nil`, the layout defaults to `site.data` (root-level _data files).

### Additional Layouts

- `_layouts/default.html` — Base HTML shell; extends other layouts
- `_layouts/profile.html` — Landing/profile page; used for homepage

---

## Project Structure

```
bilingual-jekyll-resume-theme/
├── _layouts/
│   ├── default.html          # Base HTML shell
│   ├── resume-en.html        # English resume layout (LTR)
│   ├── resume-ar.html        # Arabic resume layout (RTL)
│   └── profile.html          # Landing/profile page
│
├── _includes/
│   ├── resume-section-en.html  # 12 English section renderers (if-else chain)
│   ├── resume-section-ar.html  # 12 Arabic section renderers (if-else chain)
│   ├── resume-head-en.html     # <head> metadata for English resume
│   ├── resume-head-ar.html     # <head> metadata for Arabic resume
│   ├── shared-head.html        # Shared <head> metadata (both languages)
│   ├── main-head.html          # <head> for profile/landing page
│   ├── social-links.html       # Social icon links (inline)
│   ├── print-social-links.html # Print-only social links block (URLs as text)
│   ├── ar-date.html            # Arabic date formatter (converts dates to Arabic months)
│   ├── hreflang.html           # Multilingual SEO alternate links (<link rel="alternate">)
│   ├── analytics-head.html     # Google Analytics/GTM in <head>
│   ├── analytics-body.html     # Google Analytics/GTM in <body>
│   └── vendors/                # Bundled external assets
│       ├── lineicons-v4.0/     # Icon set v4.0 (if used)
│       └── lineicons-v5.0/     # Icon set v5.0 (if used)
│
├── _sass/
│   ├── _variables.scss         # Colors, fonts, sizing, breakpoints
│   ├── _base.scss              # Typography and base elements
│   ├── _layout.scss            # Grid and container layout
│   ├── _resume.scss            # Resume-specific component styles
│   ├── _resume-rtl.scss        # RTL overrides (Arabic-specific)
│   ├── _normalize.scss         # CSS reset
│   ├── _mixins.scss            # Reusable SCSS mixins
│   ├── _profile.scss           # Profile/landing page styles
│   └── _all-pages.scss         # Global cross-page styles
│
├── assets/
│   └── css/
│       ├── cv.scss             # English resume stylesheet (imports _resume.scss)
│       ├── cv-ar.scss          # Arabic resume stylesheet (imports _resume.scss + _resume-rtl.scss)
│       └── main.scss           # Profile/landing page stylesheet
│
├── _data/
│   └── ar/
│       └── months.yml          # Arabic month names (bundled; do not copy to consuming sites)
│
├── docs/
│   ├── CONFIG_GUIDE.md         # Complete _config.yml reference
│   ├── DATA_GUIDE.md           # Data structure for all 12 sections
│   ├── INCLUDES_GUIDE.md       # Include system and how to add sections
│   ├── LAYOUTS_GUIDE.md        # Layout architecture and data flow
│   ├── SASS_GUIDE.md           # Styling system and customization
│   ├── PROJECT_OVERVIEW.md     # High-level project overview
│   └── _data/                  # Sample data files for consuming sites
│       ├── en/                 # English samples (copy to your _data/en/)
│       ├── ar/                 # Arabic samples (copy to your _data/ar/)
│       └── _config.sample.yml  # Sample _config.yml
│
├── .github/
│   ├── workflows/
│   │   └── publish.yml         # GitHub Actions: Publish gem to RubyGems
│   └── dependabot.yml          # Dependabot configuration for dependency updates
│
├── bilingual-jekyll-resume-theme.gemspec  # Gem specification (Ruby metadata)
├── Gemfile                     # Bundler dependencies
├── Gemfile.lock                # Locked dependency versions
├── CHANGELOG.md                # Version history (Keep a Changelog format)
├── README.md                   # User-facing documentation
├── CLAUDE.md                   # This file (AI assistant guidance)
├── WARP.md                     # Guidance for Warp terminal AI
├── LICENSE.txt                 # MIT License
├── CODE_OF_CONDUCT.md          # Community guidelines
├── SECURITY.md                 # Security policy and vulnerability reporting
├── cliff.toml                  # Changelog generation configuration
└── .gitignore                  # Git ignore rules
```

### Files Packaged in Gem

Only files matching these patterns are included in the published gem (see `gemspec`):
- `assets/` — CSS and other assets
- `_data/` — Theme data (primarily `ar/months.yml`)
- `_layouts/` — All layout templates
- `_includes/` — All include components
- `_sass/` — All stylesheets
- `LICENSE`, `README`, `CHANGELOG`, `CODE_OF_CONDUCT` — License and documentation
- `docs/` — Complete documentation and samples

Excluded from gem: `.git/`, `.github/`, `.gitignore`, `Gemfile`, `Gemfile.lock`, `cliff.toml`, `WARP.md`, `CLAUDE.md`

---

## Data Structure

Resume content is stored as YAML in the consuming site's `_data/` directory. The theme reads it via `site.data`.

### Recommended layout (consuming sites)

```
_data/
├── en/
│   ├── header.yml        # Intro/summary paragraph
│   ├── experience.yml
│   ├── education.yml
│   ├── skills.yml
│   └── ...               # one file per section
└── ar/
    ├── header.yml
    ├── experience.yml
    └── ...
```

### Section data shapes

| Section | Key fields |
|---|---|
| `experience` / `volunteering` | Grouped by company; multiple roles per company; date ranges |
| `education` | University, degree, year, awards |
| `certifications` / `courses` | Issuing org, dates, credential ID/URL |
| `projects` | Name, role, duration, description, optional URL |
| `skills` | Skill name and description |
| `languages` | Language name, proficiency description |
| All sections | `active: true/false` flag per entry |

See `docs/DATA_GUIDE.md` for full field reference and examples.

---

## Configuration Keys (`_config.yml` in consuming sites)

### Core Settings

| Key | Type | Purpose |
|---|---|---|
| `theme` | String | Must be `bilingual-jekyll-resume-theme` |
| `url` | String | Full domain (e.g., `https://example.com`) |
| `baseurl` | String | Subpath if deploying to subdirectory (usually empty) |
| `title` | String | Site title / your name |
| `timezone` | String | Timezone for Jekyll (e.g., `UTC`, `America/New_York`) |

### Name & Identity

| Key | Type | Purpose |
|---|---|---|
| `name.first` | String | English first name |
| `name.middle` | String | English middle name/initial |
| `name.last` | String | English last name |
| `name_ar.first` | String | Arabic first name |
| `name_ar.middle` | String | Arabic middle name |
| `name_ar.last` | String | Arabic last name |
| `resume_title` | String | Job title/headline |

### Data & Content

| Key | Type | Purpose |
|---|---|---|
| `active_resume_path_en` | String | Path to English resume data (e.g., `"en"` or `"2025-06.data"`) |
| `active_resume_path_ar` | String | Path to Arabic resume data (e.g., `"ar"` or `"2025-06.data"`) |
| `resume_section_order` | Array | Array of section names in render order |
| `resume_section.*` | Boolean | Enable/disable each section (e.g., `resume_section.experience: true`) |

### Contact & Display

| Key | Type | Purpose |
|---|---|---|
| `contact_info.email` | String | Email address |
| `contact_info.phone` | String | Phone number (optional) |
| `contact_info.location` | String | City/location (optional) |
| `display_header_contact_info` | Boolean | Show contact info in header |
| `resume_avatar` | Boolean | Display profile picture |
| `enable_live` | Boolean | Show "live" vs. print contact info |

### Social & Links

| Key | Type | Purpose |
|---|---|---|
| `social_links` | Array | Social media profiles (Twitter, LinkedIn, GitHub, etc.) |
| `social_links[].platform` | String | Platform name (twitter, linkedin, github, mastodon, etc.) |
| `social_links[].url` | String | Profile URL |
| `social_links[].mastodon_verify` | Boolean | Enable Mastodon verification (optional) |

### Analytics & SEO

| Key | Type | Purpose |
|---|---|---|
| `google_analytics.id` | String | Google Analytics tracking ID (optional) |
| `google_tag_manager.id` | String | Google Tag Manager ID (optional) |
| `lang` | String | Primary language code (e.g., `en`, `ar`) |
| `description` | String | Short site description for SEO |

### Styling

| Key | Type | Purpose |
|---|---|---|
| `resume_theme` | String | Color theme variant (if implemented) |

See `docs/CONFIG_GUIDE.md` for the complete reference and detailed examples.

---

## Plugin Dependencies

### Runtime Dependencies

Specified in `bilingual-jekyll-resume-theme.gemspec`:

| Dependency | Version | Purpose |
|---|---|---|
| `jekyll` | `~> 4.4` | Core Jekyll static site generator (required: 4.4 or higher, < 5.0) |
| `jekyll-feed` | `~> 0.17` | RSS/Atom feed generation for blog posts and updates |
| `jekyll-seo-tag` | `~> 2.9` | Multilingual SEO meta tags (Open Graph, Twitter Cards, etc.) |
| `jekyll-sitemap` | `~> 1.4` | Automatic sitemap.xml generation for search engines |
| `jekyll-redirect-from` | `~> 0.16` | URL redirection (e.g., moved pages, legacy links) |
| `logger` | `~> 1.7` | Ruby logger module (future-proofing for Ruby 3.5+) |

### Why These Dependencies?

- **jekyll-feed**: Enables RSS feed for resume updates (used by some feed readers)
- **jekyll-seo-tag**: Bilingual SEO support ensures both English and Arabic versions are properly indexed
- **jekyll-sitemap**: Helps search engines crawl all pages efficiently
- **jekyll-redirect-from**: Allows redirecting old resume URLs if you change the site structure
- **logger**: Ensures compatibility with Ruby 3.5+ which removes logger from stdlib

---

## Key Implementation Details

1. **Dynamic data loading** — Liquid bracket notation resolves dot-separated `active_resume_path_*` strings into nested `site.data` lookups; supports numeric/hyphenated keys.

2. **Section rendering** — `resume-section-en.html` and `resume-section-ar.html` each contain one large `{% if section_name == "..." %}` chain. When adding a new section, update **both** files.

3. **Arabic date formatting** — `_includes/ar-date.html` looks up month names from `_data/ar/months.yml` (shipped with the gem; consuming sites do not need to create it).

4. **Print behavior** — CSS uses `.print-only` / `.no-print` classes. `_includes/print-social-links.html` outputs URL text for links during printing.

5. **RTL styling** — `_sass/_resume-rtl.scss` contains all RTL overrides and is imported by `assets/css/cv-ar.scss` only.

6. **Gem file inclusion** — Only `git ls-files`-tracked files matching `assets/`, `_data/`, `_layouts/`, `_includes/`, `_sass/`, `LICENSE`, `README`, `CHANGELOG`, `CODE_OF_CONDUCT`, `docs/` are packaged.

---

## Gem Build & Distribution

### Gemspec Configuration

The `bilingual-jekyll-resume-theme.gemspec` file defines:

```ruby
spec.name          = "bilingual-jekyll-resume-theme"
spec.version       = "0.7.0"                    # Current version (update before release)
spec.authors       = ["Khaldoon Mutahar"]
spec.email         = ["contact@mutahar.me"]
spec.license       = "MIT"
spec.platform      = Gem::Platform::RUBY       # Pure Ruby gem (all platforms)
spec.homepage      = "https://www.mutahr.me/bilingual-jekyll-resume-theme"
```

### Publishing Process

1. **Update version** in `bilingual-jekyll-resume-theme.gemspec`
2. **Build locally**: `gem build bilingual-jekyll-resume-theme.gemspec`
3. **Test locally**: `gem install bilingual-jekyll-resume-theme-0.7.0.gem`
4. **Push to RubyGems**: `gem push bilingual-jekyll-resume-theme-0.7.0.gem` (requires auth)
5. **Tag release** on GitHub with version number

### File Inclusion Filter

Only files matching these patterns are included (from `gemspec`):
```
^(assets|_data|_layouts|_includes|_sass|LICENSE|README|CHANGELOG|CODE_OF_CONDUCT|docs)
```

This is enforced via `git ls-files -z` to only include tracked files matching the pattern.

### Post-Install Message

When users install the gem, they see:
```
Thank you for installing bilingual-jekyll-resume-theme!
To get started, check the setup instructions:
https://github.com/kmutahar/bilingual-jekyll-resume-theme#readme
```

### Metadata

Gemspec includes metadata for discoverability:
- `bug_tracker_uri` — GitHub Issues
- `changelog_uri` — CHANGELOG.md
- `documentation_uri` — README
- `source_code_uri` — GitHub repository
- `allowed_push_host` — RubyGems only (security lock)

---

## Documentation Index

| Guide | Path | Content |
|---|---|---|
| Configuration | `docs/CONFIG_GUIDE.md` | All `_config.yml` settings |
| Data Structure | `docs/DATA_GUIDE.md` | All 12 data file types with examples |
| Layouts | `docs/LAYOUTS_GUIDE.md` | Layout architecture and data flow |
| Includes | `docs/INCLUDES_GUIDE.md` | Include system, adding sections |
| SASS/SCSS | `docs/SASS_GUIDE.md` | Styling system, overrides without forking |
| Project Overview | `docs/PROJECT_OVERVIEW.md` | High-level architecture overview |

---

## Security & Maintenance

### Supported Versions

| Version | Status | Notes |
|---------|--------|-------|
| 0.7.x | ✅ Supported | Current stable release branch |
| 0.6.x | ✅ Supported | Maintenance & security patches |
| < 0.6 | ❌ Unsupported | Legacy; please upgrade |

### Dependency Monitoring

- **Automated scanning**: Mend (formerly WhiteSource) and GitHub CodeQL
- **Severity threshold**: LOW (monitors even low-risk issues)
- **Purpose**: Safeguard consuming repositories via GitHub Pages

### Reporting Vulnerabilities

Do **NOT** use GitHub Issues for security reports. Instead:

1. **Email**: contact@mutahar.me with:
   - Vulnerability description
   - Affected version(s)
   - Proof-of-concept or reproduction steps (if possible)

2. **Response SLA**:
   - Acknowledgment within 48 hours
   - Status updates at least weekly while working on a fix

### CI/CD

GitHub Actions workflow: `.github/workflows/publish.yml`
- Automatically publishes gem to RubyGems when releases are published
- Requires authentication via `RUBYGEMS_AUTH_TOKEN` secret

### Dependency Management

Dependabot configuration: `.github/dependabot.yml`
- Automatically checks for outdated dependencies
- Creates pull requests for available updates
- Monitors both direct and transitive dependencies

---

## Arabic-Specific Notes

- Layout sets `dir="rtl"` on the root element
- Header icons are reversed in placement
- UI strings (section titles, "Present", etc.) are in Arabic — e.g. `"حتى الآن"` for ongoing roles
- Language chips in the header are controlled via `resume_section.lang_header`
- Separate name object: `site.name_ar.{first,middle,last}`

---

## Testing in a Consuming Site

Reference the theme via Gemfile with a local path:
```ruby
gem "bilingual-jekyll-resume-theme", path: "../bilingual-jekyll-resume-theme"
```

And `_config.yml`:
```yaml
theme: bilingual-jekyll-resume-theme
```

Then run `bundle install && bundle exec jekyll serve`.

---

## Troubleshooting & Development

### Common Development Tasks

#### Adding a new resume section

1. **Add section data file** in consuming site's `_data/en/` and `_data/ar/` directories
2. **Update both** `_includes/resume-section-en.html` AND `_includes/resume-section-ar.html`:
   - Add new `{% elsif include.section_name == "new_section" %}` block
   - Define the rendering logic for that section
3. **Enable in config**: Add to `site.resume_section.new_section: true` in consuming site's `_config.yml`
4. **Add to section order**: Include `new_section` in `site.resume_section_order` array

⚠️ **Critical**: Both include files must be kept in sync. Missing updates in either file will cause the section to fail on one language.

#### Customizing styles without forking

1. Create `_sass/custom.scss` in consuming site (not in theme)
2. In consuming site's stylesheet, import theme styles then your custom overrides
3. Use SCSS variables from `_sass/_variables.scss` for consistency

#### Testing Arabic layout locally

1. Create resume page with `layout: resume-ar`
2. Set `active_resume_path_ar: "ar"` in `_config.yml`
3. Ensure `_data/ar/` YAML files exist with Arabic content
4. Run `bundle exec jekyll serve` and navigate to the Arabic resume URL

#### Working with nested data paths

To use versioned data (e.g., `2025-06.20250621-PM`):

1. Create `_data/2025-06/` directory
2. Create subdirectory `_data/2025-06/20250621-PM/` with your YAML files
3. Set in `_config.yml`: `active_resume_path_en: "2025-06.20250621-PM"`
4. The dynamic loader automatically resolves nested access

### Debugging Tips

**Section not rendering?**
- Verify section name is in `site.resume_section_order`
- Check `site.resume_section.section_name` is `true` in config
- Confirm both `resume-section-en.html` AND `resume-section-ar.html` have the section defined
- Inspect Jekyll logs: `bundle exec jekyll build --verbose`

**Styles not applying?**
- Check CSS/SCSS compilation: Look in `_site/assets/css/` for generated CSS
- Verify RTL styles in `cv-ar.scss` include `_resume-rtl.scss`
- Use browser DevTools to inspect applied styles
- Check for CSS specificity conflicts (theme styles vs. overrides)

**Arabic text not displaying?**
- Verify YAML files use UTF-8 encoding
- Ensure Arabic month names exist in `_data/ar/months.yml`
- Check `ar-date.html` is properly included in resume-ar.html
- Test with simple Arabic text first before complex markup

**Date formatting issues?**
- For Arabic dates, use the `ar-date.html` include
- Pass date in `YYYY-MM-DD` format to the include
- Verify month names are defined in `_data/ar/months.yml`

### Performance Considerations

- **Liquid loops**: Large resume sections (100+ items) may slow builds; consider pagination
- **SASS compilation**: Full rebuild takes ~1-2 seconds; use `--incremental` for development
- **Jekyll cache**: Clear with `bundle exec jekyll clean` if changes aren't visible

### Git Workflow for Contributors

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/description`
3. Make changes and test locally: `bundle exec jekyll serve`
4. Commit with clear messages: `git commit -m "Add/fix: description"`
5. Push and create a pull request
6. Update version in `bilingual-jekyll-resume-theme.gemspec` if not already done
7. Ensure CHANGELOG.md is updated for user-facing changes
