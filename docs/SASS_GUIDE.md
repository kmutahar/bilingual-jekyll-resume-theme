# SCSS/SASS Guide (_sass)

A contributor- and user-friendly tour of the theme’s styling system: how styles are organized, how entrypoints compile, what each partial does, and safe ways to customize or extend.

---

## Table of Contents

- [How styles compile](#how-styles-compile)
  - [Entrypoints and outputs](#entrypoints-and-outputs)
  - [Why @use (not @import)](#why-use-not-import)
  - [Overriding theme partials in a site](#overriding-theme-partials-in-a-site)
- [File inventory (what each partial does)](#file-inventory-what-each-partial-does)
  - [_variables.scss](#1-_variablesscss)
  - [_mixins.scss](#2-_mixinsscss)
  - [_normalize.scss](#3-_normalizescss)
  - [_base.scss](#4-_basesscss)
  - [_layout.scss](#5-_layoutscss)
  - [_resume.scss](#6-_resumescss)
  - [_resume-rtl.scss](#7-_resume-rtlscss)
  - [_profile.scss](#8-_profilescss)
  - [_all-pages.scss](#9-_all-pagesscss)
- [Responsive, print, and RTL strategy](#responsive-print-and-rtl-strategy)
- [Variables reference](#variables-reference)
- [Mixins reference](#mixins-reference)
- [Customization recipes](#customization-recipes)
  - [Override variables without forking](#override-variables-without-forking)
  - [Change fonts (EN/AR)](#change-fonts-enar)
  - [Adjust layout container and grid](#adjust-layout-container-and-grid)
  - [Tweak section borders and spacing](#tweak-section-borders-and-spacing)
  - [Languages table spacing/print behavior](#languages-table-spacingprint-behavior)
  - [Add a new SCSS partial](#add-a-new-scss-partial)
  - [Theme variants hook](#theme-variants-hook)
- [Pitfalls and tips](#pitfalls-and-tips)

---

## How styles compile

### Entrypoints and outputs

These three files are compiled by Jekyll/Sass into CSS. They live under `assets/css/` and contain front matter (`---`) so Jekyll treats them as entrypoints:

- `assets/css/cv.scss` → `assets/css/cv.css`
  - English resume CSS
- `assets/css/cv-ar.scss` → `assets/css/cv-ar.css`
  - Arabic resume CSS (loads RTL overrides)
- `assets/css/main.scss` → `assets/css/main.css`
  - Profile/landing and general site styles

Each entrypoint wires up modules from `_sass/` via `@use`.

### Why @use (not @import)

This theme uses modern Dart Sass `@use`:
- Namespaces variables and mixins (e.g., `variables.$white`, `@include mixins.clearfix`)
- Prevents accidental global leakage
- Allows overriding `!default` variables by providing a replacement module earlier on the load path

### Overriding theme partials in a site

Jekyll adds both your site and the theme gem to Sass load paths. If your consuming site defines a file with the same logical path/name as the theme’s module (e.g., `_sass/variables.scss`), `@use "variables";` will resolve to your site’s copy first. This is the preferred way to override variables/mixins without forking.

Notes:
- Many variables are declared with `!default`, enabling safe overrides.
- Because `@use` namespaces members, you still reference them as `variables.$name` inside modules that load `variables`.
- You can also duplicate an entrypoint (e.g., copy `assets/css/cv.scss` into your site) and `@use` your customized modules.

---

## File inventory (what each partial does)

### 1) `_variables.scss`
Purpose: central constants.
- Layout: `$container-width` (980px), `$grid-gutter` (10px)
- Colors: `$white`, `$black`, `$text_color`
- Typography stacks: `$body-font`, `$mono-font`
- Sizes: `$body-font-size` (currently not consumed globally but available)

Most are marked `!default` so sites can override.

---

### 2) `_mixins.scss`
Purpose: reusable helpers.
- Utilities: `border-radius`, `transition`, `clearfix`
- Media queries: `media_max($w)`, `media_min($w)`, `media_larger_than_mobile` (min-width: 600px), `media_mobile` (max-width: 600px)
- Typography: `sans[_light|_regular|_bold|_extrabold]`, `serif[_regular|_bold]`
- Layout accents: `section_border`, `section_border_thin`

Used across base/layout/resume for consistent typography and spacing.

---

### 3) `_normalize.scss`
Purpose: Normalize.css v8.0.1 for cross-browser baseline (headings, forms, interactive elements, etc.).

---

### 4) `_base.scss`
Purpose: Global element defaults and shell wrappers.
- Universal `box-sizing: border-box`
- `html` background; `body` typography (`@include mixins.serif`, `font-size: 16px`, `line-height: 1.5`)
- `.wrapper` and `.group` clearfix patterns
- Text selection colors

---

### 5) `_layout.scss`
Purpose: Container and light grid utilities.
- `.container` centered fixed width (variables-driven)
- `.columns` row wrapper
- `.column` and width helpers: `.one-third`, `.two-thirds`, `.one-half`, `.three-fourths`, `.one-fifth`, `.four-fifths`
- `.single-column` padding helper
- `.table-column` equal-width table-cell columns

---

### 6) `_resume.scss`
Purpose: Resume-specific components and typography.
- Section headers with bold, condensed titles (`.section-header`)
- Page header: avatar, name, contact row, title bar, executive summary
- Social links bar (hoverable SVGs)
- Contact CTA button (also supports a “not-looking” modifier)
- Content sections:
  - `.resume-item-title`, `.resume-item-details`, `.resume-item-copy`
  - Link styling for readability and print
  - Languages table: responsive block-on-mobile and print-optimized two-column layout
- Footer and print-only utilities
- Print media overrides (smaller typography; thinner section borders)

---

### 7) `_resume-rtl.scss`
Purpose: Arabic/RTL overrides scoped to `html[dir="rtl"]`.
- Sets Arabic-friendly font stack (Cairo, Noto Naskh Arabic)
- Applies Arabic fonts to headings and content blocks
- Right-aligns key text blocks
- Flips floats (e.g., header title, social links) for RTL
- Adjusts lists and the languages table for RTL direction

Loaded only by `cv-ar.scss`.

---

### 8) `_profile.scss`
Purpose: Landing/profile page styles.
- System sans font stack
- Avatar, name, about text
- Social links list
- Prominent “CV” button

Used by `assets/css/main.scss` entrypoint.

---

### 9) `_all-pages.scss`
Purpose: Small shared bits across pages.
- SVG icon defaults and header contact icon sizing
- Footer styles (shared with `.page-footer` in resume)

---

## Responsive, print, and RTL strategy

- Responsive: Mixins `media_larger_than_mobile` and `media_mobile` (600px breakpoint) provide simple adjustments (e.g., stacking → floats).
- Print: Dedicated `@media print` blocks in `_resume.scss` keep the output compact and readable (smaller fonts, non-stacking languages table, print-only helpers).
- RTL: `_resume-rtl.scss` is loaded only by the Arabic entrypoint; overrides are scoped under `html[dir="rtl"]` to avoid affecting LTR pages.

---

## Variables reference

From `_variables.scss` (selected):

- `$container-width` (default 980px): resume max width used by `.container`
- `$grid-gutter` (default 10px): column padding and row negative margins
- `$white`, `$black`, `$text_color`: core colors
- `$body-font`, `$mono-font`: font stacks for base and code
- `$body-font-size` (13px): available for consumers; base currently uses an explicit 16px

All variables declared `!default` can be overridden by defining a `variables.scss` module in your site.

---

## Mixins reference

- `@include border-radius($radius)`
- `@include transition($value)`
- `@include clearfix`
- `@include media_max($px)` / `@include media_min($px)`
- `@include media_larger_than_mobile` (min-width: 600px)
- `@include media_mobile` (max-width: 600px)
- Typography:
  - `@include sans[_light|_regular|_bold|_extrabold]`
  - `@include serif[_regular|_bold]`
- Accents: `@include section_border` / `@include section_border_thin`

Example:
```scss
.my-cta {
  @include sans_bold;
  @include border-radius(4px);
  @include transition(all .2s ease);
}
```

---

## Customization recipes

### Override variables without forking

In your consuming site, add `_sass/variables.scss` with your values. Because the theme uses `!default`, your module will be used instead.

```scss
// _sass/variables.scss (in your site)
$container-width: 900px !default;
$grid-gutter: 16px !default;
$text_color: #222 !default;
```

No other changes needed—entrypoints that `@use "variables";` will pick up your overrides.

### Change fonts (EN/AR)

- English resume and general pages inherit fonts from mixins.
- Arabic resume sets fonts under `html[dir="rtl"]` in `_resume-rtl.scss`.

Options:
1) Override typography mixins in your own `_sass/mixins.scss` (advanced; ensure API compatibility), or
2) Add a small override partial in your site and `@use` it from a copied entrypoint, for example:

```scss
// assets/css/cv.scss (copied into your site)
---
---
@use "normalize";
@use "mixins";
@use "variables";
@use "base";
@use "layout";
@use "resume";
@use "all-pages";

// Your tweaks
html { font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, sans-serif; }
```

### Adjust layout container and grid

- Change `$container-width`/`$grid-gutter` in your variables override.
- Add more widths by extending `_layout.scss` in your site (e.g., `.one-sixth`, `.five-sixths`).

### Tweak section borders and spacing

Use the provided mixins:
```scss
.section-header { @include section_border_thin; }
```
Or override the values by redefining the mixins in a site module with identical names (advanced).

### Languages table spacing/print behavior

- Mobile stacking is controlled via `@include media_mobile` in `_resume.scss`.
- Adjust `border-spacing` and padding in your site overrides to increase/decrease gaps.

### Add a new SCSS partial

1) Create `_sass/_your-partial.scss` in your site.
2) If you want it across the resume, copy `assets/css/cv.scss` into your site and append `@use "your-partial";`.
3) For Arabic resume only, copy `assets/css/cv-ar.scss` and import there.

### Theme variants hook

Layouts add `class="theme-{{ site.resume_theme }}"` to `<body>`. Target theme variants as:
```scss
body.theme-default .section-header h2 { /* variant-specific tweaks */ }
```
You can implement alternate themes by scoping rules under different `.theme-*` classes.

---

## Pitfalls and tips

- `@use` is namespaced: reference variables as `variables.$name` inside modules that load them.
- Variable overrides require providing a module with the same logical name (e.g., `_sass/variables.scss`) in your site; you do not edit the theme gem.
- Entry files must have front matter (`---`) or Jekyll won’t process them.
- Keep print-specific rules in `@media print` to avoid regressions on screen.
- For RTL tweaks, scope overrides under `html[dir="rtl"]` to avoid impacting LTR.
