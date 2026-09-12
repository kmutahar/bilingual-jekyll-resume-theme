# _layouts Guide

A comprehensive, contributor-friendly overview of `_layouts/` in this theme: what each layout is for, how data flows through them, how sections render, and how to extend or create new layouts safely.

---

## Table of Contents

- [What are Jekyll layouts?](#what-are-jekyll-layouts)
- [Layout inventory and responsibilities](#layout-inventory-and-responsibilities)
  - [default.html](#1-_layoutsdefaulthtml)
  - [profile.html](#2-_layoutsprofilehtml)
  - [resume-en.html](#3-_layoutsresume-enhtml)
  - [resume-ar.html](#4-_layoutsresume-arhtml)
  - [error.html](#5-_layoutserrorhtml)
- [Resume data loading (the `resume_data` object)](#resume-data-loading-the-resume_data-object)
  - [Configuring `active_resume_path_en` and `active_resume_path_ar`](#configuring-active_resume_path_en-and-active_resume_path_ar)
  - [Dot-path traversal and bracket-notation](#dot-path-traversal-and-bracket-notation)
  - [Examples](#examples)
- [Rendering flow inside resume layouts](#rendering-flow-inside-resume-layouts)
  - [Head, SEO, analytics](#1-head-seo-analytics)
  - [Header (name, avatar, contact, social)](#2-header)
  - [Dynamic section rendering](#3-dynamic-section-rendering)
  - [Print-only blocks and footers](#4-print-only-blocks-and-footers)
- [Arabic (RTL) layout specifics](#arabic-rtl-layout-specifics)
- [Configuration keys consumed by layouts](#configuration-keys-consumed-by-layouts)
- [Creating a new layout](#creating-a-new-layout)
- [Creating a new resume-like layout (another language or variant)](#creating-a-new-resume-like-layout-another-language-or-variant)
- [Common pitfalls and troubleshooting](#common-pitfalls-and-troubleshooting)

---

## What are Jekyll layouts?

Layouts wrap pages. A page chooses a layout via its front matter (e.g., `layout: resume-en`). The layout defines the overall HTML structure and where page content or reusable includes appear. This theme ships with specialized layouts for the resume (EN/AR) and a general-purpose base layout.

**For beginners:** If you're new to Jekyll, think of layouts as templates that define the structure of your pages. You create a page file (like `resume-en.md`) and tell it which layout to use. The layout then handles all the HTML structure, styling, and includes the content from your data files.

---

## Layout inventory and responsibilities

### 1) `_layouts/default.html`

Purpose: Base wrapper used by most non-resume pages.

Key responsibilities:
- Pulls shared `<head>` tags via `{% include shared-head.html %}`
- Loads site-wide CSS for non-resume pages via `{% include main-head.html %}` (which brings in `assets/css/main.css`)
- Emits SEO tags via `{% seo %}`
- Injects analytics into the head (`analytics-head.html`) and adds the body `<noscript>` fallback (`analytics-body.html`)
- Renders page content via `{{ content }}`
- Simple footer with copyright
- Adds `<link rel="me">` using `site.social_links.mastodon` when present

When to use: general pages (docs, landing, etc.).

---

### 2) `_layouts/profile.html`

Purpose: Thin wrapper that extends `default.html` and renders `{{ content }}`. Use it for the profile/landing page when you don’t need resume-specific scaffolding.

---

### 3) `_layouts/resume-en.html`

Purpose: English (LTR) resume layout. It:
- Computes the `resume_data` object (see below)
- Includes head assets via `{% include resume-head-en.html %}` (Google Fonts, `assets/css/cv.css`, favicons, `hreflang.html`)
- Renders header (avatar, name, contact, social icons, executive summary, CTA)
- Renders all resume sections dynamically using `{% include resume-section-en.html section_name=... %}` in the order specified by `site.resume_section_order`
- Adds optional print-only social links
- Emits a footer with a generation timestamp
- Sets a theme body class: `class="theme-{{ site.resume_theme }}"` (use in CSS)

---

### 4) `_layouts/resume-ar.html`

Purpose: Arabic (RTL) resume layout. It mirrors `resume-en.html` with language-appropriate text and RTL direction.
- `<html lang="ar" dir="rtl">`
- Includes `{% include resume-head-ar.html %}` (Cairo font by default, `assets/css/cv-ar.css`, favicons, `hreflang.html`)
- Localized header labels and CTA text
- Renders sections via `{% include resume-section-ar.html section_name=... %}` with Arabic labels and date formatting (`ar-date.html`)
- Optional print-only social links and footer timestamp (localized text)

---

### 5) `_layouts/error.html`

Purpose: Reusable bilingual HTTP error page wrapper (extending `default.html`). Used by `404.html`, `403.html`, and `500.html`.

Key responsibilities:
- Reads `page.code` (e.g. `404`, `403`, `500`) and pulls bilingual titles, descriptions, and action labels from `_data/error_pages.yml`
- Renders an accessible, high-contrast status code badge (`404`, `403`, `500`)
- Renders an English error block (`lang="en"`) with heading and description
- Renders an isolated RTL Arabic error block (`lang="ar" dir="rtl"`) with localized heading and description
- Provides standard quick return paths: Home (`/`), Resume EN (`/resume/en/`), and Resume AR (`/resume/ar/`)
- For `500` and `503` server errors, renders an interactive "Reload Page / إعادة تحميل الصفحة" button
- Supports arbitrary front-matter overrides: `title_en`, `desc_en`, `title_ar`, `desc_ar`, `show_reload: true`

---

## Resume data loading (the `resume_data` object)

Both resume layouts compute a single variable, `resume_data`, which points to the active subtree under `_data/`. This allows switching datasets without touching templates.

### Configuring `active_resume_path_en` and `active_resume_path_ar`

Set site-level keys in `_config.yml`:

```yaml
# Choose which subtree of _data/ to use for each language
# Examples below in the next section
active_resume_path_en: "en"  # Path for English resume
active_resume_path_ar: "ar"  # Path for Arabic resume
```

- If set to a single key (e.g., `"en"`) → `resume_data = site.data.en` (**recommended for beginners**)
- If set to a dotted path (e.g., `"2025-06.20250621-PM"`) → the layout walks down each segment safely (advanced)
- If `active_resume_path_en` or `active_resume_path_ar` is empty or nil → `resume_data = site.data` (uses root `_data/`, **advanced users only**)

**Important:** The English layout (`resume-en.html`) reads `site.active_resume_path_en`, and the Arabic layout (`resume-ar.html`) reads `site.active_resume_path_ar`. This allows you to use different data folders for each language.

**Recommended approach (for beginners):** Always use `"en"` and `"ar"` to place files in `_data/en/` and `_data/ar/` folders. This is the recommended approach even if you're only using one language, as it keeps your data organized and makes it easy to add more languages later.

**Advanced users:** If you maintain multiple variants (time-boxed, roles, locales) under `_data/`, you can use nested paths or root paths, but this is not recommended for beginners.

### Dot-path traversal and bracket-notation

Implementation highlights inside the layouts:
- Split the string by `.` into parts: `path_parts = data_path_string | split: '.'`
- Start at `site.data` and iterate the parts, reassigning: `data_object = data_object[part]`
- Bracket notation is used intentionally so keys like `2025-06` (that begin with digits or contain dashes) are supported
- After the loop: `resume_data = data_object`

### Examples

```yaml
# 1) Recommended: Use language subtrees (recommended for beginners)
active_resume_path_en: "en"
active_resume_path_ar: "ar"
# EN: resume_data.experience == site.data.en.experience
# AR: resume_data.experience == site.data.ar.experience
# This is the recommended approach even if you're only using one language

# 2) Advanced: Use nested subtrees for versioning
active_resume_path_en: "2025-06.20250621-PM"
active_resume_path_ar: "2025-06.20250621-PM"
# resume_data.experience == site.data['2025-06']['20250621-PM'].experience

# 3) Advanced: Use files directly under _data/ (not recommended for beginners)
active_resume_path_en: ""
active_resume_path_ar: ""
# resume_data.experience == site.data.experience
# Only use this if you place files directly in _data/ root (advanced users only)
```

---

## Rendering flow inside resume layouts

### 1) Head, SEO, analytics
- Shared meta from `shared-head.html` — includes `<meta name="color-scheme" content="light dark">` and an inline FOUC-prevention script that reads `localStorage["color-scheme"]` and applies the saved theme attribute before first paint
- Resume-specific head from `resume-head-*.html` (CSS, fonts, favicons)
- `{% seo %}` prints SEO meta and Open Graph/Twitter cards
- `analytics-head.html` adds GTM or GA4; `analytics-body.html` adds GTM `<noscript>` in the body

### 2) Header
- Optional avatar (toggle via `site.resume_avatar`)
- Name from `site.name.first|middle|last` and/or `site.name_ar.first|middle|last`
- Optional contact row (`site.display_header_contact_info`) showing phone/email/address and DoB
  - When `site.enable_live` is true, uses `phone_live` and `email_live`; otherwise `phone` and `email`
  - Small inline icons are included from `vendors/lineicons-v4.0/`
- Title bar with `site.resume_title` (or `resume_title_ar` for AR)
- Social icon list when `site.social_links` is configured (see `_includes/social-links.html`)
- Executive summary (controlled by `resume_header_intro_en`/`resume_header_intro_ar` flags, reads from `resume_data.header.intro`)
- CTA button controlled by `site.resume_looking_for_work`

### 3) Dynamic section rendering
- The layouts loop over `site.resume_section_order` and, for each `section_name`, include either `resume-section-en.html` or `resume-section-ar.html`
- Each section is further gated by `site.resume_section.<name>` and by `active: true` flags in your data files

### 4) Print-only blocks and footers
- If `site.resume_print_social_links` is true, a print-only section renders text social links via `_includes/print-social-links.html`
- Footers include a generation timestamp and copyright

---

## Arabic (RTL) layout specifics

- `dir="rtl"` and appropriate Arabic `lang` attribute
- Labels, CTA, and some icon placement differ for better RTL legibility
- Dates use `ar-date.html` for Arabic month names and print “حتى الآن” for present roles
- Where address text is language-specific, `resume-ar.html` reads `site.contact_info.address_ar`

---

## Configuration keys consumed by layouts

Site/global keys used across the layouts (non-exhaustive, but most relevant):

```yaml
title: "Your Site Title"
name:
  first: "First"
  middle: "M."
  last: "Last"
resume_title: "Job Title"
resume_title_ar: "المسمّى الوظيفي"
resume_header_intro_en: true  # Enable English intro (reads from resume_data.header.intro)
resume_header_intro_ar: true  # Enable Arabic intro (reads from resume_data.header.intro)
resume_avatar: true

# Header contact toggles
enable_live: false
contact_info:
  phone: "+1 555 555 5555"
  email: "me@example.com"
  address: "City, Country"
  address_ar: "المدينة، الدولة"
  dob: 1990-01-01
  phone_live: "+1 555 555 0000"
  email_live: "me@live.example.com"

display_header_contact_info: true

# Social links (icons rendered when set)
social_links:
  github: https://github.com/you
  linkedin: https://www.linkedin.com/in/you/
  # ... (see includes guide for full list)

# Resume theme hook (CSS can target .theme-<value> on <body>)
resume_theme: default

# Job search CTA behavior
resume_looking_for_work: true

# Sections
resume_section:
  experience: true
  education: true
  certifications: true
  courses: true
  volunteering: true
  projects: true
  skills: true
  recognition: true
  associations: true
  interests: true
  languages: true
  links: true
  lang_header: false  # if true, show compact languages in header

# Order in which sections are rendered
resume_section_order:
  - experience
  - education
  - projects
  - skills
  - languages
  - links

# Print behavior
resume_print_social_links: true

# Dark mode (controls whether a toggle button is rendered)
# "auto" (default): CSS-only system detection, no toggle button
# "enabled": renders an interactive toggle button in both EN and AR layouts
resume_dark_mode: auto

# Active data subtree for resume_data (separate for each language)
active_resume_path_en: "en"
active_resume_path_ar: "ar"
```

Per-page front matter (for multilingual SEO):

```yaml
---
layout: resume-en
permalink: /resume/en/
lang: en
t_id: resume
---
```
```yaml
---
layout: resume-ar
permalink: /resume/ar/
lang: ar
t_id: resume
---
```

---

## Creating a new layout

1) Create a file under `_layouts/your-layout.html`.
2) Start from `default.html` for a minimal skeleton (shared head, main CSS, SEO, analytics, `{{ content }}`).
3) If your page needs resume CSS or multilingual SEO, include the relevant head include(s) and `hreflang.html`.
4) Keep complex markup in `_includes/` so the layout stays thin.

Example skeleton:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    {% include shared-head.html %}
    {% include main-head.html %}
    {% seo %}
    {% include analytics-head.html %}
  </head>
  <body>
    {% include analytics-body.html %}
    {{ content }}
  </body>
</html>
```

---

## Creating a new resume-like layout (another language or variant)

1) Duplicate `resume-en.html` or `resume-ar.html` to `_layouts/resume-xx.html`.
2) Set `<html lang="xx" dir="rtl|ltr">` appropriately.
3) Create a head include like `_includes/resume-head-xx.html` (fonts + CSS), and include `hreflang.html` inside it.
4) Create a section include like `_includes/resume-section-xx.html` with localized labels, and mirror the structure used by EN/AR.
5) Optionally add a localized CTA and header strings.
6) Update pages to use `layout: resume-xx` and set `lang` and `t_id` for SEO.

Tip: Keep date formatting and “present” text consistent with the target language.

---

## Common pitfalls and troubleshooting

- Sections not rendering? Check `resume_section_order`, `resume_section.<name>` flags, and `active: true` on data items.
- Wrong data showing? Confirm `active_resume_path_en`/`active_resume_path_ar` and your `_data/` structure.
- Arabic months not displayed? The theme includes `_data/ar/months.yml` by default. If you're using a custom data path, ensure `site.data.ar.months` is accessible (see includes guide: `ar-date.html`).
- Icons missing? Verify the SVG exists under `/_includes/vendors/lineicons-*/` and the include path is correct.
- SEO alternates missing? Ensure both pages share the same `t_id`, and each has a `lang` value.

---
