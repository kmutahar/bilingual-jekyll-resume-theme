# Configuration Guide (`_config.yml`)

Make your bilingual resume site render cleanly and correctly. This guide matches the shipped [`_data/_config.sample.yml`](_data/_config.sample.yml) configuration file exactly, explains every setting and data type, and provides practical copy-paste examples.

---

## Table of Contents

- [Quick Start](#quick-start)
- [Configuration Reference](#configuration-reference)
  - [1. Site Identity & Localization](#1-site-identity--localization)
  - [2. Favicons & Web App Manifest](#2-favicons--web-app-manifest)
  - [3. Personal Information & Job Titles](#3-personal-information--job-titles)
  - [4. Profile Picture / Avatar Settings](#4-profile-picture--avatar-settings)
  - [5. Contact Information](#5-contact-information)
  - [6. Social Media Links](#6-social-media-links)
  - [7. Resume Display & Behavior Controls](#7-resume-display--behavior-controls)
  - [8. Resume Sections Toggle & Order](#8-resume-sections-toggle--order)
  - [9. Styling, Fonts & Dark Mode](#9-styling-fonts--dark-mode)
  - [10. Analytics Configuration](#10-analytics-configuration)
  - [11. Jekyll Build Settings & Plugins](#11-jekyll-build-settings--plugins)
- [Full Example Configuration](#full-example-configuration)
- [Frequently Asked Questions (FAQs)](#frequently-asked-questions-faqs)

---

## Quick Start

> [!TIP]
> To get started immediately, copy [`_data/_config.sample.yml`](_data/_config.sample.yml) to your site's root directory as `_config.yml`. Starter resume data is available in [`_data/en/`](_data/en/) and [`_data/ar/`](_data/ar/).

Here is the minimal working configuration required to build a functional bilingual resume:

```yaml
# Required basics
theme: bilingual-jekyll-resume-theme
title: "Jane Doe"
url: "https://your-domain.com"
baseurl: ""                   # Keep empty unless hosting on a subpath (e.g., /resume)
timezone: UTC

name:
  first: "Jane"
  last: "Doe"

name_ar:
  first: "جين"
  last: "دو"

resume_title: "Senior Product Manager"
resume_title_ar: "مديرة منتج أولى"

contact_info:
  email: "jane.doe@example.com"

active_resume_path_en: "en"
active_resume_path_ar: "ar"

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

---

## Configuration Reference

### 1. Site Identity & Localization

These top-level keys define global site metadata, base URLs, and HTML language attributes.

| Setting | Type | Default | Description |
|---|---|---|---|
| `theme` | String | `"bilingual-jekyll-resume-theme"` | **Required.** Activates the gem theme. |
| `title` | String | `""` | **Required.** Site title used for SEO tags and layout footers. |
| `description` | String | `""` | Short site summary/tagline emitted by `{% seo %}` meta tags. |
| `url` | String | `""` | **Required.** Canonical protocol and domain (e.g., `https://example.com`). |
| `baseurl` | String | `""` | Subdirectory path if site is not served from domain root. |
| `timezone` | String | `"UTC"` | Timezone string for date parsing (e.g., `America/New_York`, `Asia/Riyadh`). |
| `lang` | String | `"en"` | Global HTML language tag for base layout (`default.html`). |
| `dir` | String | `"ltr"` | Global text direction (`"ltr"` or `"rtl"`) for base layout (`default.html`). |

```yaml
theme: bilingual-jekyll-resume-theme
title: "Jane Doe"
description: >-
  Senior Product Manager specializing in AI platforms and bilingual systems.
url: "https://janedoe.com"
baseurl: ""
timezone: America/New_York
lang: "en"
dir: "ltr"
```

---

### 2. Favicons & Web App Manifest

The theme ships with a pre-packaged, high-resolution favicon suite located under `assets/favicon/resume/`. You can override any asset with your own site-level paths:

| Setting | Type | Default | Description |
|---|---|---|---|
| `favicon` | String | `"assets/favicon/resume/favicon.ico"` | Primary `.ico` shortcut icon. |
| `apple_touch_icon` | String | `"assets/favicon/resume/apple-touch-icon.png"` | 180x180 PNG icon for iOS home screens. |
| `favicon_32` | String | `"assets/favicon/resume/favicon-32x32.png"` | 32x32 standard browser favicon. |
| `favicon_16` | String | `"assets/favicon/resume/favicon-16x16.png"` | 16x16 standard browser favicon. |

```yaml
# Optional custom favicon overrides (place files in your site repo)
favicon: "assets/favicon/custom/favicon.ico"
apple_touch_icon: "assets/favicon/custom/apple-touch-icon.png"
favicon_32: "assets/favicon/custom/favicon-32x32.png"
favicon_16: "assets/favicon/custom/favicon-16x16.png"
```

> [!NOTE]
> All favicon paths are automatically passed through Jekyll's `relative_url` filter in [`../_includes/shared-head.html`](../_includes/shared-head.html) for subpath deployment safety.

---

### 3. Personal Information & Job Titles

Defines candidate names and professional titles rendered prominently in headers and page metadata.

| Setting | Type | Default | Description |
|---|---|---|---|
| `name.first` | String | `""` | **Required.** English first name. |
| `name.middle` | String | `""` | Optional English middle name or initial. |
| `name.last` | String | `""` | **Required.** English last name. |
| `name_ar.first` | String | `""` | Arabic first name for `resume-ar.html`. |
| `name_ar.middle` | String | `""` | Optional Arabic middle name. |
| `name_ar.last` | String | `""` | Arabic last name for `resume-ar.html`. |
| `resume_title` | String | `""` | English job title / professional designation. |
| `resume_title_ar` | String | `""` | Arabic job title / professional designation. |

```yaml
name:
  first: "Jane"
  middle: "Q."
  last: "Doe"

name_ar:
  first: "جين"
  middle: "كيو."
  last: "دو"

resume_title: "Senior Product Manager"
resume_title_ar: "مديرة منتج أولى"
```

---

### 4. Profile Picture / Avatar Settings

The profile avatar component is managed by [`../_includes/avatar.html`](../_includes/avatar.html). It supports local repository files, remote CDN URLs, language-aware alt text, and customizable link wrapping.

| Setting | Type | Default | Description |
|---|---|---|---|
| `resume_avatar` | Boolean | `true` | Master switch to show/hide the profile picture in resume headers. |
| `avatar_url` | String | `"/assets/images/Profile-min.jpg"` | Path (relative or external URL) to avatar image. |
| `avatar_alt_en` | String | English full name | Accessible alt text for English layout. |
| `avatar_alt_ar` | String | Arabic full name | Accessible alt text for Arabic layout (`resume-ar.html`). |
| `avatar_alt` | String | `"Profile photo"` | Universal fallback alt text if language-specific alt is unset. |
| `avatar_link` | String / Boolean | `"/"` | Destination URL when clicked. Set to `false` to disable link wrapping. |
| `avatar_link_target` | String | `"_self"` | Target window attribute (`"_self"` recommended, or `"_blank"`). |

```yaml
resume_avatar: true
avatar_url: "assets/images/profile.jpg" # or "https://cdn.example.com/avatar.jpg"
avatar_alt_en: "Jane Doe - Professional Profile"
avatar_alt_ar: "جين دو - الصورة الشخصية الرسمية"
avatar_link: "/"
avatar_link_target: "_self"
```

---

### 5. Contact Information

Candidate contact methods rendered in resume header and print sections.

| Setting | Type | Default | Description |
|---|---|---|---|
| `contact_info.email` | String | `""` | **Required** if `resume_looking_for_work: true` (powers contact CTA button). |
| `contact_info.phone` | String | `""` | Primary telephone number. |
| `contact_info.address` | String | `""` | English location string (e.g., `"San Francisco, CA"`). |
| `contact_info.address_ar` | String | `""` | Localized Arabic location string (e.g., `"سان فرانسيسكو، كاليفورنيا"`). |
| `contact_info.dob` | Date | `nil` | Date of birth (`YYYY-MM-DD`). |
| `contact_info.email_live` | String | `""` | Alternate email used when `enable_live: true`. |
| `contact_info.phone_live` | String | `""` | Alternate phone number used when `enable_live: true`. |

```yaml
contact_info:
  email: "jane.doe@example.com"
  phone: "+1 555 555 5555"
  address: "San Francisco, CA"
  address_ar: "سان فرانسيسكو، كاليفورنيا"
  dob: 1992-05-14
  # Alternate contact details:
  # email_live: "live@janedoe.com"
  # phone_live: "+1 555 000 0000"
```

---

### 6. Social Media Links

The theme provides bundled SVG icons for 14 platforms via [`../_includes/social-links.html`](../_includes/social-links.html) and print listings via [`../_includes/print-social-links.html`](../_includes/print-social-links.html). Only platforms configured with a valid URL will render.

```yaml
social_links:
  github: https://github.com/yourusername
  linkedin: https://www.linkedin.com/in/yourhandle/
  twitter: https://twitter.com/yourhandle
  telegram: https://t.me/yourhandle
  medium: https://medium.com/@yourhandle
  website: https://yourwebsite.com
  whatsapp: https://wa.me/1234567890
  instagram: https://instagram.com/yourhandle
  facebook: https://facebook.com/yourhandle
  youtube: https://youtube.com/@yourhandle
  devto: https://dev.to/yourhandle
  dribbble: https://dribbble.com/yourhandle
  flickr: https://flickr.com/people/yourhandle
  pinterest: https://pinterest.com/yourhandle
  # mastodon emits <link rel="me"> in default.html for IndieAuth / Fediverse verification:
  mastodon: https://mastodon.social/@yourhandle
```

---

### 7. Resume Display & Behavior Controls

Settings controlling data sources, header elements, and rendering behaviors:

| Setting | Type | Default | Description |
|---|---|---|---|
| `active_resume_path_en` | String | `"en"` | Dot-separated subpath in `_data/` for English resume data. |
| `active_resume_path_ar` | String | `"ar"` | Dot-separated subpath in `_data/` for Arabic resume data. |
| `display_header_contact_info` | Boolean | `true` | Show/hide the contact information row in header. |
| `resume_header_intro_en` | Boolean | `true` | Render English summary from `_data/en/header.yml`. |
| `resume_header_intro_ar` | Boolean | `false` | Render Arabic summary from `_data/ar/header.yml`. |
| `resume_looking_for_work` | Boolean / omitted | `true` | `true` = contact button; `false` = "not looking" status pill; omitted = blank. |
| `enable_summary` | Boolean | `false` | Expand detailed `summary` fields under role and course entries. |
| `enable_live` | Boolean | `false` | Switch phone and email to `phone_live` and `email_live`. |
| `resume_print_social_links` | Boolean | `true` | Include a plaintext social links section in printed/PDF outputs. |

```yaml
active_resume_path_en: "en"
active_resume_path_ar: "ar"
display_header_contact_info: true
resume_header_intro_en: true
resume_header_intro_ar: true
resume_looking_for_work: true
enable_summary: true
enable_live: false
resume_print_social_links: true
```

---

### 8. Resume Sections Toggle & Order

Resume sections are dynamically rendered through [`../_includes/resume-section-en.html`](../_includes/resume-section-en.html) and [`../_includes/resume-section-ar.html`](../_includes/resume-section-ar.html).

> [!NOTE]
> The canonical section key in `resume_section` and `resume_section_order` is **`recognitions`** (plural), matching the YAML data file **`recognitions.yml`**. The legacy singular key **`recognition`** remains supported as a backward-compatible fallback until `v1.0.0`.

```yaml
# Section toggles (true to display, false to hide)
resume_section:
  experience: true
  education: true
  certifications: true
  courses: true
  volunteering: true
  projects: true
  associations: true
  skills: true
  recognitions: false    # Toggles data loaded from recognitions.yml (legacy 'recognition' supported)
  languages: false
  lang_header: true      # Renders compact language chips in header instead of full section
  interests: false
  links: false

# Exact sequence in which sections are rendered:
resume_section_order:
  - experience
  - education
  - certifications
  - courses
  - volunteering
  - projects
  - associations
  - skills
  - recognitions
  - languages
  - interests
  - links
```

---

### 9. Styling, Fonts & Dark Mode

The theme provides automatic CSS-first dark mode support, custom Arabic font integration, and offline compilation options.

| Setting | Type | Default | Description |
|---|---|---|---|
| `dark_mode` | String / Boolean | `"auto"` | Dark mode strategy (`"auto"`, `"enabled"`, `true`, `false`). |
| `resume_dark_mode` | String / Boolean | `"auto"` | Legacy backward-compatible alias for `dark_mode`. |
| `resume_theme` | String | `"default"` | Visual theme variant. |
| `font_ar_url` | String | `""` | Custom stylesheet URL for self-hosted or alternate CDN Arabic fonts. |
| `disable_google_fonts` | Boolean | `false` | Disable remote Google Fonts fetching for offline/intranet builds or GDPR compliance. |

#### Dark Mode Values Explained

- **`"auto"`** (Default):
  - Pure CSS system detection using `@media (prefers-color-scheme: dark)`.
  - Adapts to user OS theme without JavaScript runtime overhead.
  - **No toggle button is rendered**.
- **`"enabled"`** (or `true`):
  - Enables an interactive floating toggle button site-wide across all layouts.
  - Persists visitor selection in `localStorage`.
  - Includes synchronous anti-FOUC script in `<head>`.
- **`false`**:
  - Disables dark mode toggle rendering.

```yaml
# Recommended: Automatic system detection
dark_mode: auto

# Or enable interactive toggle button:
# dark_mode: enabled

# Optional font customizations:
# font_ar_url: "https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700&display=swap"
# disable_google_fonts: true
```

---

### 10. Analytics Configuration

Configure at most **one** analytics provider. Never configure both GTM and GA4 simultaneously.

| Setting | Type | Description |
|---|---|---|
| `analytics.gtm` | String | Google Tag Manager container ID (`"GTM-XXXXXXX"`). Injects `<head>` script and `<body>` `<noscript>` iframe. |
| `analytics.gtag` | String | Google Analytics 4 Measurement ID (`"G-XXXXXXXXXX"`). Injects async `gtag.js`. |
| `analytics.ga` | String | Legacy Google Universal Analytics Tracking ID (`"UA-XXXXXXXXX-X"`). |

```yaml
analytics:
  # Google Tag Manager (Recommended):
  # gtm: "GTM-XXXXXXX"

  # Or Google Analytics 4:
  # gtag: "G-XXXXXXXXXX"
```

---

### 11. Jekyll Build Settings & Plugins

Core build settings required by the theme gem:

```yaml
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

defaults: []
```

---

## Full Example Configuration

Below is the complete template from [`_data/_config.sample.yml`](_data/_config.sample.yml):

```yaml
# ==============================================================================
# SITE IDENTITY & LOCALIZATION
# ==============================================================================
theme: bilingual-jekyll-resume-theme
title: "Jane Doe"
description: >-
  Senior Product Manager specializing in AI platforms and bilingual systems.
url: "https://your-domain.com"
baseurl: ""
timezone: UTC

# ==============================================================================
# PERSONAL INFORMATION & TITLES
# ==============================================================================
name:
  first: "Jane"
  middle: "Q."
  last: "Doe"

name_ar:
  first: "جين"
  middle: "كيو."
  last: "دو"

resume_title: "Senior Product Manager"
resume_title_ar: "مديرة منتج أولى"

# ==============================================================================
# PROFILE PICTURE / AVATAR SETTINGS
# ==============================================================================
resume_avatar: true
# avatar_url: "assets/images/Profile-min.jpg"
# avatar_alt_en: "Jane Doe"
# avatar_alt_ar: "جين دو"
# avatar_link: "/"
# avatar_link_target: "_self"

# ==============================================================================
# CONTACT INFORMATION
# ==============================================================================
contact_info:
  email: "jane.doe@example.com"
  phone: "+1 555 555 5555"
  address: "San Francisco, CA"
  address_ar: "سان فرانسيسكو، كاليفورنيا"
  dob: 1992-05-14

# ==============================================================================
# SOCIAL MEDIA LINKS
# ==============================================================================
social_links:
  github: https://github.com/yourusername
  linkedin: https://www.linkedin.com/in/yourhandle/
  twitter: https://twitter.com/yourhandle
  website: https://yourwebsite.com

# ==============================================================================
# RESUME DISPLAY & BEHAVIOR CONTROLS
# ==============================================================================
active_resume_path_en: "en"
active_resume_path_ar: "ar"
display_header_contact_info: true
resume_header_intro_en: true
resume_header_intro_ar: true
resume_looking_for_work: true
enable_summary: false
enable_live: false
resume_print_social_links: true

# ==============================================================================
# RESUME SECTIONS TOGGLE & ORDER
# ==============================================================================
resume_section:
  experience: true
  education: true
  certifications: true
  courses: true
  volunteering: true
  projects: true
  associations: true
  skills: true
  recognitions: false
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
  - recognitions
  - languages
  - interests
  - links

# ==============================================================================
# STYLING, FONTS & DARK MODE
# ==============================================================================
dark_mode: auto
resume_theme: default

# ==============================================================================
# ANALYTICS
# ==============================================================================
analytics:
  # gtm: "GTM-XXXXXXX"
  # gtag: "G-XXXXXXXXXX"

# ==============================================================================
# JEKYLL BUILD SETTINGS
# ==============================================================================
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

defaults: []
```

---

## Frequently Asked Questions (FAQs)

### A section is not rendering on my resume. What should I check?
1. Ensure `resume_section.<name>: true` is set in `_config.yml`.
2. Confirm the section name exists in `resume_section_order`.
3. Check your YAML data file (e.g., [`_data/en/experience.yml`](_data/en/experience.yml)) and verify that items have `active: true`.
4. The recognition section toggle is named `recognitions` (matching `recognitions.yml`), with legacy singular `recognition` supported as a fallback.

### How do I display language proficiency chips in the header?
Set `resume_section.lang_header: true` and ensure [`_data/en/languages.yml`](_data/en/languages.yml) contains active language items. If you prefer a full Languages section at the bottom, set `resume_section.lang_header: false` and `resume_section.languages: true`.

### Why doesn't dark mode apply to print or PDF downloads?
Resumes are optimized for crisp physical and PDF output. High-contrast black text on pure white paper is enforced via `@media print` in [`../_sass/_dark-mode.scss`](../_sass/_dark-mode.scss), and the interactive toggle button is hidden with `.no-print`.

### How do I switch between different resume versions?
Use dotted data paths for `active_resume_path_en` and `active_resume_path_ar`. For example, setting `active_resume_path_en: "2025-06.PM"` will load resume data from `_data/2025-06/PM/*.yml`. See [`LAYOUTS_GUIDE.md`](LAYOUTS_GUIDE.md) for data flow details.
