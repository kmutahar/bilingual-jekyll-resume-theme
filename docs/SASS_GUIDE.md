# SCSS / SASS Architecture Guide (`_sass/`)

A technical tour of the theme's styling system in [`../_sass/`](../_sass/) and entrypoint stylesheets in [`../assets/css/`](../assets/css/). This guide covers modern Dart Sass module architecture, the dark mode token system, RTL mirroring, WCAG 2.2 accessibility standards, and print optimization.

---

## Table of Contents

- [Entrypoints & Compilation Architecture](#entrypoints--compilation-architecture)
  - [Stylesheet Entrypoints](#stylesheet-entrypoints)
  - [Modern Dart Sass `@use` Architecture](#modern-dart-sass-use-architecture)
  - [Overriding Partials in a Consuming Site](#overriding-partials-in-a-consuming-site)
- [SCSS Partial Inventory](#scss-partial-inventory)
  - [1. `_variables.scss`](#1-_variablesscss)
  - [2. `_mixins.scss`](#2-_mixinsscss)
  - [3. `_normalize.scss`](#3-_normalizescss)
  - [4. `_base.scss`](#4-_basescss)
  - [5. `_layout.scss`](#5-_layoutscss)
  - [6. `_resume-ltr.scss`](#6-_resume-ltrscss)
  - [7. `_resume-rtl.scss`](#7-_resume-rtlscss)
  - [8. `_profile-page.scss`](#8-_profile-pagescss)
  - [9. `_all-pages.scss`](#9-_all-pagesscss)
  - [10. `_dark-mode.scss`](#10-_dark-modescss)
- [The Dark Mode Token System](#the-dark-mode-token-system)
  - [Design Tokens Table](#design-tokens-table)
  - [Two-Tier Activation Mechanism](#two-tier-activation-mechanism)
  - [Print Media Resets](#print-media-resets)
- [WCAG 2.2 Accessibility & High-Contrast Standards](#wcag-22-accessibility--high-contrast-standards)
- [Locale Typography & RTL Mechanics](#locale-typography--rtl-mechanics)

---

## Entrypoints & Compilation Architecture

### Stylesheet Entrypoints

Jekyll compiles files in [`../assets/css/`](../assets/css/) that start with YAML front matter into final static CSS assets:

| Source SCSS | Compiled Output CSS | Consuming Layouts |
|---|---|---|
| [`../assets/css/cv-ltr.scss`](../assets/css/cv-ltr.scss) | `assets/css/cv-ltr.css` | [`../_layouts/resume.html`](../_layouts/resume.html) for every locale with `direction: ltr` |
| [`../assets/css/cv-rtl.scss`](../assets/css/cv-rtl.scss) | `assets/css/cv-rtl.css` | [`../_layouts/resume.html`](../_layouts/resume.html) for every locale with `direction: rtl` |
| [`../assets/css/profile.scss`](../assets/css/profile.scss) | `assets/css/profile.css` | [`../_layouts/profile.html`](../_layouts/profile.html) |
| [`../assets/css/main.scss`](../assets/css/main.scss) | `assets/css/main.css` | [`../_layouts/default.html`](../_layouts/default.html), [`../_layouts/error.html`](../_layouts/error.html) |

### Modern Dart Sass `@use` Architecture

The theme exclusively utilizes modern Dart Sass `@use` instead of deprecated `@import`:
- **Namespacing:** Variables and mixins are encapsulated (e.g., `variables.$white`, `@include mixins.clearfix`), preventing global pollution.
- **Dependency Isolation:** Modules only load what they explicitly require.

### Overriding Partials in a Consuming Site

Because Jekyll prioritizes files in the consuming site's directory over gem theme assets, you can override any partial without forking the gem:
1. Create a matching file in your local site (e.g., `_sass/_variables.scss`).
2. Define your customized variables. Any variable marked `!default` in the theme will yield to your local values.

---

## SCSS Partial Inventory

### 1. `_variables.scss`

- **File:** [`../_sass/_variables.scss`](../_sass/_variables.scss)
- **Role:** Base layout widths, grid gutters, and font stacks.
- **Key Variables:**
  - `$container-width: 980px !default;`: Maximum resume container width.
  - `$grid-gutter: 10px !default;`: Grid column padding and gutters.
  - `$body-font`, `$mono-font`: Base fallback typography stacks.

---

### 2. `_mixins.scss`

- **File:** [`../_sass/_mixins.scss`](../_sass/_mixins.scss)
- **Role:** Breakpoint helpers, typography mixins, and border accents.
- **Key Mixins:**
  - `@mixin media_mobile` (`max-width: 600px`)
  - `@mixin media_larger_than_mobile` (`min-width: 600px`)
  - `@mixin sans`, `@mixin serif`, `@mixin section_border`

---

### 3. `_normalize.scss`

- **File:** [`../_sass/_normalize.scss`](../_sass/_normalize.scss)
- **Role:** Normalize.css v8.0.1 browser baseline reset.

---

### 4. `_base.scss`

- **File:** [`../_sass/_base.scss`](../_sass/_base.scss)
- **Role:** HTML and body defaults, box-sizing, and screen-reader accessibility classes.
- **Key Features:**
  - Universal `box-sizing: border-box`.
  - `.sr-only` utility class for WCAG screen-reader announcements.
  - Selection background and text styling.

---

### 5. `_layout.scss`

- **File:** [`../_sass/_layout.scss`](../_sass/_layout.scss)
- **Role:** Centered `.container` wrapper and responsive grid columns (`.one-third`, `.two-thirds`, `.one-half`, etc.).

---

### 6. `_resume-ltr.scss`

- **File:** [`../_sass/_resume-ltr.scss`](../_sass/_resume-ltr.scss)
- **Role:** The main resume stylesheet: every shared rule plus LTR positioning. Both entrypoints load it; `cv-rtl.scss` then layers `_resume-rtl.scss` on top.
- **Typography:** resume text reads `var(--font-locale, <default stack>)` and `var(--line-height-locale, <default>)`, so each locale's font and line height apply without per-language rules.
- **Components Styled:**
  - Header: Avatar (`.avatar`), candidate name, contact info row, and social links bar.
  - Contact CTA button (`.contact-button`) and "not looking" modifier.
  - Section headers (`.section-header`) and item cards (`.resume-item`).
  - Two-column responsive Languages table.
  - Print-specific media overrides (`@media print`).

---

### 7. `_resume-rtl.scss`

- **File:** [`../_sass/_resume-rtl.scss`](../_sass/_resume-rtl.scss)
- **Role:** Language-neutral RTL overrides scoped under `html[dir="rtl"]`, loaded last by `cv-rtl.scss`. Serves Arabic, Urdu, and any future RTL locale.
- **Key Overrides:**
  - Flips horizontal floats, text alignments, borders, and margins.
  - Repositions timeline bullets and contact icons for RTL reading order.
  - Resets `letter-spacing` to `normal` on headings so cursive scripts keep their ligatures.
  - Sets no `font-family` or `line-height`; those come from the locale CSS variables.

---

<a id="8-_profile-pagescss"></a>
<a id="8-_profile-page-scss"></a>
### 8. `_profile-page.scss`

- **File:** [`../_sass/_profile-page.scss`](../_sass/_profile-page.scss)
- **Role:** Styles for the dedicated portfolio landing page layout ([`../_layouts/profile.html`](../_layouts/profile.html)) and entrypoint [`../assets/css/profile.scss`](../assets/css/profile.scss).
- **Architecture:** Provides clean, unconstrained vertical centering, avatar, bio typography, and CV action button without duplicating universal footer or SVG icon styles (which are loaded from [`_all-pages.scss`](../_sass/_all-pages.scss)).

---

### 9. `_all-pages.scss`

- **File:** [`../_sass/_all-pages.scss`](../_sass/_all-pages.scss)
- **Role:** Universal styles shared across all layouts.
- **Key Features:**
  - Contact SVG icon sizing and hover animations.
  - Complete dark-mode-aware typography rules for markdown content in `.main-content` (headings, paragraphs, blockquotes, tables, lists, and code blocks).

---

### 10. `_dark-mode.scss`

- **File:** [`../_sass/_dark-mode.scss`](../_sass/_dark-mode.scss)
- **Role:** Single source of truth for all color tokens, theme overrides, and the floating toggle button.

---

## The Dark Mode Token System

### Design Tokens Table

All layout and resume styles reference CSS custom properties defined on `:root` in [`../_sass/_dark-mode.scss`](../_sass/_dark-mode.scss):

| CSS Custom Property | Light Mode Value | Dark Mode Value | Semantic Role |
|---|---|---|---|
| **Background & Typography** | | | |
| `--bg-color` | `#ffffff` | `#121212` | Main page and viewport background |
| `--text-color` | `#333` | `#e0e0e0` | Primary reading and heading typography |
| `--text-muted` | `#999` | `#888888` | Secondary copy, timestamps, and details |
| `--text-light` | `#646464` | `#aaaaaa` | Tertiary descriptive text |
| `--border-color` | `#c7c7c7` | `#333333` | Section dividers and card borders |
| `--card-bg` | `#efefef` | `#1e1e1e` | Button backgrounds and code blocks |
| **Links & Navigation** | | | |
| `--link-color` | `#333` | `#e0e0e0` | Interactive hyperlinks |
| `--link-hover` | `#9c9c9c` | `#ffffff` | Hyperlink hover color |
| `--link-hover-color` | `var(--link-hover)` | `var(--link-hover)` | Hyperlink hover alias |
| **Accent & Brand** | | | |
| `--accent-color` | `#3064a9` | `#6ba4e8` | Primary accents and focus outlines |
| `--accent-hover` | `#307EA9` | `#8cbcf3` | Accent hover state |
| `--accent-hover-color` | `var(--accent-hover)` | `var(--accent-hover)` | Accent hover alias |
| `--social-hover-color` | `var(--accent-hover)` | `var(--accent-hover)` | Social icons hover color |
| `--about-color` | `var(--text-light)` | `var(--text-light)` | Executive summary / about text color |
| **Footer** | | | |
| `--footer-text-color` | `var(--text-muted)` | `var(--text-muted)` | Footer copyright typography |
| `--footer-link-color` | `var(--link-color)` | `var(--link-color)` | Footer hyperlink color |
| **Icons & Graphics** | | | |
| `--icon-fill` | `#333` | `#e0e0e0` | Social and contact SVG icon fill |
| `--icon-fill-muted` | `#555555` | `#888888` | Muted secondary icon fill |
| `--icon-fill-dark` | `#000` | `#ffffff` | Dark/prominent icon fill |
| `--icon-hover-fill` | `var(--icon-fill-dark)` | `var(--icon-fill-dark)` | Icon hover fill |
| `--header-icon-fill` | `var(--icon-fill-dark)` | `var(--icon-fill-dark)` | Header contact icon fill |
| **Buttons (.contact-button, .cv-button)** | | | |
| `--button-bg` | `#efefef` | `#2a2a2a` | Action button background |
| `--button-text` | `#333` | `#e0e0e0` | Action button label color |
| `--button-hover-bg` | `#333` | `#444444` | Action button hover background |
| `--button-hover-text` | `#fff` | `#ffffff` | Action button hover label color |
| **Text Selection** | | | |
| `--selection-bg` | `rgba(51, 51, 51, .8)` | `rgba(107, 164, 232, .5)` | Highlighted text background |
| `--selection-color` | `#fff` | `#ffffff` | Highlighted text color |
| **Dark Mode Toggle Component** | | | |
| `--toggle-btn-bg` | `transparent` | `transparent` | Toggle button background |
| `--toggle-btn-border` | `var(--border-color)` | `var(--border-color)` | Toggle button border |
| `--toggle-btn-color` | `var(--text-color)` | `var(--text-color)` | Toggle button icon color |
| `--toggle-btn-hover-bg` | `var(--button-bg)` | `var(--button-bg)` | Toggle button hover background |
| `--toggle-btn-focus-ring`| `var(--accent-color)`| `var(--accent-color)`| Toggle button focus ring outline |

### Two-Tier Activation Mechanism

1. **Automatic Detection:**
   ```scss
   @media (prefers-color-scheme: dark) {
     :root:not([data-color-scheme="light"]) {
       --bg-color: #121212;
       --text-color: #e0e0e0;
       // ...
     }
   }
   ```
2. **Explicit User Pin:**
   ```scss
   :root[data-color-scheme="dark"],
   :root[data-theme="dark"] {
     --bg-color: #121212;
     --text-color: #e0e0e0;
     // ...
   }
   ```

### Print Media Resets

When printing to physical paper or PDF, [`../_sass/_dark-mode.scss`](../_sass/_dark-mode.scss) enforces a strict print reset:

```scss
@media print {
  :root {
    --bg-color: #ffffff !important;
    --text-color: #000000 !important;
    --border-color: #cccccc !important;
    --card-bg: transparent !important;
  }
  .dark-mode-toggle {
    display: none !important;
  }
}
```

---

## WCAG 2.2 Accessibility & High-Contrast Standards

- **Contrast Ratios:** All color tokens satisfy WCAG 2.2 Level AA requirements (minimum 4.5:1 contrast for normal text and 3:1 for large text).
- **Focus Rings:** Interactive elements feature high-contrast visible focus outlines:
  ```scss
  :focus-visible {
    outline: 2px solid var(--accent-color);
    outline-offset: 2px;
  }
  ```
- **Screen-Reader Utility:**
  ```scss
  .sr-only {
    position: absolute !important;
    width: 1px !important;
    height: 1px !important;
    padding: 0 !important;
    margin: -1px !important;
    overflow: hidden !important;
    clip: rect(0, 0, 0, 0) !important;
    white-space: nowrap !important;
    border: 0 !important;
  }
  ```

---

## Locale Typography & RTL Mechanics

1. **Per-locale typography:** `_layouts/resume.html` emits `--font-locale` (from the locale's `font_family`, when non-empty) and `--line-height-locale` (from `line_height`) in an inline `:root` style. `_sass/_resume-ltr.scss` reads both with the theme defaults as fallbacks. To change a language's font, override its locale file (see [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md#typography--rtl)); no SCSS edit is needed.
2. **Direction selects the entrypoint:** the layout links `cv-<direction>.css`, where `direction` comes from the locale file.
3. **Root direction:** RTL overrides activate via `html[dir="rtl"]`.
4. **Horizontal mirroring:** floated elements (avatar, social bar, job title) flip alignment.
5. **Punctuation isolation:** in RTL locales the templates wrap phone numbers, emails, URLs, and credential IDs in `dir="ltr"`.
