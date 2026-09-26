# `_layouts` Architecture Guide

The theme's layouts in [`../_layouts/`](../_layouts/): what each one renders, how the resume layout resolves its language and data, and how to build a custom layout on the same pieces.

---

## Table of Contents

- [Overview & Layout Hierarchy](#overview--layout-hierarchy)
- [Language Resolution](#language-resolution)
- [Layout Inventory](#layout-inventory)
  - [1. `default.html` (Base Layout)](#1-defaulthtml-base-layout)
  - [2. `profile.html` (Portfolio Landing)](#2-profilehtml-portfolio-landing)
  - [3. `resume.html` (Resume, Every Language)](#3-resumehtml-resume-every-language)
  - [4. `error.html` (Multilingual HTTP Error Suite)](#4-errorhtml-multilingual-http-error-suite)
- [Dynamic Data Resolution](#dynamic-data-resolution)
- [Resume Rendering Pipeline](#resume-rendering-pipeline)
- [Dark Mode & Anti-FOUC Mechanics](#dark-mode--anti-fouc-mechanics)
- [Creating Custom Layouts](#creating-custom-layouts)

---

## Overview & Layout Hierarchy

Pages select a layout in front matter. A resume page is `layout: resume` plus `lang: <code>`; there is no per-language layout.

```text
_layouts/default.html   (base shell: <head>, anti-FOUC, dark mode, footer)
 └── _layouts/error.html  (HTTP 404, 403, 500, 503)

_layouts/profile.html   (standalone landing page)
_layouts/resume.html    (standalone resume, one layout for every language and direction)
```

---

## Language Resolution

Every layout and include resolves the active language the same way:

```liquid
{% assign lang = page.lang | default: site.default_lang | default: 'en' %}
{% assign locale = site.data.locales[lang] | default: site.data.locales[site.default_lang] %}
{% assign lang_cfg = site.languages[lang] %}
```

- `locale` is the merged locale file `_data/locales/<lang>.yml` (theme file with any site override on top). It supplies `direction`, fonts, line height, UI strings, month names, and error copy.
- `lang_cfg` is the `languages.<lang>` config block. It supplies `data_path`, `url`, `header_intro`, `name`, `resume_title`, `address`, and `avatar_alt`.

Schemas for both are in [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md) and [`CONFIG_GUIDE.md`](CONFIG_GUIDE.md#3-languages).

---

## Layout Inventory

### 1. `default.html` (Base Layout)

- **File:** [`../_layouts/default.html`](../_layouts/default.html)
- **Role:** Shell for markdown pages and error pages.
- `<html lang="{{ lang }}" dir="{{ locale.direction }}">`, skip link text from `locale.ui.skip_to_content`.
- Includes [`shared-head.html`](../_includes/shared-head.html), a stylesheet link to `assets/css/main.css`, `{% seo %}`, and the analytics includes.
- Emits `<link rel="me">` when `site.social_links.mastodon` is set.
- Includes [`dark-mode-toggle.html`](../_includes/dark-mode-toggle.html) and [`language-switcher.html`](../_includes/language-switcher.html) (suppressed on `layout: error` pages), and wraps content in `<main class="main-content" id="main-content">`.

### 2. `profile.html` (Portfolio Landing)

- **File:** [`../_layouts/profile.html`](../_layouts/profile.html)
- **Role:** Standalone landing page, independent of `default.html` so its centering styles do not leak.
- Same `lang` / `dir` resolution, skip link, dark mode toggle, and language switcher as `default.html`.
- Stylesheet [`../assets/css/profile.scss`](../assets/css/profile.scss) (compiled to `assets/css/profile.css`, linked directly in the layout's `<head>`), styled by [`../_sass/_profile-page.scss`](../_sass/_profile-page.scss).

### 3. `resume.html` (Resume, Every Language)

- **File:** [`../_layouts/resume.html`](../_layouts/resume.html)
- **Role:** The resume for any configured language, LTR or RTL.
- **Head:**
  - `<html lang="{{ lang }}" dir="{{ locale.direction }}">`.
  - Loads `locale.font_url` when set, else the default Lora and Open Sans stylesheet; neither loads when `disable_google_fonts: true` or `resume_theme: no-custom-fonts`.
  - Emits `--font-locale` (from `locale.font_family`, when non-empty) and `--line-height-locale` (from `locale.line_height`) in an inline `:root` style.
  - Links `assets/css/cv-{{ locale.direction }}.css`, so LTR locales get `cv-ltr.css` and RTL locales get `cv-rtl.css`.
  - Includes [`hreflang.html`](../_includes/hreflang.html), `{% seo %}`, and the analytics head include.
- **Header:** avatar (when `resume_avatar: true`), `lang_cfg.name`, the contact row (when `display_header_contact_info: true`), the header language list (when `resume_section.lang_header` is set), `lang_cfg.resume_title`, social icons, the `header.yml` intro (when `lang_cfg.header_intro: true`), and the contact button (per `resume_looking_for_work`).
- **Contact row:** icon first, then text, in every direction. Phone numbers and emails carry `dir="ltr"`. The date of birth goes through [`date-formatter.html`](../_includes/date-formatter.html).
- **Body:** loops `site.resume_section_order` through [`resume-section.html`](../_includes/resume-section.html), then the print-only social links section when `resume_print_social_links` is set.
- **Footer:** localized "last generated" line and, when `enable_live == false`, a print-only footer with the page's permalink.

### 4. `error.html` (Multilingual HTTP Error Suite)

- **File:** [`../_layouts/error.html`](../_layouts/error.html), extends `default.html`. Used by `404.html`, `403.html`, and `500.html`.
- Reads `page.code` (default `"404"`) and renders one `lang` / `dir`-tagged block per entry in `site.languages`, in config order, with `title` and `message` from that language's `locale.error_pages[code]`.
- Search form (`role="search"`) submitting `q` to the site root, labelled from `default_lang`'s `locale.error_pages.search_*` keys. A static page can't negotiate language server-side, so a small inline script reads `navigator.language` and swaps in a configured language's `search_*` text when it matches; with JavaScript disabled, the `default_lang` text stands as-is.
- Buttons: Reload (for `500`, `503`, or `page.show_reload: true`) and Home, labelled from the `default_lang` locale; then one return link per language, labelled `locale.error_pages.return_link (locale.ui.language_name)`, pointing at `languages.<lang>.url`, falling back to the first page with `layout: resume` and that `lang`.
- [`../_plugins/error_pages_generator.rb`](../_plugins/error_pages_generator.rb) adds `404.html`, `403.html`, and `500.html` to consuming sites that do not define their own. It only runs when the gem is declared in the `Gemfile`'s `:jekyll_plugins` group.

---

## Dynamic Data Resolution

`resume.html` calls [`../_includes/data-loader.html`](../_includes/data-loader.html) with `path=lang_cfg.data_path`. The include binds `resume_data` by walking `site.data` one dot-separated segment at a time:

```liquid
{%- assign resume_data = site.data -%}
{%- if data_path != blank -%}
  {%- assign path_parts = data_path | split: '.' -%}
  {%- for part in path_parts -%}
    {%- assign resume_data = resume_data[part] -%}
  {%- endfor -%}
{%- endif -%}
```

Bracket access (`resume_data[part]`) is what makes folder names like `2025-06` or `20250621-PM` work; Liquid dot notation (`site.data.2025-06`) fails on leading digits and hyphens.

```yaml
languages:
  en:
    data_path: en              # site.data.en
  ar:
    data_path: "2025-06.v1-ar" # site.data["2025-06"]["v1-ar"]
  es:
    data_path: ""              # site.data (files directly in _data/)
```

When called without `path`, the include falls back to `site.languages[page.lang or default_lang].data_path`.

---

## Resume Rendering Pipeline

```text
1. Resolve lang, locale, lang_cfg; load resume_data from lang_cfg.data_path
2. <head>: shared-head, locale font + CSS variables, cv-<direction>.css, hreflang, SEO, analytics
3. Header: avatar, name, contact row, header languages, title, social icons, intro, contact button
4. Sections: for each name in site.resume_section_order
     {% include resume-section.html section_name=section_name lang=lang %}
5. Print-only social links (print-social-links.html)
6. Footer and print-only permalink footer
```

---

## Dark Mode & Anti-FOUC Mechanics

Layouts include the toggle directly:

```liquid
{% include dark-mode-toggle.html %}
```

1. **Site level:** `dark_mode: auto` (default) is CSS-only system matching with no toggle. `dark_mode: enabled` or `true` renders the toggle.
2. **Page level:** front matter `dark_mode: false` or `true` overrides the site setting for that page.
3. **Anti-FOUC:** the inline script in [`../_includes/shared-head.html`](../_includes/shared-head.html) applies a stored preference before stylesheets load.

---

## Creating Custom Layouts

A new language never needs a new layout; see [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md#adding-a-language). For a different page design (for example `_layouts/academic-cv.html`):

1. Start from `default.html`, or copy `resume.html` for a resume variant.
2. Resolve `lang`, `locale`, and `lang_cfg` with the three lines in [Language Resolution](#language-resolution), and read every visible string from `locale.ui` so the layout works in every language.
3. Load data with `{% include data-loader.html path=lang_cfg.data_path %}`.
4. Reuse the shared includes ([`shared-head.html`](../_includes/shared-head.html), [`avatar.html`](../_includes/avatar.html), [`dark-mode-toggle.html`](../_includes/dark-mode-toggle.html), [`resume-section.html`](../_includes/resume-section.html)).
5. Reference it from a page:
   ```yaml
   ---
   layout: academic-cv
   lang: en
   ---
   ```
