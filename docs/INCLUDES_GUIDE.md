# _includes Guide

A contributor- and user-friendly deep dive into how the theme’s `_includes/` directory works, how it connects to the rest of the theme, and how to extend or customize it safely.

This guide assumes basic familiarity with Jekyll and Liquid, but includes examples you can copy/paste.

---

## Table of Contents

- [What are Jekyll includes?](#what-are-jekyll-includes)
- [How includes fit into this theme](#how-includes-fit-into-this-theme)
  - [Layouts that use includes](#layouts-that-use-includes)
  - [Data flow and configuration](#data-flow-and-configuration)
- [Include inventory (what each file does)](#include-inventory-what-each-file-does)
  - [shared-head.html](#1-shared-headhtml)
  - [main-head.html](#2-main-headhtml)
  - [resume-head-en.html](#3-resume-head-enhtml)
  - [resume-head-ar.html](#4-resume-head-arhtml)
  - [analytics-head.html](#5-analytics-headhtml)
  - [analytics-body.html](#6-analytics-bodyhtml)
  - [hreflang.html](#7-hreflanghtml)
  - [ar-date.html](#8-ar-datehtml)
  - [social-links.html](#9-social-linkshtml)
  - [print-social-links.html](#10-print-social-linkshtml)
  - [vendors/ (SVG icon packs)](#11-vendors-svg-icon-packs)
- [Dynamic section rendering (resume-section-*.html)](#dynamic-section-rendering-resume-section-html)
  - [How it works](#how-it-works)
  - [Section list and flags](#section-list-and-flags)
  - [Changing section order](#changing-section-order)
  - [Adding a new section (step-by-step)](#adding-a-new-section-step-by-step)
- [Multilingual SEO with hreflang](#multilingual-seo-with-hreflang)
- [Analytics configuration](#analytics-configuration)
- [Social links and icons](#social-links-and-icons)
- [Customization recipes](#customization-recipes)
  - [Swap fonts or CSS per language](#swap-fonts-or-css-per-language)
  - [Add a new social network](#add-a-new-social-network)
  - [Show languages in header vs its own section](#show-languages-in-header-vs-its-own-section)
  - [Customize date formats (EN/AR)](#customize-date-formats-enar)
- [Best practices](#best-practices)

---

## What are Jekyll includes?

Jekyll includes are reusable partial templates you can insert into pages or layouts with `{% include file.html %}`. They help keep layouts clean, avoid duplication, and provide configurable building blocks.

In this theme, includes are used for:
- Shared `<head>` tags and assets
- Analytics snippets
- Language SEO tags
- Social icons
- Fine-grained rendering of resume sections in English and Arabic

---

## How includes fit into this theme

### Layouts that use includes

Key layouts are in `_layouts/`:
- `default.html` — Base wrapper for general pages (profile/landing, docs). Pulls in shared head, `main.css`, SEO, and analytics.
- `resume-en.html` — English resume layout (LTR). Pulls in resume-specific head assets, SEO, analytics, and renders sections via `resume-section-en.html`.
- `resume-ar.html` — Arabic resume layout (RTL). Similar to EN but with Arabic assets, RTL direction, and `resume-section-ar.html` for localized labels and dates.

Typical include usage inside layouts:

```
{% include shared-head.html %}
{% include main-head.html %}
{% include resume-head-en.html %}
{% include resume-head-ar.html %}
{% include analytics-head.html %}
{% include analytics-body.html %}
{% include hreflang.html %}
{% include social-links.html %}
{% include print-social-links.html %}
```

### Data flow and configuration

The resume layouts compute a `resume_data` object that points to the active data subtree in `_data/`, based on `active_resume_path` configured in your site’s `_config.yml`. This lets you organize multiple datasets (e.g., different roles/versions) and switch without editing templates.

Examples:
- No path (empty or nil): `resume_data == site.data`
- `active_resume_path: en`: `resume_data == site.data.en`
- Nested path with dots: `active_resume_path: 2025-06.20250621-PM` → `resume_data == site.data['2025-06']['20250621-PM']`

Most resume includes read from `resume_data.<section>` (e.g., `experience`, `skills`, `languages`). Feature flags and ordering live in `_config.yml` (see “Dynamic section rendering” below).

---

## Include inventory (what each file does)

### 1) shared-head.html
Purpose: Common `<head>` tags used by all layouts.
- Charset, IE compatibility, viewport
- Favicon fallbacks
- Canonical URL: `{{ page.url | replace:'index.html','' | prepend: site.baseurl | prepend: site.url }}`
- Robots meta: respects `page.noindex: true`

When to edit: rarely. Safe place to add global meta tags that apply across the site.

---

### 2) main-head.html
Purpose: CSS for non-resume pages.
- Loads `assets/css/main.css`

Used by: `default.html`.

---

### 3) resume-head-en.html
Purpose: Head assets for the English resume.
- Google Fonts (Lora / Open Sans)
- `assets/css/cv.css`
- Resume favicons
- `{% include hreflang.html %}` to output alternate language links

Used by: `resume-en.html`.

---

### 4) resume-head-ar.html
Purpose: Head assets for the Arabic resume.
- Cairo font (good Arabic legibility) when `site.resume_theme == 'default'`
- `assets/css/cv-ar.css` (RTL-aware CSS)
- Resume favicons
- `{% include hreflang.html %}`

Used by: `resume-ar.html`.

---

### 5) analytics-head.html
Purpose: Add Google Tag Manager (GTM) or Google Analytics gtag to the head.

Configuration options in `_config.yml`:

```yaml
# Use GTM (preferred if you already have a container)
analytics:
  gtm: GTM-XXXXXXX

# Or use GA4 via gtag.js
analytics:
  ga: true            # enables the gtag block
  gtag: G-XXXXXXXXXX  # your GA measurement ID
```

Behavior:
- If `site.analytics.gtm` is set → injects GTM head snippet.
- Else if `site.analytics.ga` is true → injects GA4 gtag.js using `site.analytics.gtag`.

---

### 6) analytics-body.html
Purpose: Body-side analytics snippet.
- If GTM is configured, outputs the `<noscript><iframe …></noscript>` fallback for users with JS disabled.
- If GA-only, no body markup is needed (and this include produces no output).

Used by: `default.html` (and can be added to other layouts if needed) right after `<body>`.

---

### 7) hreflang.html
Purpose: Alternate language `<link rel="alternate" hreflang="…">` tags for multilingual SEO.

Requirements per page:
```yaml
# In page front matter
lang: en  # or ar, etc.
t_id: resume  # any string that identifies the translation group
```

Behavior:
- If `page.t_id` exists, it finds all pages with the same `t_id` and outputs an alternate link for each.
- It also emits an `x-default` pointing to the English page if found, as a default fallback.

Place: Already included by both resume head includes; can be used elsewhere if you have multilingual pages.

---

### 8) ar-date.html
Purpose: Arabic month name formatting for dates.

Usage in templates:
```liquid
{% include ar-date.html date=object.startdate style="MY" %}
{% include ar-date.html date=object.issue_date style="MDY" %}
```

- Parameters:
  - `date`: the Date/Time value
  - `style`: `MDY` → “Month Day, Year”; anything else → “Month Year”
- Looks up the Arabic month name via `site.data.ar.months[m]`.

Data requirement in your `_data/` (one of these structures):
```yaml
# Option A: _data/ar.yml
months:
  "1": يناير
  "2": فبراير
  "3": مارس
  "4": أبريل
  "5": مايو
  "6": يونيو
  "7": يوليو
  "8": أغسطس
  "9": سبتمبر
  "10": أكتوبر
  "11": نوفمبر
  "12": ديسمبر
```
or
```yaml
# Option B: _data/ar/months.yml
"1": يناير
"2": فبراير
# ...
```

---

### 9) social-links.html
Purpose: Renders icon links (as `<li>` items) for social profiles, only if configured in `_config.yml` under `social_links`.

Example config:
```yaml
social_links:
  github: https://github.com/your-username
  linkedin: https://www.linkedin.com/in/your-handle/
  telegram: https://t.me/your-handle
  twitter: https://twitter.com/your-handle
  medium: https://medium.com/@your-handle
  # ... others supported by default
```

- Each supported key emits a list item with an inline SVG icon from `vendors/lineicons-v5.0/`.
- Safe for screen readers and printing; external links are `rel="noopener nofollow noreferrer"`.

Used by: both resume layouts in the header’s social bar.

---

### 10) print-social-links.html
Purpose: Text-only list of social links for print/PDF.
- Controlled by `_config.yml` flag `resume_print_social_links: true`.
- Emits readable lines like “Github: https://github.com/…”.

Used by: both resume layouts inside a print-only section at the end.

---

### 11) vendors/ (SVG icon packs)
Purpose: Namespaced, vendored icons used across the theme.
- `vendors/lineicons-v4.0/` — Used for small header contact icons (e.g., phone, envelope, postcard)
- `vendors/lineicons-v5.0/` — Used for social icons

To add a new icon:
1. Drop a proper, minimal SVG (no script, no external refs) into the correct subfolder.
2. Reference it from an include with `{% include vendors/lineicons-v5.0/<name>.svg %}`.

---

## Dynamic section rendering (resume-section-*.html)

Two includes power all resume content:
- `resume-section-en.html` — English labels and EN date formats
- `resume-section-ar.html` — Arabic labels, RTL-aware, and Arabic date/“Present” logic

### How it works

Both files receive a parameter `section_name` and render the matching section if it’s enabled in `_config.yml`.

```liquid
{% include resume-section-en.html section_name="experience" %}
```

The resume layouts loop over `site.resume_section_order` and call the include once per item, so you only need to control ordering and flags in config.

### Section list and flags

Supported `section_name` values (and their flags under `resume_section`):
- `experience` → `resume_section.experience`
- `education` → `resume_section.education`
- `certifications` → `resume_section.certifications`
- `courses` → `resume_section.courses`
- `volunteering` → `resume_section.volunteering`
- `projects` → `resume_section.projects`
- `skills` → `resume_section.skills`
- `recognition` → `resume_section.recognition`
- `associations` → `resume_section.associations`
- `interests` → `resume_section.interests`
- `languages` → `resume_section.languages` (plus `resume_section.lang_header` controls header display)
- `links` → `resume_section.links`

Global behavior:
- Items are filtered by `active: true` in your data.
- Experience/Volunteering are grouped by `company` and sorted by `startdate` desc.
- “Present” handling: EN prints “Present”; AR prints “حتى الآن”. Array-based `durations` is also supported.

### Changing section order

In `_config.yml`:
```yaml
resume_section_order:
  - experience
  - education
  - projects
  - skills
  - languages
  - links
```
The layout loops this array and includes the matching block.

### Adding a new section (step-by-step)

Example: Add “publications”.

1) Data: create `_data/publications.yml` (or inside your active subtree) like:
```yaml
- active: true
  title: Building Scalable Systems
  venue: Journal of Systems
  year: 2024
  url: https://example.com/paper
  summary: A brief sentence about the publication.
```

2) Enable and order it in `_config.yml`:
```yaml
resume_section:
  publications: true
resume_section_order:
  - experience
  - education
  - publications
  - skills
```

3) Render logic in EN include (`_includes/resume-section-en.html`): add a new branch, for example right before the closing `{% endif %}`:
```liquid
{% elsif include.section_name == "publications" and site.resume_section.publications %}
<section class="content-section">
  <header class="section-header">
    <h2>Publications</h2>
  </header>
  {% for pub in resume_data.publications %}
    {% if pub.active %}
      <div class="resume-item">
        <h3 class="resume-item-title" itemprop="headline">
          {% if pub.url %}<a href="{{ pub.url }}" target="_blank" rel="noopener nofollow noreferrer">{{ pub.title }}</a>{% else %}{{ pub.title }}{% endif %}
        </h3>
        <h4 class="resume-item-details">{{ pub.venue }} &bull; {{ pub.year }}</h4>
        {% if pub.summary %}<p class="resume-item-copy">{{ pub.summary }}</p>{% endif %}
      </div>
    {% endif %}
  {% endfor %}
</section>
```

4) Arabic include (`_includes/resume-section-ar.html`): add the mirrored branch with localized labels.

That’s it—no layout changes needed. Your new section will render where you placed it in `resume_section_order`.

---

## Multilingual SEO with hreflang

Set `lang` and a shared `t_id` in both language pages (e.g., EN and AR resume pages):
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
The `hreflang.html` include emits alternate links for all pages sharing the same `t_id`, and an `x-default` pointing to the English page if present.

---

## Analytics configuration

Pick one of the two:

- Google Tag Manager (recommended if you already use GTM)
```yaml
analytics:
  gtm: GTM-XXXXXXX
```
- Google Analytics 4 (gtag.js)
```yaml
analytics:
  ga: true
  gtag: G-XXXXXXXXXX
```
`analytics-head.html` injects the head snippet; `analytics-body.html` adds the GTM `<noscript>` fallback in the body.

---

## Social links and icons

Configure in `_config.yml`:
```yaml
social_links:
  github: https://github.com/your-username
  linkedin: https://www.linkedin.com/in/your-handle/
  telegram: https://t.me/your-handle
  twitter: https://twitter.com/your-handle
  medium: https://medium.com/@your-handle
  instagram: https://instagram.com/your-handle
  website: https://yourdomain.tld
  whatsapp: https://wa.me/123456789
  devto: https://dev.to/your-handle
  flickr: https://flickr.com/people/your-handle
  pinterest: https://pinterest.com/your-handle
  youtube: https://youtube.com/@your-handle
```
Only keys you set are rendered. Icons are included from `vendors/lineicons-v5.0/`.

To add a network not yet supported (e.g., Mastodon):
1. Add an SVG to `vendors/lineicons-v5.0/mastodon.svg`.
2. Add a block to `social-links.html`:
```liquid
{% if site.social_links.mastodon %}
<li class="icon-link-item">
  <a href="{{ site.social_links.mastodon }}" class="icon-link" itemprop="sameAs" target="_blank" rel="noopener nofollow noreferrer">
    {% include vendors/lineicons-v5.0/mastodon.svg %}
  </a>
</li>
{% endif %}
```
3. Optionally add a print-only line in `print-social-links.html`.

---

## Customization recipes

### Swap fonts or CSS per language
- Edit `resume-head-en.html` to change the EN font stack or CSS file.
- Edit `resume-head-ar.html` to change the AR font (Cairo by default) or CSS file.
- Keep RTL-specific styles in `cv-ar.css` (it imports RTL overrides through SCSS).

### Add a new social network
- See steps above under “Social links and icons”.

### Show languages in header vs its own section
- Header display uses `resume_section.lang_header` and reads active languages from `resume_data.languages`.
- If you set `resume_section.lang_header: true`, the header prints a compact “Languages: EN (Fluent), …”.
- If you also want a full “Languages” section, ensure `resume_section.languages: true`. If you only want it in the header, set the section flag to false or omit it from `resume_section_order`.

### Customize date formats (EN/AR)
- EN formatting uses Liquid date filters inside `resume-section-en.html` (e.g., `'%b %Y'`, `'%b %d, %Y'`). Adjust those if needed.
- AR dates use `ar-date.html` which converts month names via `site.data.ar.months`. Ensure your Arabic months are defined (see “ar-date.html”).

---

## Best practices

- Prefer adding new functionality in `_includes/` rather than inlining complex markup in layouts.
- Keep includes small and focused (one job per include).
- Avoid hard-coding URLs; use `relative_url` and `absolute_url` filters.
- Respect configuration-driven behavior:
  - Feature flags under `resume_section.*`
  - Section order via `resume_section_order`
  - Data path via `active_resume_path`
- Localize: if you add a section in EN, consider adding the AR counterpart with translated labels and RTL visual checks.
- SVG hygiene: strip unnecessary attributes/metadata; keep icons lightweight.
- Printing: if something is important for PDF/print, add a print-only variant similar to `print-social-links.html`.

---
