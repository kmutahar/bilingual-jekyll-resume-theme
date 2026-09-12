# `_includes` Component Guide

A comprehensive architectural guide to the theme’s reusable component library in [`../_includes/`](../_includes/). This guide details component responsibilities, parameters, Liquid data flow, and step-by-step instructions for extending or overriding components.

---

## Table of Contents

- [Overview & Architecture](#overview--architecture)
- [Component Inventory](#component-inventory)
  - [1. `shared-head.html`](#1-shared-headhtml)
  - [2. `main-head.html`](#2-main-headhtml)
  - [3. `resume-head-en.html`](#3-resume-head-enhtml)
  - [4. `resume-head-ar.html`](#4-resume-head-arhtml)
  - [5. `avatar.html`](#5-avatarhtml)
  - [6. `dark-mode-toggle.html`](#6-dark-mode-togglehtml)
  - [7. `ar-date.html`](#7-ar-datehtml)
  - [8. `social-links.html`](#8-social-linkshtml)
  - [9. `print-social-links.html`](#9-print-social-linkshtml)
  - [10. `hreflang.html`](#10-hreflanghtml)
  - [11. `analytics-head.html` & `analytics-body.html`](#11-analytics-headhtml--analytics-bodyhtml)
  - [12. `vendors/` (SVG Icon Packs)](#12-vendors-svg-icon-packs)
- [Multilingual SEO with hreflang](#multilingual-seo-with-hreflang)
- [Dynamic Section Rendering Engine](#dynamic-section-rendering-engine)
  - [How Section Dispatch Works](#how-section-dispatch-works)
  - [Section Dispatch Inventory](#section-dispatch-inventory)
  - [Adding a New Custom Section](#adding-a-new-custom-section)
- [Customization Recipes](#customization-recipes)
  - [Swap Remote Arabic Fonts](#swap-remote-arabic-fonts)
  - [Add a New Social Network](#add-a-new-social-network)
  - [Compact Language Header vs Dedicated Section](#compact-language-header-vs-dedicated-section)

---

## Overview & Architecture

Jekyll includes are modular partial templates located in [`../_includes/`](../_includes/). In this theme, includes are utilized to:
1. Guarantee **strict bilingual parity** between English (LTR) and Arabic (RTL) views.
2. Abstract repetitive markup (headers, favicons, analytics, SVGs).
3. Implement dynamic, data-driven section dispatching based on user configuration in [`_data/_config.sample.yml`](_data/_config.sample.yml).

### Include Resolution in Layouts

```text
Layout (e.g., _layouts/resume-en.html)
 ├── shared-head.html        (anti-FOUC script, metadata, favicon suite)
 ├── resume-head-en.html     (Google Fonts, cv.css, hreflang)
 ├── analytics-head.html     (GTM / GA4 tracking script)
 ├── analytics-body.html     (GTM noscript fallback iframe)
 ├── avatar.html             (accessible, configurable profile image)
 ├── social-links.html       (interactive SVG social icons)
 ├── resume-section-en.html  (dynamic section dispatcher loop)
 ├── dark-mode-toggle.html   (interactive two-state theme toggle)
 └── print-social-links.html (print-only plaintext contact listing)
```

---

## Component Inventory

### 1. `shared-head.html`

- **Location:** [`../_includes/shared-head.html`](../_includes/shared-head.html)
- **Consumed by:** [`../_layouts/default.html`](../_layouts/default.html), [`../_layouts/resume-en.html`](../_layouts/resume-en.html), [`../_layouts/resume-ar.html`](../_layouts/resume-ar.html)
- **Key Responsibilities:**
  - Viewport, charset, and modern `color-scheme` metadata.
  - **Inline Anti-FOUC Script:** Synchronously reads `localStorage.getItem('color-scheme')` before CSS renders to prevent theme flashing on reload.
  - **Favicon Suite:** Emits high-resolution favicon links (`favicon`, `apple_touch_icon`, `favicon_32`, `favicon_16`) and webmanifest with `relative_url` filtering.
  - **Robots Meta:** Automatically applies `noindex noarchive nosnippet noimageindex` when `page.noindex: true`.

---

### 2. `main-head.html`

- **Location:** [`../_includes/main-head.html`](../_includes/main-head.html)
- **Consumed by:** [`../_layouts/default.html`](../_layouts/default.html)
- **Key Responsibilities:** Loads `assets/css/main.css` for landing pages, documentation, and error pages.

---

### 3. `resume-head-en.html`

- **Location:** [`../_includes/resume-head-en.html`](../_includes/resume-head-en.html)
- **Consumed by:** [`../_layouts/resume-en.html`](../_layouts/resume-en.html)
- **Key Responsibilities:**
  - Enqueues Google Fonts (Lora and Open Sans).
  - Enqueues English resume stylesheet (`assets/css/cv.css`).
  - Calls `{% include hreflang.html %}` for SEO alternate links.

---

### 4. `resume-head-ar.html`

- **Location:** [`../_includes/resume-head-ar.html`](../_includes/resume-head-ar.html)
- **Consumed by:** [`../_layouts/resume-ar.html`](../_layouts/resume-ar.html)
- **Key Responsibilities:**
  - Supports self-hosted or alternate CDN fonts via `site.font_ar_url`.
  - Enqueues Cairo Arabic font by default unless `site.disable_google_fonts: true` or `site.resume_theme == 'no-custom-fonts'`.
  - Enqueues RTL Arabic stylesheet (`assets/css/cv-ar.css`).
  - Calls `{% include hreflang.html %}`.

---

### 5. `avatar.html`

- **Location:** [`../_includes/avatar.html`](../_includes/avatar.html)
- **Consumed by:** [`../_layouts/resume-en.html`](../_layouts/resume-en.html), [`../_layouts/resume-ar.html`](../_layouts/resume-ar.html)
- **Parameters:**
  - `lang`: Optional language code (`'en'` | `'ar'`). Defaults to `page.lang` or `'en'`.
  - `link`: Optional boolean (`false` disables enclosing `<a>` wrapper).
  - `class`: Optional additional CSS class names.
- **Key Features:**
  - **Image Resolution:** Reads `site.avatar_url` (or fallback `site.avatar`), defaulting to `/assets/images/Profile-min.jpg`. Correctly handles both local relative assets and external CDN URLs (`https://...`).
  - **Bilingual Alt Text:** Dynamically evaluates `site.avatar_alt_en` (English) or `site.avatar_alt_ar` (Arabic), falling back to full candidate name or default string.
  - **Accessible Link Wrapping:** Wraps image in `<a href="{{ avatar_href }}">` unless `site.avatar_link: false` or `include.link == false`.

```liquid
{% comment %} Standard usage in layouts {% endcomment %}
{% include avatar.html lang="en" %}
{% include avatar.html lang="ar" %}

{% comment %} Standalone unlinked image {% endcomment %}
{% include avatar.html link=false class="avatar-large" %}
```

---

### 6. `dark-mode-toggle.html`

- **Location:** [`../_includes/dark-mode-toggle.html`](../_includes/dark-mode-toggle.html)
- **Consumed by:** [`../_layouts/default.html`](../_layouts/default.html), [`../_layouts/resume-en.html`](../_layouts/resume-en.html), [`../_layouts/resume-ar.html`](../_layouts/resume-ar.html)
- **Inclusion Logic:** Rendered conditionally across layouts using:

```liquid
{% assign dark_mode_enabled = false %}
{% if site.dark_mode == "enabled" or site.dark_mode == true or site.resume_dark_mode == "enabled" or site.resume_dark_mode == true %}
    {% assign dark_mode_enabled = true %}
{% endif %}
{% if page.dark_mode == false %}
    {% assign dark_mode_enabled = false %}
{% elsif page.dark_mode == true or page.dark_mode == "enabled" %}
    {% assign dark_mode_enabled = true %}
{% endif %}
{% if dark_mode_enabled %}
    {% include dark-mode-toggle.html %}
{% endif %}
```

- **Two-State Finite State Machine (FSM):**
  - **System Default (Unpinned):** No `localStorage` entry; theme follows OS `prefers-color-scheme`. Dynamic `matchMedia` listener updates button visuals in real-time.
  - **Pinned Override:** Saves `"dark"` or `"light"` to `localStorage['color-scheme']` and updates `data-theme` on `<html>`. Clicking again clears the pin and reverts to System Default.
- **Accessibility:** High-contrast focus rings, keyboard activation (<kbd>Enter</kbd> / <kbd>Space</kbd>), and localized `aria-label` and `title` attributes in English and Arabic.
- **Print Optimization:** Automatically suppressed in print output via `.no-print`.

---

### 7. `ar-date.html`

- **Location:** [`../_includes/ar-date.html`](../_includes/ar-date.html)
- **Consumed by:** [`../_includes/resume-section-ar.html`](../_includes/resume-section-ar.html)
- **Parameters:**
  - `date`: An ISO date string (`YYYY-MM-DD`).
  - `style`: `"MY"` (Month Year) or `"MDY"` (Month Day, Year).
- **Behavior:** Extracts month number (1–12) and performs dictionary lookup in `site.data.ar.months` (bundled in [`../_data/ar/months.yml`](../_data/ar/months.yml)).

```liquid
{% include ar-date.html date=job.startdate style="MY" %}
```

---

### 8. `social-links.html`

- **Location:** [`../_includes/social-links.html`](../_includes/social-links.html)
- **Consumed by:** [`../_layouts/resume-en.html`](../_layouts/resume-en.html), [`../_layouts/resume-ar.html`](../_layouts/resume-ar.html)
- **Supported Platforms:** 14 bundled platforms:
  `github`, `linkedin`, `telegram`, `twitter`, `medium`, `dribbble`, `facebook`, `instagram`, `website`, `whatsapp`, `devto`, `flickr`, `pinterest`, `youtube`.
- **Security & WCAG:** Emits `rel="noopener nofollow noreferrer"`, `target="_blank"`, dynamic `title`, `aria-label`, and `.sr-only` screen-reader spans.

---

### 9. `print-social-links.html`

- **Location:** [`../_includes/print-social-links.html`](../_includes/print-social-links.html)
- **Consumed by:** Both resume layouts when `resume_print_social_links: true`.
- **Behavior:** Generates a plaintext list of active social URLs wrapped in `<span dir="ltr">` to guarantee bidirectional punctuation integrity during physical and PDF printing.

---

### 10. `hreflang.html`

- **Location:** [`../_includes/hreflang.html`](../_includes/hreflang.html)
- **Consumed by:** `resume-head-en.html` and `resume-head-ar.html`.
- **Behavior:** Queries `site.pages` matching the current page’s translation group (`page.t_id`), emitting `<link rel="alternate" hreflang="...">` tags and an `x-default` pointer to the English version. See [Multilingual SEO with hreflang](#multilingual-seo-with-hreflang) below for setup instructions.

---

### 11. `analytics-head.html` & `analytics-body.html`

- **Head Include:** Injects Google Tag Manager container or Google Analytics 4 (`gtag.js`) based on `site.analytics.gtm` or `site.analytics.gtag` in `_config.yml`.
- **Body Include:** Injects `<noscript><iframe>` fallback for Google Tag Manager immediately after the opening `<body>` tag in [`../_layouts/default.html`](../_layouts/default.html).

---

### 12. `vendors/` (SVG Icon Packs)

Bundled scalable vector graphics:
- `vendors/lineicons-v4.0/`: Contact row icons (envelope, phone, location pin).
- `vendors/lineicons-v5.0/`: Social platform brand icons.

---

## Multilingual SEO with hreflang

To ensure search engines index both English and Arabic versions properly and serve the right version to users based on their locale, the theme integrates automated `hreflang` generation via [`../_includes/hreflang.html`](../_includes/hreflang.html).

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

### How It Operates

1. Searches `site.pages` for all pages that have the identical `t_id` value (e.g., `"resume"`).
2. Generates an alternate link for each translation found:
   ```html
   <link rel="alternate" hreflang="en" href="https://your-domain.com/resume/en/" />
   <link rel="alternate" hreflang="ar" href="https://your-domain.com/resume/ar/" />
   ```
3. Identifies the English page (`lang: en`) within the translation group and outputs the `x-default` fallback tag:
   ```html
   <link rel="alternate" hreflang="x-default" href="https://your-domain.com/resume/en/" />
   ```

---

## Dynamic Section Rendering Engine

### How Section Dispatch Works

In both [`../_layouts/resume-en.html`](../_layouts/resume-en.html) and [`../_layouts/resume-ar.html`](../_layouts/resume-ar.html), sections are rendered dynamically by looping through the array defined in `site.resume_section_order`:

```liquid
{% for section in site.resume_section_order %}
  {% include resume-section-en.html section_name=section %}
{% endfor %}
```

Inside [`../_includes/resume-section-en.html`](../_includes/resume-section-en.html) and [`../_includes/resume-section-ar.html`](../_includes/resume-section-ar.html), an `{% if / elsif %}` dispatcher evaluates the requested section:

```liquid
{% if include.section_name == 'experience' and site.resume_section.experience != false and resume_data.experience %}
  <!-- Renders Experience Section -->
{% elsif include.section_name == 'education' and site.resume_section.education != false and resume_data.education %}
  <!-- Renders Education Section -->
...
```

### Section Dispatch Inventory

| Section Name (`section_name`) | Config Toggle (`resume_section`) | Data File | Data Expression |
|---|---|---|---|
| `experience` | `experience` | `experience.yml` | `resume_data.experience` |
| `education` | `education` | `education.yml` | `resume_data.education` |
| `certifications` | `certifications` | `certifications.yml` | `resume_data.certifications` |
| `courses` | `courses` | `courses.yml` | `resume_data.courses` |
| `volunteering` | `volunteering` | `volunteering.yml` | `resume_data.volunteering` |
| `projects` | `projects` | `projects.yml` | `resume_data.projects` |
| `skills` | `skills` | `skills.yml` | `resume_data.skills` |
| **`recognition`** | **`recognition`** | **`recognitions.yml`** | `resume_data.recognitions` |
| `associations` | `associations` | `associations.yml` | `resume_data.associations` |
| `languages` | `languages` | `languages.yml` | `resume_data.languages` |
| `links` | `links` | `links.yml` | `resume_data.links` |
| `interests` | `interests` | `interests.yml` | `resume_data.interests` |

---

### Adding a New Custom Section

To add a new resume section (e.g., `publications`):

1. **Update English Dispatcher:** Add an `{% elsif %}` branch in [`../_includes/resume-section-en.html`](../_includes/resume-section-en.html):
   ```liquid
   {% elsif include.section_name == 'publications' and site.resume_section.publications != false and resume_data.publications %}
     <section class="resume-section section-publications">
       <h2 class="section-header">Publications</h2>
       {% for item in resume_data.publications %}
         {% if item.active != false %}
           <div class="resume-item">
             <h3 class="resume-item-title">{{ item.title }}</h3>
             <p class="resume-item-details">{{ item.publisher }} • {{ item.year }}</p>
           </div>
         {% endif %}
       {% endfor %}
     </section>
   ```
2. **Update Arabic Dispatcher:** Add the mirrored RTL branch in [`../_includes/resume-section-ar.html`](../_includes/resume-section-ar.html) with localized headings.
3. **Add Data:** Create `_data/en/publications.yml` and `_data/ar/publications.yml`.
4. **Update Configuration:** Add `publications: true` to `resume_section` and add `- publications` to `resume_section_order` in `_config.yml`.

---

## Customization Recipes

### Swap Remote Arabic Fonts

In your site’s `_config.yml`, specify a custom Google Fonts or self-hosted stylesheet:

```yaml
font_ar_url: "https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700&display=swap"
```

### Add a New Social Network

1. Place an optimized SVG in `_includes/vendors/lineicons-v5.0/newplatform.svg`.
2. Add the Liquid block to [`../_includes/social-links.html`](../_includes/social-links.html):
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
3. Add the plaintext print entry in [`../_includes/print-social-links.html`](../_includes/print-social-links.html).

### Compact Language Header vs Dedicated Section

- For compact language chips under candidate titles in the header:
  ```yaml
  resume_section:
    lang_header: true
    languages: false
  ```
- For a full two-column languages table section:
  ```yaml
  resume_section:
    lang_header: false
    languages: true
  ```
