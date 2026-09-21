# Project Overview

**bilingual-jekyll-resume-theme** is a production-grade Ruby gem / Jekyll theme (v0.8.0) engineered for creating elegant, data-driven, bilingual (English & Arabic) resumes, CVs, and portfolio websites.

- **Author & Maintainer:** Khaldoon Mutahar (`contact@mutahar.me`)
- **License:** MIT License ([`../LICENSE.txt`](../LICENSE.txt))
- **Jekyll Requirement:** 4.4+
- **RubyGems:** [bilingual-jekyll-resume-theme](https://rubygems.org/gems/bilingual-jekyll-resume-theme)
- **GitHub Repository:** [kmutahar/bilingual-jekyll-resume-theme](https://github.com/kmutahar/bilingual-jekyll-resume-theme)

---

## Key Features

### 1. Dual-Language Layout System
- Dedicated layouts for English ([`../_layouts/resume-en.html`](../_layouts/resume-en.html)) and Arabic ([`../_layouts/resume-ar.html`](../_layouts/resume-ar.html)).
- Strict Left-to-Right (LTR) and Right-to-Left (RTL) visual parity with mirrored positioning, typography line-heights, and timeline markers ([`../_sass/_resume-rtl.scss`](../_sass/_resume-rtl.scss)).
- Automated Arabic month translation via [`../_includes/ar-date.html`](../_includes/ar-date.html) reading from [`../_data/ar/months.yml`](../_data/ar/months.yml).
- Bidirectional punctuation isolation wrapping phone numbers and URLs in `<span dir="ltr">`.

### 2. Dynamic Data Engine
- Pure data-driven content stored in YAML files under `_data/` (see [`DATA_GUIDE.md`](DATA_GUIDE.md)).
- Dynamic bracket-notation resolver supporting dot-separated paths (e.g., `active_resume_path_en: "2025-06.v1"`).
- Decoupled configuration allowing independent data paths for English and Arabic.

### 3. Comprehensive Layout Suite & Error Generator (5 Layouts)
1. **`default.html`**: Foundational HTML wrapper for custom markdown pages, SEO, favicons, and footers.
2. **`profile.html`**: Clean standalone portfolio landing page wrapper with scoped card styling.
3. **`resume-en.html`**: Full-featured English LTR resume pipeline.
4. **`resume-ar.html`**: Mirrored Arabic RTL resume pipeline.
5. **`error.html`**: Bilingual HTTP error suite (`404.html`, `403.html`, `500.html`) with an accessible search box, dynamic resume return navigation (`site.resume_en_url`, `site.resume_ar_url`), and reload buttons.
- **Dynamic Error Generator**: Shipped via `_plugins/error_pages_generator.rb`, automatically synthesizing missing `404.html`, `403.html`, and `500.html` pages in consuming sites if not explicitly provided.

### 4. Dynamic Section Rendering (12 Standard Sections)
Sections render dynamically via the sequence defined in `site.resume_section_order`:
- `experience`, `education`, `certifications`, `courses`, `volunteering`, `projects`, `skills`, `recognitions` (with legacy `recognition` fallback), `associations`, `languages`, `links`, `interests`, plus `header` (executive summary).

### 5. Universal Dark Mode & Modern Theming
- Managed by [`../_sass/_dark-mode.scss`](../_sass/_dark-mode.scss) with centralized CSS custom properties on `:root`.
- **Zero-JS System Default (`dark_mode: auto`)**: Pure CSS adaptation via `@media (prefers-color-scheme: dark)`.
- **Interactive Toggle (`dark_mode: enabled`)**: Accessible floating button with two-state state machine and `localStorage` persistence.
- **Anti-FOUC Guarantee**: Synchronous `<head>` script in [`../_includes/shared-head.html`](../_includes/shared-head.html) eliminates theme flashing.
- **Print Resets**: Physical and PDF printing automatically enforce crisp black text on white backgrounds.

### 6. Configurable Profile Picture (Avatar)
- Reusable component in [`../_includes/avatar.html`](../_includes/avatar.html).
- Supports local assets, external CDN URLs, language-aware alt text, and configurable link wrapping.

### 7. Accessibility & WCAG 2.2 Compliance
- Enforces minimum 4.5:1 color contrast ratios across both light and dark modes.
- Screen-reader utility classes (`.sr-only`) in [`../_sass/_base.scss`](../_sass/_base.scss).
- Prominent `:focus-visible` focus outlines for keyboard navigation.

### 8. Architecture Jump Table ("Where do I find / configure X?")

| Need / Task | Go To | Verification Method |
|---|---|---|
| Configure site settings, avatar, or analytics | `_config.yml`, [`CONFIG_GUIDE.md`](CONFIG_GUIDE.md) | `bundle exec jekyll build --config docs/_data/_config.sample.yml` |
| Modify resume section data | `_data/en/*.yml`, `_data/ar/*.yml`, [`DATA_GUIDE.md`](DATA_GUIDE.md) | Check rendered HTML output |
| Customize error page templates or return URLs | `_layouts/error.html`, `_plugins/error_pages_generator.rb`, `_data/error_pages.yml`, [`LAYOUTS_GUIDE.md`](LAYOUTS_GUIDE.md) | Inspect `_site/404.html`, `_site/500.html` |
| Adjust dark mode colors or theme tokens | `_sass/_dark-mode.scss`, [`SASS_GUIDE.md`](SASS_GUIDE.md) | Inspect CSS variables on `:root` and `[data-theme="dark"]` |
| Customize Arabic typography or RTL mirroring | `_sass/_resume-rtl.scss`, `_includes/resume-head-ar.html` | Test `/ar/cv/` with RTL inspection |

---

## Repository File Map

```text
bilingual-jekyll-resume-theme/
├── 403.html                      # Root HTTP 403 Access Forbidden page
├── 404.html                      # Root HTTP 404 Page Not Found page
├── 500.html                      # Root HTTP 500 Internal Server Error page
│
├── _layouts/
│   ├── default.html              # Base HTML shell
│   ├── profile.html              # Standalone portfolio landing page
│   ├── resume-en.html            # English resume layout (LTR)
│   ├── resume-ar.html            # Arabic resume layout (RTL)
│   └── error.html                # HTTP error suite (404/403/500)
│
├── _includes/
│   ├── shared-head.html          # Shared SEO, icons, anti-FOUC script
│   ├── main-head.html            # Stylesheet loader for default/error pages (assets/css/main.css)
│   ├── profile-head.html         # Stylesheet loader for profile landing page (assets/css/profile.css)
│   ├── resume-head-en.html       # English metadata and Google fonts
│   ├── resume-head-ar.html       # Arabic metadata and Cairo font loader
│   ├── avatar.html               # Configurable, accessible profile picture
│   ├── dark-mode-toggle.html     # Interactive floating theme toggle button
│   ├── ar-date.html              # Arabic date translation engine
│   ├── resume-section-en.html    # English section dispatcher
│   ├── resume-section-ar.html    # Arabic section dispatcher
│   ├── social-links.html         # Interactive SVG social icons (14 platforms)
│   ├── print-social-links.html   # Plaintext printable contact details
│   ├── hreflang.html             # Multilingual SEO alternate links
│   ├── analytics-head.html       # GTM / GA4 head tracking script
│   ├── analytics-body.html       # GTM noscript body fallback
│   └── vendors/                  # Bundled Lineicons SVGs (v4.0 & v5.0)
│
├── _sass/
│   ├── _variables.scss           # Typography, widths, gutters, defaults
│   ├── _dark-mode.scss           # Color token system, overrides, print reset
│   ├── _base.scss                # Reset, .sr-only, base typography
│   ├── _layout.scss              # Responsive container and grid system
│   ├── _resume.scss              # Core English resume section styles
│   ├── _resume-rtl.scss          # Mirrored RTL overrides
│   ├── _profile-page.scss        # Scoped landing page styles
│   ├── _all-pages.scss           # Shared markdown typography and icon sizing
│   ├── _mixins.scss              # Responsive breakpoints and font mixins
│   └── _normalize.scss           # Normalize.css v8.0.1
│
├── assets/
│   ├── css/
│   │   ├── cv.scss               # English resume stylesheet entrypoint
│   │   ├── cv-ar.scss            # Arabic resume stylesheet entrypoint
│   │   ├── profile.scss          # Dedicated profile page stylesheet entrypoint
│   │   └── main.scss             # Default/error pages stylesheet entrypoint
│   └── favicon/resume/           # High-resolution favicon suite
│
├── _plugins/
│   └── error_pages_generator.rb  # Automatically synthesizes missing HTTP error pages
│
├── lib/
│   └── bilingual-jekyll-resume-theme.rb # Ruby gem entrypoint and runtime extensions
│
├── _data/
│   ├── ar/
│   │   └── months.yml            # Arabic month names dictionary
│   └── error_pages.yml           # Centralized bilingual error copy
│
└── docs/
    ├── COMPLETED_AUDIT.md        # Permanent historical record of remediations
    ├── CONFIG_GUIDE.md           # Exhaustive _config.yml settings manual
    ├── DATA_GUIDE.md             # Complete data schema guide with examples
    ├── INCLUDES_GUIDE.md         # Component includes and section dispatch
    ├── LAYOUTS_GUIDE.md          # Layout architecture and data flow
    ├── SASS_GUIDE.md             # Styling system, tokens, and dark mode
    ├── PROJECT_OVERVIEW.md       # High-level architecture summary (THIS FILE)
    └── _data/
        ├── _config.sample.yml    # Master sample configuration
        ├── en/                   # Starter English YAML data files
        └── ar/                   # Starter Arabic YAML data files
```

---

## Documentation Master Index

| Document | Relative Path | Scope & Focus |
|---|---|---|
| **Configuration Guide** | [`CONFIG_GUIDE.md`](CONFIG_GUIDE.md) | Exhaustive reference for all settings in `_config.yml` |
| **Data Guide** | [`DATA_GUIDE.md`](DATA_GUIDE.md) | Data schemas, field types, and examples for all sections |
| **Includes Guide** | [`INCLUDES_GUIDE.md`](INCLUDES_GUIDE.md) | Component partials, parameters, and section dispatching |
| **Layouts Guide** | [`LAYOUTS_GUIDE.md`](LAYOUTS_GUIDE.md) | Outer HTML templates, rendering pipeline, and error pages |
| **SASS Guide** | [`SASS_GUIDE.md`](SASS_GUIDE.md) | SCSS architecture, dark mode design tokens, and RTL |
| **Completed Audit** | [`COMPLETED_AUDIT.md`](COMPLETED_AUDIT.md) | Historical record of completed bug fixes & security remediations |
| **Master AI Manual** | [`../AGENTS.md`](../AGENTS.md) | Authoritative operating rules and constraints for AI agents |
| **Feature Roadmap** | [`../FEATURE_ROADMAP.md`](../FEATURE_ROADMAP.md) | Active feature blueprints, issue mappings, and status delete-zone |
| **Sample Config** | [`_data/_config.sample.yml`](_data/_config.sample.yml) | Master annotated configuration file for consuming sites |