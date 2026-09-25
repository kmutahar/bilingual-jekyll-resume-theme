# Project Overview

**bilingual-jekyll-resume-theme** is a Ruby gem / Jekyll theme for data-driven, multilingual resume and CV sites. One locale-agnostic layout renders every language, left-to-right or right-to-left, from YAML data and per-language locale files. v1.0.0 ships six locales: English, Arabic, Spanish, French, German, and Urdu.

- **Author & Maintainer:** Khaldoon Mutahar (`contact@mutahar.me`)
- **License:** MIT License ([`../LICENSE.txt`](../LICENSE.txt))
- **Requirements:** Ruby 3.3+, Jekyll 4.4+
- **RubyGems:** [bilingual-jekyll-resume-theme](https://rubygems.org/gems/bilingual-jekyll-resume-theme)
- **GitHub Repository:** [kmutahar/bilingual-jekyll-resume-theme](https://github.com/kmutahar/bilingual-jekyll-resume-theme)

---

## Key Features

### 1. Locale-Agnostic Layout System
- One resume layout, [`../_layouts/resume.html`](../_layouts/resume.html), for every language. Pages set `layout: resume` and `lang: <code>`.
- Six locale files in [`../_data/locales/`](../_data/locales/) (`en`, `ar`, `es`, `fr`, `de`, `ur`) hold direction, font, line height, UI strings, month names, "present" words, and error copy. Sites override single keys or add languages through their own `_data/locales/` ([`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md)).
- Direction selects the stylesheet: `cv-ltr.css` or `cv-rtl.css`. RTL overrides in [`../_sass/_resume-rtl.scss`](../_sass/_resume-rtl.scss) are language-neutral; fonts arrive through CSS variables emitted from the locale.
- One date formatter, [`../_includes/date-formatter.html`](../_includes/date-formatter.html), localizes month names and "Present" for every language.
- Bidi isolation (`dir="ltr"`) on phone numbers, emails, URLs, and credential IDs in RTL locales.

### 2. Dynamic Data Engine
- Resume content lives in YAML files, one folder per language (see [`DATA_GUIDE.md`](DATA_GUIDE.md)).
- Each language's folder is `languages.<lang>.data_path` in `_config.yml`; dot paths such as `"2025-06.v1"` select nested, versioned datasets.

### 3. Layout Suite & Error Generator (4 Layouts)
1. **`default.html`**: base shell for markdown pages, SEO, favicons, and footers.
2. **`profile.html`**: standalone landing page.
3. **`resume.html`**: the resume for every configured language.
4. **`error.html`**: HTTP error suite (`404.html`, `403.html`, `500.html`) with one localized block per configured language, a search box, per-language return links (`languages.<lang>.url`), and a reload button.
- `_plugins/error_pages_generator.rb` adds missing `404`, `403`, and `500` pages to consuming sites.

### 4. Dynamic Section Rendering (12 Sections)
Sections render in the order of `site.resume_section_order` through one dispatcher, [`../_includes/resume-section.html`](../_includes/resume-section.html): `experience`, `education`, `certifications`, `courses`, `volunteering`, `projects`, `skills`, `recognitions`, `associations`, `languages`, `links`, `interests`, plus the `header.yml` intro.

### 5. Resume Data Validator
- `validate-resume` CLI, `rake validate`, and a Jekyll generator (on by default) check YAML syntax, required fields, dates, URLs, file parity across every configured language, and locale key parity ([`VALIDATION_GUIDE.md`](VALIDATION_GUIDE.md)).

### 6. Universal Dark Mode
- [`../_sass/_dark-mode.scss`](../_sass/_dark-mode.scss) holds every color token on `:root`.
- `dark_mode: auto` adapts through `prefers-color-scheme` with no JavaScript; `dark_mode: enabled` adds a toggle with `localStorage` persistence.
- An inline `<head>` script in [`../_includes/shared-head.html`](../_includes/shared-head.html) prevents theme flashing. Print forces black on white.

### 7. Configurable Avatar
- [`../_includes/avatar.html`](../_includes/avatar.html): local or external image, per-language alt text, optional link wrapping.

### 8. Accessibility (WCAG 2.2 AA)
- 4.5:1 contrast in light and dark modes, `.sr-only` utilities, visible `:focus-visible` outlines, landmarks, and localized skip links ([`ACCESSIBILITY_GUIDE.md`](ACCESSIBILITY_GUIDE.md)).

### 9. Architecture Jump Table ("Where do I find / configure X?")

| Need / Task | Go To | Verification Method |
|---|---|---|
| Configure site settings, languages, avatar, or analytics | `_config.yml`, [`CONFIG_GUIDE.md`](CONFIG_GUIDE.md) | Demo build (below) |
| Add a language or change UI strings, fonts, or month names | `_data/locales/<lang>.yml`, [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md) | `./bin/validate-resume demo/_data`, then inspect `_site/<lang>/cv/` |
| Modify resume section data | `_data/<lang>/*.yml`, [`DATA_GUIDE.md`](DATA_GUIDE.md) | `./bin/validate-resume demo/_data` |
| Customize error pages or return URLs | `_layouts/error.html`, `_plugins/error_pages_generator.rb`, `error_pages` in the locale files, [`LAYOUTS_GUIDE.md`](LAYOUTS_GUIDE.md) | Inspect `_site/404.html`, `_site/500.html` |
| Adjust dark mode colors or tokens | `_sass/_dark-mode.scss`, [`SASS_GUIDE.md`](SASS_GUIDE.md) | Inspect CSS variables on `:root` and `[data-theme="dark"]` |
| Adjust RTL mirroring | `_sass/_resume-rtl.scss`, [`SASS_GUIDE.md`](SASS_GUIDE.md) | Inspect `_site/ar/cv/` and `_site/ur/cv/` |

Demo build (renders the six-language Sherlock Holmes resume from the `demo/` submodule):

```bash
bundle exec jekyll build --source demo --destination _site
```

---

## Repository File Map

```text
bilingual-jekyll-resume-theme/
├── 403.html / 404.html / 500.html  # Root HTTP error pages (layout: error)
│
├── _layouts/
│   ├── default.html              # Base HTML shell
│   ├── profile.html              # Standalone landing page
│   ├── resume.html               # Resume layout for every language (LTR and RTL)
│   └── error.html                # HTTP error suite (404/403/500/503)
│
├── _includes/
│   ├── resume-section.html       # Section dispatcher (12 sections, every language)
│   ├── date-formatter.html       # Locale-driven date and "Present" formatting
│   ├── data-loader.html          # Dot-path data resolution into resume_data
│   ├── shared-head.html          # Meta, anti-FOUC script, favicons
│   ├── main-head.html            # Stylesheet for default/error pages (main.css)
│   ├── profile-head.html         # Stylesheet for the profile page (profile.css)
│   ├── avatar.html               # Profile picture
│   ├── dark-mode-toggle.html     # Floating theme toggle
│   ├── language-switcher.html    # Floating dropdown linking to every other configured language
│   ├── social-links.html         # Social icons (email + 14 platforms)
│   ├── print-social-links.html   # Print-only social links text list
│   ├── hreflang.html             # Alternate-language SEO links
│   ├── analytics-head.html       # GTM / GA4 head script
│   ├── analytics-body.html       # GTM noscript body fallback
│   └── vendors/                  # Bundled Lineicons SVGs (v4.0 & v5.0)
│
├── _sass/
│   ├── _variables.scss           # Widths, gutters, font stacks
│   ├── _dark-mode.scss           # Color tokens, overrides, print reset
│   ├── _base.scss                # Reset, .sr-only, base typography
│   ├── _layout.scss              # Container and grid
│   ├── _resume-ltr.scss          # Main resume styles + LTR positioning
│   ├── _resume-rtl.scss          # Language-neutral RTL overrides
│   ├── _profile-page.scss        # Landing page styles
│   ├── _all-pages.scss           # Shared markdown typography and icon sizing
│   ├── _mixins.scss              # Breakpoints and font mixins
│   └── _normalize.scss           # Normalize.css v8.0.1
│
├── assets/
│   ├── css/
│   │   ├── cv-ltr.scss           # Resume entrypoint for LTR locales
│   │   ├── cv-rtl.scss           # Resume entrypoint for RTL locales
│   │   ├── profile.scss          # Profile page entrypoint
│   │   └── main.scss             # Default/error pages entrypoint
│   └── favicon/resume/           # Favicon suite
│
├── _data/
│   └── locales/                  # en, ar, es, fr, de, ur locale dictionaries
│
├── _plugins/
│   ├── error_pages_generator.rb  # Synthesizes missing HTTP error pages
│   └── resume_validator.rb       # Build-time validation (on by default)
│
├── lib/
│   ├── bilingual-jekyll-resume-theme.rb          # Gem entrypoint
│   └── bilingual-jekyll-resume-theme/
│       └── resume_validator.rb   # Validator engine
│
├── bin/
│   ├── validate-resume           # Validator CLI (gem executable)
│   └── release                   # Release script (not packaged)
│
├── test/                         # Minitest suite (validator, language switcher)
├── Rakefile                      # validate, test, rubocop, proof, default
│
└── docs/
    ├── ACCESSIBILITY_GUIDE.md    # WCAG 2.2 AA architecture
    ├── COMPLETED_AUDIT.md        # Record of completed remediations and features
    ├── CONFIG_GUIDE.md           # _config.yml reference
    ├── DATA_GUIDE.md             # Resume data schemas
    ├── INCLUDES_GUIDE.md         # Includes and section dispatch
    ├── LAYOUTS_GUIDE.md          # Layouts and data flow
    ├── MULTILINGUAL_GUIDE.md     # Locales, adding languages, v1.0.0 migration table
    ├── SASS_GUIDE.md             # Styling system, tokens, RTL
    ├── VALIDATION_GUIDE.md       # Validator, CLI, CI, proofing
    └── PROJECT_OVERVIEW.md       # This file
```

---

## Documentation Master Index

| Document | Relative Path | Scope & Focus |
|---|---|---|
| **Configuration Guide** | [`CONFIG_GUIDE.md`](CONFIG_GUIDE.md) | Every `_config.yml` setting |
| **Multilingual Guide** | [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md) | Locale files, adding a language, overrides, typography, v1.0.0 migration |
| **Data Guide** | [`DATA_GUIDE.md`](DATA_GUIDE.md) | Data schemas and examples for all sections |
| **Includes Guide** | [`INCLUDES_GUIDE.md`](INCLUDES_GUIDE.md) | Partials, parameters, and section dispatch |
| **Layouts Guide** | [`LAYOUTS_GUIDE.md`](LAYOUTS_GUIDE.md) | Layouts, language resolution, rendering pipeline, error pages |
| **SASS Guide** | [`SASS_GUIDE.md`](SASS_GUIDE.md) | SCSS architecture, dark mode tokens, RTL |
| **Validation Guide** | [`VALIDATION_GUIDE.md`](VALIDATION_GUIDE.md) | Validator rules, CLI, build-time checks, CI |
| **Accessibility Guide** | [`ACCESSIBILITY_GUIDE.md`](ACCESSIBILITY_GUIDE.md) | WCAG 2.2 AA landmarks, focus, contrast |
| **Completed Audit** | [`COMPLETED_AUDIT.md`](COMPLETED_AUDIT.md) | Historical record of completed fixes and features |
| **Master AI Manual** | [`../AGENTS.md`](../AGENTS.md) | Operating rules for AI agents |
| **Feature Roadmap** | [`../FEATURE_ROADMAP.md`](../FEATURE_ROADMAP.md) | Active feature blueprints, issue mappings, Delete-Zone |
| **Sample Config** | [`../_config.sample.yml`](../_config.sample.yml) | Annotated configuration for consuming sites |
