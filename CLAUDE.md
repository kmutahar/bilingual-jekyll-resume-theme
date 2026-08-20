# CLAUDE.md

This file provides context and guidance to AI coding assistants (Claude, Gemini, etc.) when working with this repository.

## Project Overview

**bilingual-jekyll-resume-theme** is a Ruby gem / Jekyll theme (v0.5.2) for building clean, data-driven, bilingual (English & Arabic) resume/CV websites. Created and maintained by **Khaldoon Mutahar** (MIT License).

- **RubyGems**: `gem "bilingual-jekyll-resume-theme"`
- **Jekyll requirement**: 4.4+
- **Homepage**: https://www.mutahr.me/bilingual-jekyll-resume-theme
- **GitHub**: https://github.com/kmutahar/bilingual-jekyll-resume-theme

---

## Common Commands

```bash
# Install dependencies
bundle install

# Start local development server (http://localhost:4000)
bundle exec jekyll serve

# Build the gem
gem build bilingual-jekyll-resume-theme.gemspec

# Install the gem locally for testing
gem install bilingual-jekyll-resume-theme-*.gem
```

---

## High-Level Architecture

### Dual-Language Layout System

Two primary resume layouts share identical structure but differ in language and text direction:

| File | Language | Direction |
|---|---|---|
| `_layouts/resume-en.html` | English | LTR |
| `_layouts/resume-ar.html` | Arabic | RTL (`dir="rtl"`) |

Both layouts:
1. Load resume data from `_data/` via Jekyll's `site.data` object
2. Support configurable data paths via `site.active_resume_path_en` / `site.active_resume_path_ar`
3. Dynamically render sections based on `site.resume_section_order` array in `_config.yml`

Additional layouts:
- `_layouts/default.html` — Base HTML shell
- `_layouts/profile.html` — Landing/profile page

### Dynamic Section Rendering

Sections are **not hardcoded** in layout files. The layout loops through `site.resume_section_order` and includes:
- `_includes/resume-section-en.html` (English)
- `_includes/resume-section-ar.html` (Arabic)

Each include uses a large conditional block to render the right section from the `section_name` parameter.

**Available section names**: `experience`, `education`, `certifications`, `courses`, `volunteering`, `projects`, `skills`, `recognition`, `associations`, `interests`, `languages`, `links`

Each section can be toggled on/off via `site.resume_section.*` boolean flags in `_config.yml`.

### Dynamic Data Loading

In both `resume-en.html` and `resume-ar.html`, Liquid bracket notation iterates over a dot-separated path to resolve nested data objects. This allows numeric or hyphenated keys like `"2025-06"` or `"20250621-PM"`.

Example config:
```yaml
active_resume_path_en: "en"   # resolves to site.data.en.*
active_resume_path_ar: "ar"   # resolves to site.data.ar.*
```

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
│   ├── resume-section-en.html  # All 12 English section renderers
│   ├── resume-section-ar.html  # All 12 Arabic section renderers
│   ├── resume-head-en.html     # <head> for English resume
│   ├── resume-head-ar.html     # <head> for Arabic resume
│   ├── shared-head.html        # Shared <head> metadata
│   ├── main-head.html          # Profile page <head>
│   ├── social-links.html       # Social icon links
│   ├── print-social-links.html # Print-only social links block
│   ├── ar-date.html            # Arabic date formatter
│   ├── hreflang.html           # Multilingual SEO alternate links
│   ├── analytics-head.html     # Analytics (GTM/GA4) in <head>
│   ├── analytics-body.html     # Analytics in <body>
│   └── vendors/                # Bundled SVG icon sets (Lineicons)
│
├── _sass/
│   ├── _variables.scss         # Colors, fonts, sizing
│   ├── _base.scss              # Typography and base elements
│   ├── _layout.scss            # Grid and container layout
│   ├── _resume.scss            # Resume-specific component styles
│   ├── _resume-rtl.scss        # RTL overrides for Arabic
│   ├── _normalize.scss         # CSS reset
│   ├── _mixins.scss            # Reusable SCSS mixins
│   ├── _profile.scss           # Profile page styles
│   └── _all-pages.scss         # Global cross-page styles
│
├── assets/
│   └── css/
│       ├── cv.scss             # English resume styles
│       ├── cv-ar.scss          # Arabic resume styles (includes RTL)
│       └── main.scss           # Profile/landing page styles
│
├── _data/
│   └── ar/
│       └── months.yml          # Arabic month names (bundled; do not copy)
│
├── docs/
│   ├── CONFIG_GUIDE.md
│   ├── DATA_GUIDE.md
│   ├── INCLUDES_GUIDE.md
│   ├── LAYOUTS_GUIDE.md
│   ├── SASS_GUIDE.md
│   ├── PROJECT_OVERVIEW.md
│   └── _data/
│       ├── en/                 # Sample English data files
│       ├── ar/                 # Sample Arabic data files
│       └── _config.sample.yml
│
├── bilingual-jekyll-resume-theme.gemspec
├── Gemfile
├── CHANGELOG.md
├── README.md
├── WARP.md                     # Guidance for Warp terminal AI
└── CLAUDE.md                   # This file
```

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

| Key | Purpose |
|---|---|
| `active_resume_path_en` | Data path for English (e.g., `"en"`) |
| `active_resume_path_ar` | Data path for Arabic (e.g., `"ar"`) |
| `resume_section_order` | Array controlling section render order |
| `resume_section.*` | Boolean toggles per section |
| `display_header_contact_info` | Show/hide contact info in header |
| `resume_avatar` | Enable profile avatar |
| `social_links` | Social platform links |
| `resume_theme` | Theme variant |
| `enable_live` | Toggle live vs. print contact info |
| `name.{first,middle,last}` | English name fields |
| `name_ar.{first,middle,last}` | Arabic name fields |

See `docs/CONFIG_GUIDE.md` for the full reference.

---

## Plugin Dependencies (runtime)

| Plugin | Version | Purpose |
|---|---|---|
| `jekyll-feed` | `~> 0.17` | RSS feed generation |
| `jekyll-seo-tag` | `~> 2.9` | SEO meta tags |
| `jekyll-sitemap` | `~> 1.4` | Sitemap generation |
| `jekyll-redirect-from` | `~> 0.16` | URL redirection |
| `logger` | `~> 1.7` | Ruby 3.5+ stdlib future-proofing |

---

## Key Implementation Details

1. **Dynamic data loading** — Liquid bracket notation resolves dot-separated `active_resume_path_*` strings into nested `site.data` lookups; supports numeric/hyphenated keys.

2. **Section rendering** — `resume-section-en.html` and `resume-section-ar.html` each contain one large `{% if section_name == "..." %}` chain. When adding a new section, update **both** files.

3. **Arabic date formatting** — `_includes/ar-date.html` looks up month names from `_data/ar/months.yml` (shipped with the gem; consuming sites do not need to create it).

4. **Print behavior** — CSS uses `.print-only` / `.no-print` classes. `_includes/print-social-links.html` outputs URL text for links during printing.

5. **RTL styling** — `_sass/_resume-rtl.scss` contains all RTL overrides and is imported by `assets/css/cv-ar.scss` only.

6. **Gem file inclusion** — Only `git ls-files`-tracked files matching `assets/`, `_data/`, `_layouts/`, `_includes/`, `_sass/`, `LICENSE`, `README`, `CHANGELOG`, `CODE_OF_CONDUCT`, `docs/` are packaged.

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
