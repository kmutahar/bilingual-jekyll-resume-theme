# Project Overview

**bilingual-jekyll-resume-theme** is a production-grade Ruby gem / Jekyll theme (v0.7.0) engineered for creating elegant, data-driven, bilingual (English & Arabic) resumes, CVs, and portfolio websites.

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

### 3. Comprehensive Layout Suite (5 Layouts)
1. **`default.html`**: Foundational HTML wrapper for custom markdown pages, SEO, favicons, and footers.
2. **`profile.html`**: Clean portfolio landing page wrapper with scoped card styling.
3. **`resume-en.html`**: Full-featured English LTR resume pipeline.
4. **`resume-ar.html`**: Mirrored Arabic RTL resume pipeline.
5. **`error.html`**: Bilingual HTTP error suite (`404.html`, `403.html`, `500.html`) with quick navigation returns and reload buttons.

### 4. Dynamic Section Rendering (12 Standard Sections)
Sections render dynamically via the sequence defined in `site.resume_section_order`:
- `experience`, `education`, `certifications`, `courses`, `volunteering`, `projects`, `skills`, `recognition`, `associations`, `languages`, `links`, `interests`, plus `header` (executive summary).

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

---

## Repository File Map

```text
bilingual-jekyll-resume-theme/
├── _layouts/
│   ├── default.html              # Base HTML shell
│   ├── profile.html              # Portfolio landing page
│   ├── resume-en.html            # English resume layout (LTR)
│   ├── resume-ar.html            # Arabic resume layout (RTL)
│   └── error.html                # HTTP error suite (404/403/500)
│
├── _includes/
│   ├── shared-head.html          # Shared SEO, icons, anti-FOUC script
│   ├── main-head.html            # Stylesheet loader for default/profile pages
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
│   ├── _profile.scss             # Scoped landing page styles
│   ├── _all-pages.scss           # Shared markdown typography and icon sizing
│   ├── _mixins.scss              # Responsive breakpoints and font mixins
│   └── _normalize.scss           # Normalize.css v8.0.1
│
├── assets/
│   └── css/
│       ├── cv.scss               # English resume stylesheet entrypoint
│       ├── cv-ar.scss            # Arabic resume stylesheet entrypoint
│       └── main.scss             # Profile / generic page stylesheet entrypoint
│
├── _data/
│   ├── ar/
│   │   └── months.yml            # Arabic month names dictionary
│   └── error_pages.yml           # Centralized bilingual error copy
│
└── docs/
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
| **Sample Config** | [`_data/_config.sample.yml`](_data/_config.sample.yml) | Master annotated configuration file for consuming sites |