# `_includes` Component Guide

The theme's reusable partials in [`../_includes/`](../_includes/): what each one renders, its parameters, and how to add a resume section or social network.

Every include that shows text resolves the active language the same way the layouts do (`page.lang`, then `site.default_lang`, then `en`) and reads its strings from `site.data.locales[lang]`. No include branches on a specific language code, so every include works for every configured language. See [`LAYOUTS_GUIDE.md`](LAYOUTS_GUIDE.md#language-resolution).

---

## Table of Contents

- [Include Map](#include-map)
- [Component Inventory](#component-inventory)
  - [1. `shared-head.html`](#1-shared-headhtml)
  - [2. `main-head.html` & `profile-head.html`](#2-main-headhtml--profile-headhtml)
  - [3. `avatar.html`](#3-avatarhtml)
  - [4. `dark-mode-toggle.html`](#4-dark-mode-togglehtml)
  - [5. `language-switcher.html`](#5-language-switcherhtml)
  - [6. `date-formatter.html`](#6-date-formatterhtml)
  - [7. `social-links.html`](#7-social-linkshtml)
  - [8. `print-social-links.html`](#8-print-social-linkshtml)
  - [9. `hreflang.html`](#9-hreflanghtml)
  - [10. `data-loader.html`](#10-data-loaderhtml)
  - [11. `analytics-head.html` & `analytics-body.html`](#11-analytics-headhtml--analytics-bodyhtml)
  - [12. `vendors/` (SVG Icon Packs)](#12-vendors-svg-icon-packs)
- [Multilingual SEO with hreflang](#multilingual-seo-with-hreflang)
- [Section Dispatcher (`resume-section.html`)](#section-dispatcher-resume-sectionhtml)
  - [Section Dispatch Inventory](#section-dispatch-inventory)
  - [Adding a New Custom Section](#adding-a-new-custom-section)
- [Customization Recipes](#customization-recipes)

---

## Include Map

```text
_layouts/resume.html
 ├── data-loader.html        (binds resume_data from languages.<lang>.data_path)
 ├── shared-head.html        (anti-FOUC script, metadata, favicon suite)
 ├── hreflang.html           (alternate-language links)
 ├── analytics-head.html     (GTM / GA4 head script)
 ├── analytics-body.html     (GTM noscript iframe)
 ├── dark-mode-toggle.html   (floating theme toggle)
 ├── language-switcher.html  (floating links to the other languages)
 ├── avatar.html             (profile image)
 ├── date-formatter.html     (date of birth)
 ├── social-links.html       (header social icons)
 ├── resume-section.html     (one call per entry in resume_section_order)
 │    └── date-formatter.html
 └── print-social-links.html (print-only text list)
```

`default.html` and `profile.html` use `shared-head.html`, their own stylesheet include (`main-head.html` / `profile-head.html`), the analytics includes, `dark-mode-toggle.html`, and `language-switcher.html`.

---

## Component Inventory

### 1. `shared-head.html`

- **Consumed by:** every layout.
- Charset, viewport, and `color-scheme` meta.
- **Anti-FOUC script:** reads `localStorage['color-scheme']` synchronously and sets `data-color-scheme` / `data-theme` on `<html>` before CSS loads.
- **Favicons:** `favicon`, `apple_touch_icon`, `favicon_32`, `favicon_16`, and the web manifest, all through `relative_url`.
- **Robots:** `noindex noarchive nosnippet noimageindex` when `page.noindex: true`.

### 2. `main-head.html` & `profile-head.html`

- `main-head.html` (in `default.html`, therefore also error pages) links `assets/css/main.css`.
- `profile-head.html` (in `profile.html`) links `assets/css/profile.css`.

### 3. `avatar.html`

- **Consumed by:** `resume.html` when `site.resume_avatar == true`.
- **Parameters:** `lang` (default: active language), `link` (`false` renders a bare `<img>`), `class` (extra CSS classes).
- **Source:** `site.avatar_url`, default `/assets/images/Profile-min.jpg`. Values containing `://` are used as-is; others pass through `relative_url`.
- **Alt text:** `languages.<lang>.avatar_alt`, then `languages.<lang>.name`, then `locale.ui.photo_alt`.
- **Link:** wraps the image in a link to `site.avatar_link` (default `/`) with `site.avatar_link_target` (default `_self`), unless `site.avatar_link: false` or `link=false`.

```liquid
{% include avatar.html lang=lang %}
{% include avatar.html link=false class="avatar-large" %}
```

### 4. `dark-mode-toggle.html`

- **Consumed by:** `resume.html`, `default.html`, `profile.html`.
- Renders only when `site.dark_mode` is `"enabled"` or `true`, or front matter `dark_mode` is `true` / `"enabled"`; front matter `dark_mode: false` suppresses it.
- Two states: unpinned (follows `prefers-color-scheme`, live via `matchMedia`) and pinned (`"dark"` / `"light"` saved to `localStorage['color-scheme']`). Clicking a pinned toggle clears the pin.
- `aria-label` and `title` from `locale.ui.dark_mode_toggle`. Hidden in print via `.no-print`.

### 5. `language-switcher.html`

- **Consumed by:** `resume.html`, `default.html`, `profile.html`. Hidden on `layout: error` pages, when `site.resume_language_switcher: false`, or when front matter sets `language_switcher: false`.
- Renders one link for every entry in `site.languages` except the current one, labelled with the target locale's `ui.language_name`. The group's `aria-label` is the current locale's `ui.language_switcher`.
- **Link resolution per target language:** the page in `site.pages` with the same `t_id` and the target `lang`; otherwise `languages.<lang>.url`.
- Positioned opposite the dark mode toggle and mirrored in RTL. Hidden in print.
- Loop variables are prefixed `switch_` because includes share the caller's Liquid scope; unprefixed names would overwrite `resume.html`'s `lang` and `locale`.

### 6. `date-formatter.html`

- **Consumed by:** `resume-section.html` (every date) and `resume.html` (date of birth).
- **Parameters:** `date` (required), `style` (`"MY"` default: `<month> <year>`; `"MDY"`: `<month> <day>, <year>`), `lang` (default: active language).
- A `date` matching any of the locale's `present_values` (case-insensitive) renders `locale.ui.present`. Otherwise the month name comes from `locale.months`. An unparseable value is printed unchanged.

```liquid
{% include date-formatter.html date=role.startdate %}
{% include date-formatter.html date=site.contact_info.dob style="MDY" lang=lang %}
```

This include is the single date hook for every language; calendar extensions (for example Hijri dates, roadmap Feature 2.9) belong here rather than in a language-specific include.

### 7. `social-links.html`

- **Consumed by:** `resume.html` header, inside `<ul class="social-links">`, when `site.social_links` is set.
- `email` renders a `mailto:` link with `itemprop="email"`. The other 14 platforms (`github`, `linkedin`, `telegram`, `twitter`, `medium`, `dribbble`, `facebook`, `instagram`, `website`, `whatsapp`, `devto`, `flickr`, `pinterest`, `youtube`) open in a new tab with `rel="noopener nofollow noreferrer"`.
- Every icon link carries `aria-label`, `title`, and a `.sr-only` text span.

### 8. `print-social-links.html`

- **Consumed by:** `resume.html` print-only section when `site.resume_print_social_links` is set.
- One line per configured platform (including `email`), labelled from `locale.ui.social_labels`, with the value wrapped in `<span dir="ltr">`.

### 9. `hreflang.html`

- **Consumed by:** `resume.html` head.
- Runs only when the page has a `t_id`. Emits `<link rel="alternate" hreflang="<lang>">` for every page sharing that `t_id`, and `hreflang="x-default"` for the one whose `lang` is `site.default_lang`. URLs are absolute (`absolute_url`), so `site.url` must be set.

### 10. `data-loader.html`

- **Consumed by:** `resume.html`.
- **Parameter:** `path`, a dot-separated data path. Default: `site.languages[page.lang or default_lang].data_path`.
- Sets `resume_data` in the caller's scope by walking `site.data` with bracket access. Details in [`LAYOUTS_GUIDE.md`](LAYOUTS_GUIDE.md#dynamic-data-resolution).

### 11. `analytics-head.html` & `analytics-body.html`

- **Head:** Google Tag Manager (`site.analytics.gtm`) or Google Analytics 4 (`site.analytics.gtag`). Universal Analytics (`analytics.ga`) was removed in v1.0.0.
- **Body:** the GTM `<noscript><iframe>` right after `<body>` in every layout.

### 12. `vendors/` (SVG Icon Packs)

- `vendors/lineicons-v4.0/`: contact row icons (envelope, phone, postcard).
- `vendors/lineicons-v5.0/`: social platform icons.

---

## Multilingual SEO with hreflang

Give every translation of a page the same `t_id`:

```yaml
---
layout: resume
lang: en
permalink: /en/cv/
t_id: resume
---
```

```yaml
---
layout: resume
lang: ar
permalink: /ar/cv/
t_id: resume
---
```

With `default_lang: en`, each page then emits:

```html
<link rel="alternate" hreflang="en" href="https://your-domain.com/en/cv/" />
<link rel="alternate" hreflang="ar" href="https://your-domain.com/ar/cv/" />
<link rel="alternate" hreflang="x-default" href="https://your-domain.com/en/cv/" />
```

The same `t_id` also lets the language switcher find the exact counterpart page instead of falling back to `languages.<lang>.url`.

---

## Section Dispatcher (`resume-section.html`)

`resume.html` renders sections by looping over `site.resume_section_order`:

```liquid
{%- for section_name in site.resume_section_order -%}
  {% include resume-section.html section_name=section_name lang=lang %}
{%- endfor -%}
```

[`../_includes/resume-section.html`](../_includes/resume-section.html) is one `{% if %} / {% elsif %}` chain. A branch renders when `include.section_name` matches and `site.resume_section.<name>` is truthy:

```liquid
{% if include.section_name == "experience" and site.resume_section.experience %}
  <!-- Experience -->
{% elsif include.section_name == "education" and site.resume_section.education %}
  <!-- Education -->
...
```

Inside every branch:

- The heading is `locale.ui.section_titles.<name>`.
- Dates go through `date-formatter.html`; a blank `enddate` renders as the locale's "Present".
- When `locale.direction == 'rtl'`, URLs and credential IDs are wrapped in `dir="ltr"`.
- Only items with `active: true` render; an item without the flag is hidden (`interests.yml` has no flag).

### Section Dispatch Inventory

| `section_name` | Config toggle (`resume_section`) | Data file | Data expression |
|---|---|---|---|
| `experience` | `experience` | `experience.yml` | `resume_data.experience` |
| `education` | `education` | `education.yml` | `resume_data.education` |
| `certifications` | `certifications` | `certifications.yml` | `resume_data.certifications` |
| `courses` | `courses` | `courses.yml` | `resume_data.courses` |
| `volunteering` | `volunteering` | `volunteering.yml` | `resume_data.volunteering` |
| `projects` | `projects` | `projects.yml` | `resume_data.projects` |
| `skills` | `skills` | `skills.yml` | `resume_data.skills` |
| `recognitions` | `recognitions` | `recognitions.yml` | `resume_data.recognitions` |
| `associations` | `associations` | `associations.yml` | `resume_data.associations` |
| `interests` | `interests` | `interests.yml` | `resume_data.interests` |
| `languages` | `languages` (and `lang_header` not `true`) | `languages.yml` | `resume_data.languages` |
| `links` | `links` | `links.yml` | `resume_data.links` |

### Adding a New Custom Section

Adding `publications`:

1. **Add the heading to every locale.** Add `ui.section_titles.publications` to each `_data/locales/<lang>.yml` you ship (in a consuming site, add it through site locale overrides; nested keys merge, so a one-key file per language is enough).
2. **Add one branch** to `_includes/resume-section.html`. It serves every language:
   ```liquid
   {% elsif include.section_name == "publications" and site.resume_section.publications %}
     <section class="content-section">
       <header class="section-header">
         <h2>{{ locale.ui.section_titles.publications }}</h2>
       </header>
       {% for item in resume_data.publications %}
         {% if item.active == true %}
           <div class="resume-item">
             <h3 class="resume-item-title">{{ item.title }}</h3>
             <p class="resume-item-details">{{ item.publisher }} &bull; {{ item.year }}</p>
           </div>
         {% endif %}
       {% endfor %}
     </section>
   ```
3. **Add data** as `publications.yml` in every language folder.
4. **Enable it:** `resume_section.publications: true` and `- publications` in `resume_section_order`.

---

## Customization Recipes

### Change a Language's Font

Fonts are locale data, not config. Override them in your site's locale file:

```yaml
# consuming site: _data/locales/ar.yml
font_family: "'Tajawal', sans-serif"
font_url: "https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700&display=swap"
```

### Add a New Social Network

1. Place an optimized SVG in `_includes/vendors/lineicons-v5.0/newplatform.svg`.
2. Add a block to [`../_includes/social-links.html`](../_includes/social-links.html):
   ```liquid
   {% if site.social_links.newplatform %}
     <li class="icon-link-item">
       <a href="{{ site.social_links.newplatform }}" class="icon-link" itemprop="sameAs" target="_blank" rel="noopener nofollow noreferrer" aria-label="New Platform" title="New Platform">
         {% include vendors/lineicons-v5.0/newplatform.svg %}
         <span class="sr-only">New Platform</span>
       </a>
     </li>
   {% endif %}
   ```
3. Add the print line to [`../_includes/print-social-links.html`](../_includes/print-social-links.html) and a `ui.social_labels.newplatform` key to every locale file.

### Compact Language Header vs Dedicated Section

```yaml
resume_section:
  lang_header: true    # compact list in the header (the full section is suppressed)
  languages: false
```

```yaml
resume_section:
  lang_header: false
  languages: true      # full two-column section
```
