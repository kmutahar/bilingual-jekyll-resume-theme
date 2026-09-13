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
  - [4. `_base.scss`](#4-_basesscss)
  - [5. `_layout.scss`](#5-_layoutscss)
  - [6. `_resume.scss`](#6-_resumescss)
  - [7. `_resume-rtl.scss`](#7-_resume-rtlscss)
  - [8. `_profile.scss`](#8-_profilescss)
  - [9. `_all-pages.scss`](#9-_all-pagesscss)
  - [10. `_dark-mode.scss`](#10-_dark-modescss)
- [The Dark Mode Token System](#the-dark-mode-token-system)
  - [Design Tokens Table](#design-tokens-table)
  - [Two-Tier Activation Mechanism](#two-tier-activation-mechanism)
  - [Print Media Resets](#print-media-resets)
- [WCAG 2.2 Accessibility & High-Contrast Standards](#wcag-22-accessibility--high-contrast-standards)
- [Arabic (RTL) Layout Mechanics](#arabic-rtl-layout-mechanics)

---

## Entrypoints & Compilation Architecture

### Stylesheet Entrypoints

Jekyll compiles files in [`../assets/css/`](../assets/css/) that start with YAML front matter into final static CSS assets:

| Source SCSS | Compiled Output CSS | Consuming Layouts |
|---|---|---|
| [`../assets/css/cv.scss`](../assets/css/cv.scss) | `assets/css/cv.css` | [`../_layouts/resume-en.html`](../_layouts/resume-en.html) |
| [`../assets/css/cv-ar.scss`](../assets/css/cv-ar.scss) | `assets/css/cv-ar.css` | [`../_layouts/resume-ar.html`](../_layouts/resume-ar.html) |
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
  - `$container-width: 980px !default;` — Maximum resume container width.
  - `$grid-gutter: 10px !default;` — Grid column padding and gutters.
  - `$body-font`, `$mono-font` — Base fallback typography stacks.

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

### 6. `_resume.scss`

- **File:** [`../_sass/_resume.scss`](../_sass/_resume.scss)
- **Role:** English (LTR) resume styling.
- **Components Styled:**
  - Header: Avatar (`.avatar`), candidate name, contact info row, and social links bar.
  - Contact CTA button (`.contact-button`) and "not looking" modifier.
  - Section headers (`.section-header`) and item cards (`.resume-item`).
  - Two-column responsive Languages table.
  - Print-specific media overrides (`@media print`).

---

### 7. `_resume-rtl.scss`

- **File:** [`../_sass/_resume-rtl.scss`](../_sass/_resume-rtl.scss)
- **Role:** RTL Arabic overrides scoped under `html[dir="rtl"]`.
- **Key Overrides:**
  - Sets Arabic font stacks (Cairo, Noto Naskh Arabic) with increased line-heights (`1.6`) to prevent diacritic clipping.
  - Flips horizontal floats, text alignments, borders, and margins.
  - Repositions timeline bullets and contact icons for natural RTL reading order.

---

### 8. `_profile-page.scss` / `_profile.scss`

- **Files:** [`../_sass/_profile-page.scss`](../_sass/_profile-page.scss) (and forwarder [`../_sass/_profile.scss`](../_sass/_profile.scss))
- **Role:** Styles for the dedicated portfolio landing page layout ([`../_layouts/profile.html`](../_layouts/profile.html)) and entrypoint [`../assets/css/profile.scss`](../assets/css/profile.scss).
- **Architecture:** Provides clean, unconstrained vertical centering, avatar, bio typography, social icon transitions, and WCAG `.sr-only` utility without leaking onto or inheriting from generic markdown page styles.

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

All layout and resume styles reference CSS custom properties defined on `:root`:

| CSS Custom Property | Light Mode Value | Dark Mode Value | Semantic Role |
|---|---|---|---|
| `--bg-color` | `#ffffff` | `#121212` | Main page and viewport background |
| `--text-color` | `#222222` | `#e0e0e0` | Primary reading and heading typography |
| `--text-muted` | `#666666` | `#a0a0a0` | Secondary copy, timestamps, and details |
| `--border-color` | `#e5e5e5` | `#2d2d2d` | Section dividers and card borders |
| `--card-bg` | `#f8f9fa` | `#1e1e1e` | Button backgrounds and code blocks |
| `--link-color` | `#0969da` | `#58a6ff` | Interactive hyperlinks |
| `--link-hover` | `#0550ae` | `#79b8ff` | Hyperlink hover states |
| `--accent-color` | `#2563eb` | `#3b82f6` | Focus outlines and primary accents |
| `--icon-fill` | `#4b5563` | `#9ca3af` | Social and contact SVG icon fill |
| `--selection-bg` | `#b4d5fe` | `#1f6feb` | Text selection background |

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

## Arabic (RTL) Layout Mechanics

1. **Root Direction:** RTL styles activate via `html[dir="rtl"]`.
2. **Horizontal Mirroring:** Floating elements (avatar, social bar, job title) flip alignment.
3. **Punctuation Isolation:** In Arabic templates, phone numbers and URLs are enclosed in `<span dir="ltr">` to prevent bidirectional punctuation flipping.
