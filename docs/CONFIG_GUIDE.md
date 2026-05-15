# Configuration Guide (_config.yml)

Make your site render correctly with this theme. This guide matches the shipped `_config.yml` template exactly, removes ambiguity, and adds clear examples.

---

## Table of contents

- [Quick start](#quick-start)
- [Required settings](#required-settings)
- [Recommended basics](#recommended-basics)
- [Data source (active_resume_path_en/_ar)](#data-source-active_resume_path_en_ar)
- [Header and contact](#header-and-contact)
- [Sections](#sections)
- [Language and RTL](#language-and-rtl)
- [Social links](#social-links)
- [Analytics](#analytics)
- [Design and authors](#design-and-authors)
- [Jekyll build settings](#jekyll-build-settings)
- [Full example config](#full-example-config)
- [FAQs](#faqs)

---

## Quick start

**For beginners:** This guide explains every setting in `_config.yml`. Start with the basics below, then add more sections as you need them. You can find sample configuration files in `docs/_data/_config.sample.yml` and sample data files in `docs/_data/en/` and `docs/_data/ar/`.

Copy, paste, and customize the ALL-CAPS values:

```yaml
# Required basics
theme: bilingual-jekyll-resume-theme
url: https://YOUR-DOMAIN.com
baseurl: ""        # leave empty unless deploying to a subpath

title: YOUR NAME
name:
  first: YOUR
  middle: M
  last: NAME
resume_title: YOUR JOB TITLE

description: Your short tagline (optional)

timezone: UTC

contact_info:
  email: you@example.com

# Resume sections to show and their order
resume_section:
  experience: true
  education: true
  projects: true
  skills: true
resume_section_order:
  - experience
  - education
  - projects
  - skills
```

That’s enough to render a working resume using data from `_data/`.

---

## Required settings

- theme: Must be `bilingual-jekyll-resume-theme`.
- url: Full site URL (protocol + host). Used for SEO and absolute links.
- title: Site title (footer and SEO).
- name.first, name.last: Appears in the header (`middle` is optional).
  - use `name_ar.` for arabic version of name
- resume_title: English job title shown in header.
- contact_info.email: Needed if `resume_looking_for_work: true` (for the contact button).

---

## Recommended basics

- description: Short site description/tagline (used by SEO tags).
- baseurl: Keep empty unless deploying under a subdirectory (e.g., `/resume`).
- timezone: Set to your region (e.g., `UTC`, `Etc/GMT`, `America/New_York`).
- resume_avatar: true/false to show/hide the profile image.
- display_header_contact_info: true/false to show/hide contact row in header.

---

## Data source (active_resume_path_en/_ar)

The layouts read resume data from a subtree of `_data/` using dot-separated paths.

**Recommended approach (for beginners):** Use language-specific folders. Set `active_resume_path_en: "en"` and `active_resume_path_ar: "ar"` to use `_data/en/` and `_data/ar/` folders. This is the recommended approach even if you're only using one language, as it keeps your data organized and makes it easy to add more languages later.

**Advanced approach:** If you place files directly in `_data/` (root), set `active_resume_path_en: ""` and `active_resume_path_ar: ""`. This approach is not recommended for beginners.

- active_resume_path_en: Path for English pages (recommended: `"en"` for `_data/en/`).
- active_resume_path_ar: Path for Arabic pages (recommended: `"ar"` for `_data/ar/`).
- If the value is an empty string (`""`) or not set, the root of `_data/` is used (advanced users only).

Examples:

```yaml
# Recommended: Use language-specific folders
active_resume_path_en: "en"          # -> uses _data/en/* (recommended for beginners)
active_resume_path_ar: "ar"          # -> uses _data/ar/* (recommended for beginners)

# Advanced: Nested example for versioning
active_resume_path_en: "2025-06.PM"   # -> uses _data/2025-06/PM/*

# Advanced: Root example (not recommended for beginners)
# Only use this if you place files directly under _data/ (not in language folders)
active_resume_path_en: ""
active_resume_path_ar: ""
```

**Note:** This theme uses the two keys above (there is no single `active_resume_path`). For beginners, always use `"en"` and `"ar"` to keep your data organized in language folders.

---

## Header and contact

- resume_avatar (bool): Show/hide avatar in the header.
- resume_header_intro_en (bool): Enable/disable the English intro paragraph below name/title. When enabled, reads from `resume_data.header.intro` (create `_data/en/header.yml` with an `intro:` field). **Recommended:** Use `_data/en/header.yml` for English.
- resume_header_intro_ar (bool): Enable/disable the Arabic intro paragraph below name/title. When enabled, reads from `resume_data.header.intro` (create `_data/ar/header.yml` with an `intro:` field). **Recommended:** Use `_data/ar/header.yml` for Arabic.
- resume_looking_for_work (bool | omitted):
  - true → Shows “Contact me” button using `contact_info.email`.
  - false → Shows a neutral “I’m not looking for work” pill.
  - omitted → Shows nothing.
- display_header_contact_info (bool): Show/hide contact row (phone, email, address, DoB, compact languages).
- enable_live (bool): When true, uses `contact_info.email_live`/`phone_live` instead of `email`/`phone`.

contact_info fields:
- email (required for contact button), phone (optional), address (optional), address_ar (optional on Arabic page), dob (optional), email_live/phone_live (used when `enable_live: true`).

Language-specific titles:
- resume_title (EN), resume_title_ar (AR).

---

## Sections

Available sections: experience, education, certifications, courses, volunteering, projects, skills, recognition, associations, interests, languages, links

- resume_section.<name> (bool): Master toggle per section.
- resume_section.lang_header (bool): When true and `languages` data exists, shows a compact languages summary in the header instead of rendering the full Languages section.
- resume_section_order (array): Rendering order; disabled sections are skipped.

Helpful toggles:
- enable_summary (bool): If true, renders `summary` fields for roles/courses when present.
- resume_print_social_links (bool): If true, adds a text-only “Social Links” section on print/PDF.

---

## Language and RTL

- resume_title_ar: Arabic job title for the Arabic layout.
- address_ar: Arabic address line for the Arabic header contact row.
- Arabic dates: `_includes/ar-date.html` expects `site.data.ar.months` to map 1–12 to Arabic month names. **The theme already includes `_data/ar/months.yml`, so you don't need to create this file manually.**
- Present text: English shows "Present"; Arabic shows "حتى الآن".
- Header intro: To add an intro paragraph below your name/title, create `_data/en/header.yml` for English (or `_data/ar/header.yml` for Arabic) with an `intro:` field containing your text. Then enable `resume_header_intro_en: true` or `resume_header_intro_ar: true` in `_config.yml`. **Recommended:** Always use language-specific folders (`_data/en/` and `_data/ar/`). Sample files are available in `docs/_data/en/header.yml` and `docs/_data/ar/header.yml`.

---

## Social links

Only keys with values render. Add the ones you want; leave others out.

Supported keys (icons on page; text list for print when enabled):
- github, linkedin, telegram, twitter, medium, dribbble, facebook, instagram, website, whatsapp, devto, flickr, pinterest, youtube

Tip: For printing, set `resume_print_social_links: true`.

---

## Analytics

Choose one (do not enable both):

- Google Tag Manager (recommended):
  - analytics.gtm: GTM-XXXXXXX (adds head script + `<noscript>` body iframe)
- Google Analytics 4 (gtag.js):
  - analytics.ga: true
  - analytics.gtag: G-XXXXXXXXXX

---

## Design and authors

- resume_theme: Theme variant (currently `default`).
- authors: Optional list; not required by the theme but supported in config.

---

## Languages Dictionary

The `languages` object is the central source of truth for supported languages and their text direction (LTR/RTL).

```yaml
languages:
  en:
    dir: ltr
  ar:
    dir: rtl
```


## Jekyll build settings

- plugins (required): jekyll-feed, jekyll-seo-tag, jekyll-sitemap, jekyll-redirect-from
- include: Files/dirs to include (e.g., `_redirects`, `.well-known/`, `_pages/`, `_posts/`).
- exclude: Files/dirs to ignore (e.g., README.md, Gemfile*, vendor/, node_modules/, scripts/).
- defaults: Optional front matter defaults.

---

## Full example config

```yaml
# Identity
theme: bilingual-jekyll-resume-theme
url: https://your-domain.com
baseurl: ""
title: Jane Doe
description: Product leader focused on outcomes

timezone: UTC

# Name & titles
name:
  first: Jane
  middle: Q.
  last: Doe
name_ar:
  first:
  middle:
  last:
resume_title: Senior Product Manager
resume_title_ar: مديرة منتج أولى

# Contact
contact_info:
  email: jane.doe@example.com
  phone: "+1 555 555 5555"
  address: "San Francisco, CA"
  address_ar: "سان فرانسيسكو، كاليفورنيا"
# Live-mode alternates
# enable_live: false
# contact_info:
#   email_live: live@example.com
#   phone_live: "+1 555 000 0000"

display_header_contact_info: true
resume_avatar: true
resume_header_intro_en: true  # Enable English intro (reads from resume_data.header.intro)
resume_header_intro_ar: true  # Enable Arabic intro (reads from resume_data.header.intro)
resume_looking_for_work: true

# Data paths
active_resume_path_en: "en"
active_resume_path_ar: "ar"

# Sections
resume_section:
  experience: true
  education: true
  certifications: true
  courses: true
  volunteering: true
  projects: true
  associations: true
  skills: false
  recognition: false
  languages: false
  lang_header: true
  interests: false
  links: false
resume_section_order:
  - experience
  - education
  - certifications
  - courses
  - volunteering
  - projects
  - associations
  - skills
  - recognition
  - languages
  - interests
  - links

# Behavior
enable_summary: false
resume_print_social_links: true

# Social
social_links:
  github: https://github.com/janedoe
  linkedin: https://www.linkedin.com/in/janedoe/
  website: https://janedoe.com
  twitter: https://twitter.com/janedoe

# Theme & analytics
authors: []
resume_theme: default
analytics:

languages:
  en:
    dir: ltr
  ar:
    dir: rtl
  # gtm: GTM-XXXXXXX
  # ga: true
  # gtag: G-XXXXXXXXXX

# Jekyll
plugins:
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-sitemap
  - jekyll-redirect-from
include:
  - _redirects
  - .well-known/
  - _pages/
  - _posts/
exclude:
  - scratch.md
  - README.md
  - Gemfile*
  - vendor/
  - node_modules/
  - "*.gemspec"
  - netlify.toml
  - vercel.json
  - WARP.md
  - scripts/
```

---

## FAQs

- A section isn’t showing up.
  - Ensure `resume_section.<name>: true`, it appears in `resume_section_order`, and your data items have `active: true`.
- Contact button shows but nothing happens.
  - Set `contact_info.email` or set `resume_looking_for_work: false`.
- Arabic months appear as numbers.
  - The theme includes `_data/ar/months.yml` by default. If you're using a custom data path, ensure `site.data.ar.months` is accessible.
- Header intro not showing.
  - Enable `resume_header_intro_en: true` or `resume_header_intro_ar: true` in `_config.yml`, and create `_data/en/header.yml` (or `_data/ar/header.yml` for Arabic) in your active data path with an `intro:` field. You can copy sample files from `docs/_data/en/header.yml` and `docs/_data/ar/header.yml`.
- Data for EN/AR lives in different folders.
  - Point `active_resume_path_en` and `active_resume_path_ar` at the right subtrees (e.g., `en` and `ar`).
