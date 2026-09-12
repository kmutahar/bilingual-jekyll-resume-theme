# `_layouts` Architecture Guide

A comprehensive architectural overview of the theme’s layout system in [`../_layouts/`](../_layouts/). This document details layout responsibilities, dynamic data loading, rendering pipelines, bilingual RTL mechanics, error handling, and extending layouts for additional languages.

---

## Table of Contents

- [Overview & Layout Hierarchy](#overview--layout-hierarchy)
- [Layout Inventory](#layout-inventory)
  - [1. `default.html` (Base Layout)](#1-defaulthtml-base-layout)
  - [2. `profile.html` (Portfolio Landing)](#2-profilehtml-portfolio-landing)
  - [3. `resume-en.html` (English Resume - LTR)](#3-resume-enhtml-english-resume---ltr)
  - [4. `resume-ar.html` (Arabic Resume - RTL)](#4-resume-arhtml-arabic-resume---rtl)
  - [5. `error.html` (Bilingual HTTP Error Suite)](#5-errorhtml-bilingual-http-error-suite)
- [Dynamic Data Resolution Engine](#dynamic-data-resolution-engine)
  - [How `resume_data` is Resolved](#how-resume_data-is-resolved)
  - [Dot-Path Traversal & Bracket Notation](#dot-path-traversal--bracket-notation)
  - [Configuration Examples](#configuration-examples)
- [Resume Rendering Pipeline](#resume-rendering-pipeline)
- [Dark Mode & Anti-FOUC Mechanics](#dark-mode--anti-fouc-mechanics)
- [Creating a New Resume-Like Layout (Another Language or Variant)](#creating-a-new-resume-like-layout-another-language-or-variant)
- [Creating Custom General Layouts](#creating-custom-general-layouts)

---

## Overview & Layout Hierarchy

Layouts define the outer HTML skeleton of pages in Jekyll. Pages select their layout through YAML front matter (e.g., `layout: resume-en`).

```text
_layouts/default.html (Base shell, <head>, anti-FOUC, dark mode, footer)
 ├── _layouts/profile.html (Landing page card wrapper)
 └── _layouts/error.html (HTTP 404, 403, 500 error suite)

_layouts/resume-en.html (Standalone LTR English resume pipeline)
_layouts/resume-ar.html (Standalone RTL Arabic resume pipeline)
```

---

## Layout Inventory

### 1. `default.html` (Base Layout)

- **File:** [`../_layouts/default.html`](../_layouts/default.html)
- **Role:** Foundational shell for custom markdown pages, profile landing pages, and HTTP error pages.
- **Key Features:**
  - Dynamic `<html lang="..." dir="...">` attributes supporting bidirectional layouts.
  - Injects [`../_includes/shared-head.html`](../_includes/shared-head.html) (metadata, anti-FOUC script, favicons).
  - Loads general stylesheet via [`../_includes/main-head.html`](../_includes/main-head.html) (`assets/css/main.css`).
  - Emits SEO tags via `{% seo %}` and analytics via [`../_includes/analytics-head.html`](../_includes/analytics-head.html) and [`../_includes/analytics-body.html`](../_includes/analytics-body.html).
  - Evaluates site-wide and front-matter dark mode conditions to conditionally inject [`../_includes/dark-mode-toggle.html`](../_includes/dark-mode-toggle.html).
  - Adds `<link rel="me">` verification when `site.social_links.mastodon` is configured.
  - Wraps page content inside `<main class="main-content" id="main-content">`.
  - Accessible footer with copyright year range.

---

### 2. `profile.html` (Portfolio Landing)

- **File:** [`../_layouts/profile.html`](../_layouts/profile.html)
- **Role:** Lightweight landing page wrapper extending `default.html`.
- **Key Features:**
  - Wraps content in `<div class="profile-container">`.
  - Uses scoped styling from [`../_sass/_profile.scss`](../_sass/_profile.scss) to center profile avatar, bio, and social links without leaking onto standard markdown pages.

---

### 3. `resume-en.html` (English Resume - LTR)

- **File:** [`../_layouts/resume-en.html`](../_layouts/resume-en.html)
- **Role:** Production-ready Left-to-Right English resume.
- **Key Features:**
  - Resolves `resume_data` from `site.active_resume_path_en` (default: `"en"`).
  - Enqueues Lora and Open Sans fonts via [`../_includes/resume-head-en.html`](../_includes/resume-head-en.html) and `assets/css/cv.css`.
  - Renders configurable header: avatar ([`../_includes/avatar.html`](../_includes/avatar.html)), candidate name, job title, contact row, social links bar ([`../_includes/social-links.html`](../_includes/social-links.html)), executive bio intro (`_data/en/header.yml`), and contact CTA button.
  - Dynamically renders sections using [`../_includes/resume-section-en.html`](../_includes/resume-section-en.html) in the order defined by `site.resume_section_order`.
  - Injects print-only plaintext social contact listing ([`../_includes/print-social-links.html`](../_includes/print-social-links.html)) when `resume_print_social_links: true`.
  - Emits localized footer timestamp and version notice.

---

### 4. `resume-ar.html` (Arabic Resume - RTL)

- **File:** [`../_layouts/resume-ar.html`](../_layouts/resume-ar.html)
- **Role:** Right-to-Left Arabic resume engineered for strict parity with the English layout.
- **Key Features:**
  - `<html lang="ar" dir="rtl">`.
  - Resolves `resume_data` from `site.active_resume_path_ar` (default: `"ar"`).
  - Enqueues Cairo Arabic font (or custom CDN via `site.font_ar_url`) via [`../_includes/resume-head-ar.html`](../_includes/resume-head-ar.html) and `assets/css/cv-ar.css`.
  - Localized Arabic header text, contact labels, and CTA button.
  - Dynamically renders sections using [`../_includes/resume-section-ar.html`](../_includes/resume-section-ar.html) with localized date translations via [`../_includes/ar-date.html`](../_includes/ar-date.html).
  - RTL-mirrored print social links with `<span dir="ltr">` wrapping for URLs and phone numbers to prevent bidirectional distortion.

---

### 5. `error.html` (Bilingual HTTP Error Suite)

- **File:** [`../_layouts/error.html`](../_layouts/error.html)
- **Role:** Specialized error layout extending `default.html` used by `404.html`, `403.html`, and `500.html`.
- **Key Features:**
  - Reads `page.code` (`404`, `403`, `500`, `503`) and loads bilingual copy from [`../_data/error_pages.yml`](../_data/error_pages.yml).
  - High-contrast status badge.
  - English description block (`lang="en"`) alongside an isolated Arabic RTL description block (`lang="ar" dir="rtl"`).
  - Standard return paths: Home (`/`), Resume EN (`/resume/en/`), and Resume AR (`/resume/ar/`).
  - Interactive "Reload Page / إعادة تحميل الصفحة" button (`window.location.reload()`) automatically rendered for server errors (`500`, `503`).
  - Fully supports universal dark mode and custom front-matter overrides (`title_en`, `desc_en`, `title_ar`, `desc_ar`).

---

## Dynamic Data Resolution Engine

### How `resume_data` is Resolved

Both resume layouts decouple templates from data filenames. Rather than hardcoding references to `site.data.en` or `site.data.ar`, layouts resolve a dynamic pointer called `resume_data`:

```liquid
{% assign resume_data = site.data %}
{% assign data_path = site.active_resume_path_en %}

{% if data_path and data_path != "" %}
  {% assign path_parts = data_path | split: "." %}
  {% assign current_data = site.data %}
  {% for part in path_parts %}
    {% if current_data[part] %}
      {% assign current_data = current_data[part] %}
    {% endif %}
  {% endfor %}
  {% assign resume_data = current_data %}
{% endif %}
```

### Dot-Path Traversal & Bracket Notation

#### Implementation Highlights Inside the Layouts
- **String Splitting:** Splits the configured path string by `.` into array segments:
  ```liquid
  {% assign path_parts = data_path | split: "." %}
  ```
- **Recursive Traversal:** Initializes traversal at `site.data` and iterates through each path part, reassigning the pointer:
  ```liquid
  {% assign current_data = site.data %}
  {% for part in path_parts %}
    {% if current_data[part] %}
      {% assign current_data = current_data[part] %}
    {% endif %}
  {% endfor %}
  ```
- **Bracket Notation Rationale:** In Liquid, standard dot-notation (e.g. `site.data.2025-06.v1`) causes syntax errors or is parsed as a mathematical subtraction when keys begin with numbers or contain hyphens. Using dynamic bracket notation (`current_data[part]`) ensures that arbitrary folder names like `2025-06` or `20250621-PM` are safely evaluated without errors.
- **Pointer Assignment:** After completing the traversal loop, the resulting dataset object is bound:
  ```liquid
  {% assign resume_data = current_data %}
  ```

### Configuration Examples

```yaml
# Standard language folders (recommended):
active_resume_path_en: "en" # -> site.data.en
active_resume_path_ar: "ar" # -> site.data.ar

# Versioned datasets:
active_resume_path_en: "2025-06.v1" # -> site.data["2025-06"]["v1"]
active_resume_path_ar: "2025-06.v1-ar" # -> site.data["2025-06"]["v1-ar"]

# Root _data directory (advanced):
active_resume_path_en: "" # -> site.data
active_resume_path_ar: "" # -> site.data
```

---

## Resume Rendering Pipeline

```text
1. Load & Resolve Data (active_resume_path_en / active_resume_path_ar -> resume_data)
2. Render <head> (shared-head.html, resume-head-*.html, SEO, analytics)
3. Render Header
   - Avatar Include (avatar.html)
   - Candidate Name (site.name / site.name_ar)
   - Professional Title (site.resume_title / site.resume_title_ar)
   - Contact Row (if display_header_contact_info: true)
   - Compact Languages (if resume_section.lang_header: true)
   - Social Icons (social-links.html)
   - Executive Summary (if resume_header_intro_en / ar: true)
   - Contact CTA Button (if resume_looking_for_work is set)
4. Dynamic Sections Loop
   - For each section in site.resume_section_order:
       {% include resume-section-en.html section_name=section %}
5. Print Social Links (print-social-links.html)
6. Footer & Timestamp
```

---

## Dark Mode & Anti-FOUC Mechanics

Layouts manage dark mode through a three-tier condition:

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

1. **Site Level:** Defaults to CSS-only system matching (`dark_mode: auto`). Setting `dark_mode: enabled` activates the interactive toggle.
2. **Page Level:** Front matter can override site configuration:
   ```yaml
   ---
   layout: default
   title: "Documentation"
   dark_mode: false # Suppress toggle on this specific page
   ---
   ```
3. **Anti-FOUC Guarantee:** The script in [`../_includes/shared-head.html`](../_includes/shared-head.html) reads stored theme preferences before stylesheets are parsed, eliminating any theme flashing on page load.

---

## Creating a New Resume-Like Layout (Another Language or Variant)

To add support for a third language (e.g. French, Spanish, or German) or create a specialized resume layout variant:

1. **Duplicate Base Layout:**
   Copy `_layouts/resume-en.html` or `_layouts/resume-ar.html` to `_layouts/resume-xx.html` (where `xx` is your target ISO language code).
2. **Configure Direction & Language Attributes:**
   Set the root HTML tag appropriately: `<html lang="xx" dir="ltr">` (or `dir="rtl"` for right-to-left languages).
3. **Create Head Include:**
   Create `_includes/resume-head-xx.html` to load language-appropriate web fonts and stylesheets, and include `{% include hreflang.html %}` inside it for search engine alternates.
4. **Create Section Dispatcher:**
   Create `_includes/resume-section-xx.html` with localized headings and labels (e.g., "Expérience", "Éducation"), mirroring the section dispatch structure used by `resume-section-en.html` and `resume-section-ar.html`.
5. **Add Localized Header Elements:**
   Add localized CTA button labels and header contact tooltips in `_layouts/resume-xx.html`.
6. **Configure Page Front Matter:**
   Create a page (e.g., `resume-fr.md`) using your new layout and configure matching language and translation group tags:
   ```yaml
   ---
   layout: resume-xx
   permalink: /resume/xx/
   lang: xx
   t_id: resume
   ---
   ```

> [!TIP]
> Keep date formatting and ongoing position text (such as "Present" in English or "حتى الآن" in Arabic) consistent with the idioms of your target language.

---

## Creating Custom General Layouts

To create a new general page layout (e.g., `_layouts/academic-cv.html`):

1. Extend `default.html` or replicate the clean base wrapper structure.
2. Initialize `resume_data` using the dot-path resolution snippet above.
3. Incorporate standard theme partials ([`../_includes/shared-head.html`](../_includes/shared-head.html), [`../_includes/avatar.html`](../_includes/avatar.html), [`../_includes/dark-mode-toggle.html`](../_includes/dark-mode-toggle.html)).
4. Reference your custom layout in page front matter:
   ```yaml
   ---
   layout: academic-cv
   title: "Academic Curriculum Vitae"
   ---
   ```
