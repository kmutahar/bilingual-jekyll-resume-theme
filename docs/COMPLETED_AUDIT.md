# Completed Historical Remediation & Engineering Audit Log

**Project:** `bilingual-jekyll-resume-theme`  
**Current Release:** `v1.0.1` (Audited Baseline: `v0.7.0`)  
**Milestone:** M1 Completed Audit Archival  
**Audit Date:** September 2026  
**Master Active Roadmap:** [`/FEATURE_ROADMAP.md`](../FEATURE_ROADMAP.md)  
**Status:** Permanent Historical Record. All foundation items, completed features, and release deliverables are verified in git history and documented in this audit archive.

---

## 1. Executive Summary & Audit Overview

This document provides the definitive, permanent engineering record of all **bug fixes, security hardenings, data resilience enhancements, accessibility upgrades, and architectural feature deliverables** completed across the `bilingual-jekyll-resume-theme` repository. It serves as the immutable historical record of foundation remediations and completed features across releases.

To maintain strict hygiene in the active roadmap and eliminate document drift across planning cycles, completed items have been permanently retired from the active roadmap phases and archived in this audit document. For the active, forward-looking engineering roadmap detailing upcoming uncompleted features across Priorities 1 through 4, refer to the authoritative master roadmap at [`/FEATURE_ROADMAP.md`](../FEATURE_ROADMAP.md).

---

## 2. Master Completed Remediation Matrix

| ID | Title | Originating Source | Category | Target Release | Git Commit SHA | Exact Target Files Modified / Created |
|---|---|---|---|---|---|---|
| **P0.1** | Fix Broken Arabic Phone Link & Schema Microdata | Codebase Audit | Bug / Logic / SEO | `v0.7.0` | `caf726c557e8289c991b6cb15acc3cc54504867e` | `_layouts/resume-ar.html`, `_layouts/resume-en.html` |
| **P0.2** | Fix Invalid Double `else` in Liquid Conditional | Codebase Audit | Syntax Bug | `v0.7.0` | `54f5c9676766c2ee04cd44a9b64b1a3472ca4d70` | `_includes/analytics-body.html` |
| **P0.3** | Fix GA4 / Gtag Parameter Mismatch | Codebase Audit | Logic / Config | `v0.7.0` | `dff8c3d3ce3bfebf2ebb37d3ada348ed1a603f3c` | `_includes/analytics-head.html`, `docs/CONFIG_GUIDE.md`, `docs/INCLUDES_GUIDE.md`, `docs/_data/_config.sample.yml` |
| **P0.4** | Add Missing GTM Body Noscript to Resume Layouts | Codebase Audit | Integration / Analytics | `v0.7.0` | `54f5c9676766c2ee04cd44a9b64b1a3472ca4d70` | `_layouts/resume-ar.html`, `_layouts/resume-en.html` |
| **P0.5** | Quote Unquoted `href` & Add RTL `dir="ltr"` Text Isolation | Codebase Audit | Security / HTML / i18n | `v0.7.0` | `73da0959f2de2b7a6585d2c1c03fc59a4fa55f65` | `_includes/resume-section-ar.html`, `_includes/resume-section-en.html` |
| **P0.6** | Fix Relative 404 Favicon Path in Subdirectories | Codebase Audit | Asset / 404 Resolution | `v0.7.0` | `943d5653d5cbfa5f6189b4975a74f2e981c6ceb1` | `_includes/shared-head.html`, `_includes/resume-head-ar.html`, `_includes/resume-head-en.html`, `docs/CONFIG_GUIDE.md`, `docs/INCLUDES_GUIDE.md`, `docs/_data/_config.sample.yml` |
| **P0.7** | Remove Conflicting Duplicate Canonical Tags | Codebase Audit | SEO / Standards | `v0.7.0` | `8f8b22bfdea4e40371366db47bdddd98d412631a` | `_includes/shared-head.html`, `docs/INCLUDES_GUIDE.md` |
| **P0.8** | Fix Arabic Cairo Font Loading for Custom Themes | Codebase Audit | Typography / i18n | `v0.7.0` | `ca6898b883a5264dbee9088c849bfd6a00fdf079` | `_includes/resume-head-ar.html`, `docs/CONFIG_GUIDE.md` |
| **P0.9** | Scope Global `svg` Selector to Prevent Icon Distortion | Codebase Audit | CSS Bug / Layout | `v0.7.0` | `d44dcb15360ddd3c6e5eb42bc973564f882ee177` | `_sass/_all-pages.scss`, `_sass/_dark-mode.scss` |
| **P0.10** | WCAG 2.1 AA Accessible Labels on Social Links | Issue [#21](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/21) | Accessibility (WCAG) | `v0.7.0` | `d44dcb15360ddd3c6e5eb42bc973564f882ee177` | `_includes/social-links.html`, `_sass/_base.scss`, 14 SVG files in `_includes/vendors/lineicons-v5.0/` |
| **P0.11** | Fix Arabic Print Social Links Bidi Scrambling | Codebase Audit | RTL / Print / i18n | `v0.7.0` | `ca6898b883a5264dbee9088c849bfd6a00fdf079` | `_includes/print-social-links.html` |
| **P0.12** | Documentation & Metadata Version Alignment | Codebase Audit | Governance / Release | `v0.7.0` | `967e0f01fabab1595bcfeb7ba4d4fa44fc672ef0`, `8284ee7c0ffe351b823ad8ea0854b8e6d6afecd5` | `bilingual-jekyll-resume-theme.gemspec`, `SECURITY.md`, `CLAUDE.md`, `README.md`, `CHANGELOG.md`, `docs/DATA_GUIDE.md` |
| **P0.13** | Make `description` Optional in `skills.yml` | Issue [#2](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/2) | Data Resilience | `v0.4.0` | `601dbf9d81a621366d3a0e46f7079da42aa73e75` | `_includes/resume-section-en.html`, `_includes/resume-section-ar.html` |
| **P0.14** | Make `summary` Optional in `recognitions.yml` | Issue [#3](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/3) | Data Resilience | `v0.4.0` | `34b46613dc561a3d1868fdf8d64f7cfd80e02e5d` | `_includes/resume-section-en.html`, `_includes/resume-section-ar.html` |
| **P0.15** | Make `summary` Optional in `Associations.yml` | Issue [#4](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/4) | Data Resilience | `v0.4.0` | `a12cdc8b9d64db5c3368db6dc270c03a4f353538` | `_includes/resume-section-en.html`, `_includes/resume-section-ar.html` |
| **P0.16** | Move Resume Header Intro from Config to Data File | Issue [#5](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/5) | Architecture / i18n | `v0.4.0` | `d026de92817b3de76843e18b8770c20136ae0691` | `_layouts/resume-ar.html`, `_layouts/resume-en.html`, `_data/en/header.yml`, `_data/ar/header.yml`, `docs/_config.sample.yml` |
| **P1.2** | Interactive Bilingual Language Switcher (EN ⇋ AR) | Issue [#11](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/11) | i18n / Navigation | `v0.8.0` | `c56e50f` | `_includes/language-switcher.html`, `_layouts/resume-en.html`, `_layouts/resume-ar.html`, `_layouts/default.html`, `_sass/_layout.scss`, `_sass/_resume-rtl.scss`, docs |
| **P1.4** | Configurable Avatar Image URL, Alt Text & Link Mode | Codebase Audit | Customization / a11y | `v0.7.0` | `a17cc603a3633bb5dc67589bcc01ce7ef886d88c` | `_includes/avatar.html`, `_layouts/resume-ar.html`, `_layouts/resume-en.html`, `docs/CONFIG_GUIDE.md`, `docs/INCLUDES_GUIDE.md` |
| **P2.4** | Site-Wide Dark Mode & HTTP Error Suite (404/403/500) | Issue [#8](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/8) | UX / Architecture | `v0.7.0` | `853a9ac1eaf11aadec62f198f6b7e9cdb2d3c209`, `4eab127d8cc3a4cedccca89943482fd3a067ee14`, `2dcb813` | `_layouts/default.html`, `_layouts/error.html`, `_layouts/profile.html`, `_layouts/resume-en.html`, `_layouts/resume-ar.html`, `_data/error_pages.yml`, `404.html`, `403.html`, `500.html`, `_sass/_all-pages.scss`, `_sass/_profile.scss`, `_sass/_dark-mode.scss`, docs |
| **P2.7** | Advanced WCAG 2.1/2.2 AA Accessibility Polish | Issue [#21](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/21) | Accessibility (WCAG) | `v0.8.0` | `a29c480` | `_layouts/resume-en.html`, `_layouts/resume-ar.html`, `_layouts/default.html`, `_layouts/profile.html`, `_sass/_base.scss`, `docs/ACCESSIBILITY_GUIDE.md` |
| **Fix #216** | Configurable Resume Navigation Links in Error Page Layout | Issue [#216](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/216) | Architecture / Navigation | `v0.8.0` | `853a9ac1` | `_layouts/error.html`, `docs/CONFIG_GUIDE.md` |
| **F1.7** | Native Email Support in Social Links Include | Issue [#215](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/215) | UX / a11y | `v1.0.0` | `d53e53ca14df4fe48581dfb73e33933b9ba57792` | `_includes/social-links.html`, `_includes/print-social-links.html` |
| **F2.8** | Header Contact Icon and Text Alignment in Arabic Layout | Issue [#217](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/217) | RTL / a11y | `v1.0.0` | `315356972b326d9fcd5ff58e0208da9a2140116f` | `_layouts/resume-ar.html` (carried into `_layouts/resume.html`) |
| **F4.1** | Extended Multilingual Support (EN, AR, ES, FR, DE, UR) | Issue [#15](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/15) | i18n / Architecture | `v1.0.0` | `54b40a4`, `3e840a7`, `5058532`, `c37df29`, `da2cd74`, `3f467fe`, `5188e96` | `_data/locales/*.yml`, `_layouts/resume.html`, `_includes/resume-section.html`, `_includes/date-formatter.html`, `_sass/_resume-ltr.scss`, `assets/css/cv-{ltr,rtl}.scss`, every locale consumer, `docs/_data/`, `docs/demo/` |
| **F4.6** | Deprecation Retirement & Legacy Fallbacks Cleanup | Issue [#214](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/214) | Cleanup / Config | `v1.0.0` | `2c88adf75c915cb682634ac0c98a2211caedb101` | `_includes/avatar.html`, `_includes/analytics-head.html`, `_includes/resume-section.html` |
| **F3.2** | Automated CI/CD Build & Verification Pipeline | Issue [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | CI/CD | `v1.0.0` | `3be935f` | `.github/workflows/ci.yml`, `.github/workflows/lint.yml`, `README.md` |
| **F3.3** | YAML Resume Data Validator & Schema Linter | Issue [#13](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/13) | Tooling / Quality | `v1.0.0` | `3be935f` | `bin/validate-resume`, `lib/bilingual-jekyll-resume-theme/resume_validator.rb`, `_plugins/resume_validator.rb`, `docs/VALIDATION_GUIDE.md`, `test/test_resume_validator.rb` |
| **F2.11** | Pin Language-Switcher/Dark-Mode-Toggle to Fixed Corners (Remove RTL Mirror) | Issue [#227](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/227) | Layout / RTL | `v1.0.1` | `305408c` | `_sass/_layout.scss`, `_sass/_dark-mode.scss`, `_sass/_resume-rtl.scss`, `test/test_language_switcher.rb`, `docs/INCLUDES_GUIDE.md` |
| **F2.12** | Dropdown Language Switcher (Replace Per-Language Button Row) | Issue [#228](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/228) | i18n / a11y | `v1.0.1` | `f37c6f6` | `_includes/language-switcher.html`, `_sass/_layout.scss`, `test/test_language_switcher.rb`, `docs/INCLUDES_GUIDE.md`, `docs/ACCESSIBILITY_GUIDE.md`, `docs/PROJECT_OVERVIEW.md` |

---

## 3. Exhaustive Technical Records: Priority 0 Bug Fixes & Security Hardening (P0.1–P0.16)

### 3.1 P0.1: Fix Broken Arabic Phone Call Link, Interactive Email Links & Schema Microdata

- **Historical Context & Origin:** Static analysis of contact elements in `_layouts/resume-ar.html` and `_layouts/resume-en.html`.
- **Problem Statement & Root Cause:**
  In `_layouts/resume-ar.html`, when `site.enable_live` was unset or `false`, the template conditionally tested `{% if site.contact_info.phone %}` but rendered `href="tel:{{ site.contact_info.phone_live | remove: ' ' }}"`. If `phone_live` was undefined in `_config.yml`, the rendered anchor produced `<a href="tel:">`, creating an unclickable, malformed URI on mobile devices. Additionally, candidate email addresses were rendered as plain text rather than interactive `mailto:` links, the `.contact-button` link destination was not dynamically linked to `email_live`, and Schema.org microdata referenced an outdated non-secure HTTP URI (`http://schema.org/Person`) without structured `<meta>` elements for telephone, email, and address.
- **Technical Remediation & Implementation Details:**
  1. Standardized telephone link sanitization across both English and Arabic layouts using chained Liquid filters: `{{ site.contact_info.phone | remove: ' ' | remove: '-' | remove: '(' | remove: ')' }}` for standard mode, and matching sanitization for `phone_live`.
  2. Fixed variable resolution in the non-live branch of `_layouts/resume-ar.html` to reliably reference `site.contact_info.phone`.
  3. Wrapped email rendering in `<a href="mailto:{{ contact_email }}">{{ contact_email }}</a>` across both layouts.
  4. Dynamically bound the `.contact-button` destination to `email_live` when `enable_live: true` and `email_live` is defined, with fallback to `site.contact_info.email`.
  5. Upgraded Schema.org namespace to HTTPS (`itemscope itemtype="https://schema.org/Person"`), added `<meta itemprop="telephone">`, `<meta itemprop="email">`, and wrapped address in `<span itemprop="address" itemscope itemtype="https://schema.org/PostalAddress"><meta itemprop="addressLocality" content="..."></span>`.
- **Exact Target Files Modified:**
  - `_layouts/resume-ar.html` (31 insertions, 7 deletions)
  - `_layouts/resume-en.html` (29 insertions, 6 deletions)
- **Git Commit SHA & Evidence:**
  - Full SHA: `caf726c557e8289c991b6cb15acc3cc54504867e`
  - Short SHA: `caf726c`
  - Commit Date: 2026-09-12 02:04:43 +0300
  - Commit Subject: `feat: Enhance contact information handling and improve schema markup in resume layouts`
- **Verification Method & Passing Results:**
  - Validated Liquid template parsing in `_layouts/resume-ar.html` and `_layouts/resume-en.html`.
  - Verified rendered HTML contains `tel:{{ site.contact_info.phone | remove: ... }}` in non-live mode.
  - Verified presence of `https://schema.org/Person` and `<meta itemprop="telephone">`.
  - Verified gem packaging passes cleanly via `gem build bilingual-jekyll-resume-theme.gemspec`.

---

### 3.2 P0.2: Fix Invalid Duplicate `else` in Liquid Conditional

- **Historical Context & Origin:** Static syntax audit of Liquid logic in `_includes/analytics-body.html`.
- **Problem Statement & Root Cause:**
  `_includes/analytics-body.html` contained two separate `{%- else -%}` tags inside the same outer `{%- if site.analytics.gtm -%}` conditional block:
  ```liquid
  {%- if site.analytics.gtm -%}
      <!-- GTM noscript -->
  {%- else -%}
      {%- if site.analytics.ga -%} ... {%- endif -%}
  {%- else -%}
      <!-- No Analytics Added -->
  {%- endif -%}
  ```
  The Liquid specification allows only a single `else` tag per conditional block. Multiple `else` statements constitute invalid Liquid syntax, resulting in silent drops, skipped rendering, or parser warnings depending on the Jekyll/Liquid gem version.
- **Technical Remediation & Implementation Details:**
  Refactored `_includes/analytics-body.html` to eliminate dead and redundant branches. Because Google Analytics (`gtag.js`) does not use an iframe fallback in `<body>` (only GTM requires a noscript iframe directly inside `<body>`), the template was streamlined to emit the noscript iframe strictly when `site.analytics.gtm` is defined:
  ```liquid
  {%- if site.analytics.gtm -%}
      <!-- Google Tag Manager (noscript) -->
      <noscript>
          <iframe src="https://www.googletagmanager.com/ns.html?id={{ site.analytics.gtm }}"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe>
      </noscript>
      <!-- End Google Tag Manager (noscript) -->
  {%- endif -%}
  ```
- **Exact Target Files Modified:**
  - `_includes/analytics-body.html` (16 lines of invalid nested Liquid removed)
- **Git Commit SHA & Evidence:**
  - Full SHA: `54f5c9676766c2ee04cd44a9b64b1a3472ca4d70`
  - Short SHA: `54f5c96`
  - Commit Date: 2026-09-12 02:18:29 +0300
  - Commit Subject: `feat: Integrate Google Tag Manager analytics snippet into resume layouts`
- **Verification Method & Passing Results:**
  - Verified Liquid parser validity: zero parser errors or syntax warnings.
  - Verified conditional logic: when `site.analytics.gtm` is configured, valid `<noscript><iframe ...>` is emitted; when absent, no markup is output.

---

### 3.3 P0.3: Fix GA4 / Gtag Parameter Mismatch

- **Historical Context & Origin:** Analytics configuration audit in `_includes/analytics-head.html`.
- **Problem Statement & Root Cause:**
  `_includes/analytics-head.html` gated Google Analytics execution with `{%- if site.analytics.ga -%}`, but inside the script injected `{{ site.analytics.gtag }}` (`?id={{ site.analytics.gtag }}`). If a user followed modern Google Analytics 4 (GA4) guidance and configured `analytics.gtag: "G-XXXXXXXXXX"` without defining `analytics.ga`, the condition evaluated to `false` and GA never loaded. Conversely, if a user configured `analytics.ga: "UA-XXXX"` without `gtag`, `site.analytics.gtag` was empty, generating broken script requests (`?id=`).
- **Technical Remediation & Implementation Details:**
  Implemented robust dynamic parameter resolution supporting modern GA4 measurement IDs while maintaining backward compatibility:
  ```liquid
  {%- else -%}
      {%- assign ga_id = site.analytics.gtag | default: site.analytics.ga -%}
      {%- if ga_id and ga_id != true -%}
          <!-- Global site tag (gtag.js) - Google Analytics -->
          <script async src="https://www.googletagmanager.com/gtag/js?id={{ ga_id }}"></script>
          <script>
              window.dataLayer = window.dataLayer || [];
              function gtag() { dataLayer.push(arguments); }
              gtag('js', new Date());
              gtag('config', '{{ ga_id }}');
          </script>
      {%- endif -%}
  {%- endif -%}
  ```
  Added safeguards against boolean `ga: true` values, and synchronized documentation across `CONFIG_GUIDE.md`, `INCLUDES_GUIDE.md`, and sample configuration files.
- **Exact Target Files Modified:**
  - `_includes/analytics-head.html`
  - `docs/CONFIG_GUIDE.md`
  - `docs/INCLUDES_GUIDE.md`
  - `docs/_data/_config.sample.yml`
- **Git Commit SHA & Evidence:**
  - Full SHA: `dff8c3d3ce3bfebf2ebb37d3ada348ed1a603f3c`
  - Short SHA: `dff8c3d`
  - Commit Date: 2026-09-12 02:23:43 +0300
  - Commit Subject: `feat: Update analytics configuration to support direct measurement ID for Google Analytics 4`
- **Verification Method & Passing Results:**
  - Tested with `analytics.gtag: "G-XXXXXXXXXX"`: correctly outputs GA4 gtag script tag.
  - Tested with `analytics.ga: "UA-XXXXXXXX-X"`: correctly resolves legacy Universal Analytics ID.
  - Tested with `analytics.ga: true`: correctly ignores boolean, preventing malformed URL injection.

---

### 3.4 P0.4: Add Missing GTM Body Noscript to Resume Layouts

- **Historical Context & Origin:** Analytics integration review across layouts.
- **Problem Statement & Root Cause:**
  Google Tag Manager specification requires an iframe fallback immediately after the opening `<body>` tag. While `_layouts/default.html` included `analytics-body.html`, neither `_layouts/resume-en.html` nor `_layouts/resume-ar.html` included it. Because resume layouts are the core user-facing presentation templates of the theme, visitors with JavaScript disabled or ad-blockers could not be tracked, and GTM verification checks failed.
- **Technical Remediation & Implementation Details:**
  Injected `{% include analytics-body.html %}` immediately following `<body class="...">` in both `_layouts/resume-en.html` and `_layouts/resume-ar.html`.
- **Exact Target Files Modified:**
  - `_layouts/resume-ar.html`
  - `_layouts/resume-en.html`
- **Git Commit SHA & Evidence:**
  - Full SHA: `54f5c9676766c2ee04cd44a9b64b1a3472ca4d70`
  - Short SHA: `54f5c96`
  - Commit Date: 2026-09-12 02:18:29 +0300
  - Commit Subject: `feat: Integrate Google Tag Manager analytics snippet into resume layouts`
- **Verification Method & Passing Results:**
  - Verified presence of `{% include analytics-body.html %}` immediately following the `<body>` element in `_layouts/resume-en.html` and `_layouts/resume-ar.html`.
  - Confirmed consistent GTM body noscript injection across all layouts.

---

### 3.5 P0.5: Quote Unquoted `href` & Add RTL `dir="ltr"` Text Isolation

- **Historical Context & Origin:** Static HTML / Liquid syntax audit and Arabic typography inspection.
- **Problem Statement & Root Cause:**
  In `_includes/resume-section-en.html` (Line 361) and `_includes/resume-section-ar.html` (Line 362), link attributes were unquoted: `<a href={{ link.url }} target="_blank">`. If `link.url` contained URL query strings, ampersands, or entity characters, browser HTML parsers truncated the URL at the first whitespace or delimiter. Unquoted attributes also presented potential XSS injection vulnerabilities. Furthermore, in the Arabic layout, printed raw URLs lacked bidirectional text isolation, causing periods, slashes, and hyphens to jump across RTL boundaries.
- **Technical Remediation & Implementation Details:**
  1. Enclosed all `href` attributes in standard double quotes: `<a href="{{ link.url }}" target="_blank" rel="noopener nofollow noreferrer" itemprop="url">{{ link.description }}</a>`.
  2. Wrapped print-only inline URL elements across Arabic resume sections (certifications, courses, projects, associations, links) in `<span class="print-only-inline" dir="ltr">&nbsp;{{ item.url }}</span>`.
- **Exact Target Files Modified:**
  - `_includes/resume-section-ar.html`
  - `_includes/resume-section-en.html`
- **Git Commit SHA & Evidence:**
  - Full SHA: `73da0959f2de2b7a6585d2c1c03fc59a4fa55f65`
  - Short SHA: `73da095`
  - Commit Date: 2026-09-12 02:31:22 +0300
  - Commit Subject: `fix: Add 'dir="ltr"' attribute to URLs for better text direction handling in resume sections`
- **Verification Method & Passing Results:**
  - Checked HTML output: confirmed strictly quoted attributes: `href="{{ link.url }}"`.
  - Verified `dir="ltr"` on `.print-only-inline` spans in `_includes/resume-section-ar.html`.
  - Confirmed bidi stability on printed URLs with punctuation characters.

---

### 3.6 P0.6: Fix Relative 404 Favicon Path in Subdirectories & Baseurl Deployments

- **Historical Context & Origin:** Asset link audit in `_includes/shared-head.html`.
- **Problem Statement & Root Cause:**
  Favicons were linked using bare relative paths: `<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">`. When visiting localized subdirectories (e.g. `/resume/en/`, `/resume/ar/`) or hosting on GitHub Pages with a repository base URL (e.g. `user.github.io/repo/`), browsers requested `/resume/en/favicon.ico`, resulting in 404 HTTP errors. In addition, `resume-head-en.html` and `resume-head-ar.html` contained redundant, incomplete favicon tags.
- **Technical Remediation & Implementation Details:**
  1. Consolidated a modern favicon suite into `_includes/shared-head.html` passed through Jekyll's `relative_url` filter:
     - Standard shortcut icon and icon (`site.favicon | default: 'assets/favicon/resume/favicon.ico' | relative_url`)
     - Apple touch icon (`site.apple_touch_icon | default: 'assets/favicon/resume/apple-touch-icon.png' | relative_url`)
     - High-resolution 32x32 and 16x16 PNG icons (`favicon_32`, `favicon_16`)
     - Web application manifest (`assets/favicon/resume/site.webmanifest | relative_url`)
  2. Removed conflicting duplicate favicon tags from `_includes/resume-head-en.html` and `_includes/resume-head-ar.html`.
  3. Documented configuration variables in `docs/CONFIG_GUIDE.md` and `docs/INCLUDES_GUIDE.md`.
- **Exact Target Files Modified:**
  - `_includes/shared-head.html`
  - `_includes/resume-head-ar.html`
  - `_includes/resume-head-en.html`
  - `docs/CONFIG_GUIDE.md`
  - `docs/INCLUDES_GUIDE.md`
  - `docs/_data/_config.sample.yml`
- **Git Commit SHA & Evidence:**
  - Full SHA: `943d5653d5cbfa5f6189b4975a74f2e981c6ceb1`
  - Short SHA: `943d565`
  - Commit Date: 2026-09-12 02:39:05 +0300
  - Commit Subject: `fix(favicons): centralize modern favicon suite and resolve subdirectory 404s`
- **Verification Method & Passing Results:**
  - Verified `_includes/shared-head.html`: confirmed `relative_url` filter applied to all favicon paths.
  - Verified removal of redundant favicon declarations from `resume-head-*.html`.
  - Zero 404 favicon requests when accessing subpaths or baseurl deployments.

---

### 3.7 P0.7: Remove Conflicting Duplicate Canonical Tags

- **Historical Context & Origin:** SEO audit of HTML `<head>` tags in `_includes/shared-head.html`.
- **Problem Statement & Root Cause:**
  `_includes/shared-head.html` manually emitted `<link rel="canonical" href="...">`, while all parent layouts (`default.html`, `resume-en.html`, `resume-ar.html`) simultaneously invoked `{% seo %}` (`jekyll-seo-tag`), which outputs its own canonical tag. Search engine crawlers encountering multiple contradictory or duplicate canonical tags may penalize page authority or ignore canonicalization directives entirely.
- **Technical Remediation & Implementation Details:**
  Removed the manual `<link rel="canonical">` element from `_includes/shared-head.html`. Canonical URL generation is now cleanly and uniformly delegated to `jekyll-seo-tag`. Updated `docs/INCLUDES_GUIDE.md` to document this behavior.
- **Exact Target Files Modified:**
  - `_includes/shared-head.html`
  - `docs/INCLUDES_GUIDE.md`
- **Git Commit SHA & Evidence:**
  - Full SHA: `8f8b22bfdea4e40371366db47bdddd98d412631a`
  - Short SHA: `8f8b22b`
  - Commit Date: 2026-09-12 02:43:51 +0300
  - Commit Subject: `fix(seo): remove conflicting duplicate canonical tag from shared head`
- **Verification Method & Passing Results:**
  - Verified `_includes/shared-head.html` contains no manual `<link rel="canonical">`.
  - Confirmed canonical URL is rendered exactly once per page via `jekyll-seo-tag`.

---

### 3.8 P0.8: Fix Arabic Cairo Font Loading for Custom Themes

- **Historical Context & Origin:** Arabic typography and theme engine audit of `_includes/resume-head-ar.html`.
- **Problem Statement & Root Cause:**
  Arabic Google Font fetching was coupled to the default theme name via `{% if site.resume_theme == 'default' %}`. If a user specified any other theme name, configured a custom color palette, or omitted `resume_theme`, Cairo was never fetched, resulting in unstyled system fallback typography for Arabic text.
- **Technical Remediation & Implementation Details:**
  1. Implemented multi-tier font loading:
     - Supports self-hosted or custom CDN stylesheets via `site.font_ar_url`.
     - Fetches Google Fonts Cairo by default across all themes, unless `site.disable_google_fonts: true` or `site.resume_theme == 'no-custom-fonts'`.
     - Added preconnect performance hints (`fonts.googleapis.com` and `fonts.gstatic.com` with `crossorigin`).
     - Added `display=swap` for improved Core Web Vitals and zero layout shift.
  2. Documented configuration flags in `docs/CONFIG_GUIDE.md`.
- **Exact Target Files Modified:**
  - `_includes/resume-head-ar.html`
  - `docs/CONFIG_GUIDE.md`
- **Git Commit SHA & Evidence:**
  - Full SHA: `ca6898b883a5264dbee9088c849bfd6a00fdf079`
  - Short SHA: `ca6898b`
  - Commit Date: 2026-09-12 12:54:03 +0300
  - Commit Subject: `fix(typography,i18n): upgrade Arabic font loading and isolate print social links`
- **Verification Method & Passing Results:**
  - Tested with `resume_theme: "modern-blue"`, `resume_theme: "default"`, and `resume_theme: nil`: Cairo font stylesheet is loaded across all themes.
  - Tested with `font_ar_url: "https://example.com/custom.css"`: loads custom font URL.
  - Tested with `disable_google_fonts: true`: suppresses Google Fonts requests.

---

### 3.9 P0.9: Scope Global `svg` Selector to Prevent Icon Distortion

- **Historical Context & Origin:** CSS inspection of `_sass/_all-pages.scss` and `_sass/_dark-mode.scss`.
- **Problem Statement & Root Cause:**
  `_sass/_all-pages.scss` declared unscoped element selectors:
  ```scss
  .svg-icon, svg { fill: var(--icon-fill-muted, #BBB); width: 30px; }
  ```
  This applied blanket fills and fixed widths to *all* SVGs across the DOM, including inline icons inside the dark mode toggle button, causing dimensions, stroke rendering, and animations to be corrupted.
- **Technical Remediation & Implementation Details:**
  1. Scoped CSS selectors in `_sass/_all-pages.scss` strictly to intended containers: `.svg-icon, .icon-link svg, .social-links svg, .page-footer svg`.
  2. Added defensive CSS override in `_sass/_dark-mode.scss`: `.dark-mode-icon { fill: none !important; stroke: currentColor; }`.
- **Exact Target Files Modified:**
  - `_sass/_all-pages.scss`
  - `_sass/_dark-mode.scss`
- **Git Commit SHA & Evidence:**
  - Full SHA: `d44dcb15360ddd3c6e5eb42bc973564f882ee177`
  - Short SHA: `d44dcb1`
  - Commit Date: 2026-09-12 13:06:58 +0300
  - Commit Subject: `fix: scope global svg rules and add WCAG 2.1 AA accessible social links`
- **Verification Method & Passing Results:**
  - Verified CSS scoping in `_sass/_all-pages.scss`.
  - Verified dark mode toggle icon renders cleanly with `fill: none` and `stroke: currentColor`.

---

### 3.10 P0.10: WCAG 2.1 AA Accessible Labels on Social Links

- **Historical Context & Origin:** Accessibility audit and GitHub Issue [#21](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/21).
- **Problem Statement & Root Cause:**
  All 14 social link anchors in `_includes/social-links.html` were empty anchors containing only raw SVG code without visible text or accessible attributes. Screen readers announced them as "unlabeled link", violating WCAG 2.1 Success Criteria 4.1.2 (Name, Role, Value) and 2.4.4 (Link Purpose).
- **Technical Remediation & Implementation Details:**
  1. Injected multi-layer accessibility across all 14 social platforms in `_includes/social-links.html`:
     - Explicit `aria-label="Platform Name"` on `<a>`
     - Tooltip `title="Platform Name"` on `<a>`
     - Visually-hidden inner span `<span class="sr-only">Platform Name</span>` for maximum screen reader compatibility.
  2. Added `aria-hidden="true" focusable="false"` to all 14 SVG vector icons in `_includes/vendors/lineicons-v5.0/` so assistive technologies ignore raw SVG vectors.
  3. Added standard `.sr-only` utility CSS class in `_sass/_base.scss`.
- **Exact Target Files Modified:**
  - `_includes/social-links.html`
  - `_sass/_base.scss`
  - 14 SVG files in `_includes/vendors/lineicons-v5.0/` (`dev.svg`, `dribbble-symbol.svg`, `facebook.svg`, `flickr.svg`, `github.svg`, `globe-1.svg`, `instagram.svg`, `linkedin.svg`, `medium-alt.svg`, `pinterest.svg`, `telegram.svg`, `whatsapp.svg`, `x.svg`, `youtube.svg`)
- **Git Commit SHA & Evidence:**
  - Full SHA: `d44dcb15360ddd3c6e5eb42bc973564f882ee177`
  - Short SHA: `d44dcb1`
  - Commit Date: 2026-09-12 13:06:58 +0300
  - Commit Subject: `fix: scope global svg rules and add WCAG 2.1 AA accessible social links`
  - GitHub Issue: Closed [#21](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/21)
- **Verification Method & Passing Results:**
  - Verified `.sr-only` CSS definition in `_sass/_base.scss`.
  - Verified all 14 social platform links have `aria-label`, `title`, and `<span class="sr-only">`.
  - Verified all 14 vendor SVGs have `aria-hidden="true" focusable="false"`.

---

### 3.11 P0.11: Fix Arabic Print Social Links Bidi Scrambling

- **Historical Context & Origin:** Print stylesheet testing of `_includes/print-social-links.html`.
- **Problem Statement & Root Cause:**
  When printing or exporting the Arabic resume to PDF, `_includes/print-social-links.html` rendered English platform names and raw LTR URLs within an RTL document context without text direction isolation. Punctuation marks (slashes, hyphens, colons, dots) were scrambled and mirrored in the output.
- **Technical Remediation & Implementation Details:**
  1. Added language detection logic in `_includes/print-social-links.html` checking `page.layout`, `page.lang`, `page.language`, and `layout.lang`.
  2. Wrapped every rendered URL in `<span dir="ltr">` for bidirectional isolation.
  3. Added bilingual Arabic platform labels when `is_ar` is true (e.g. `جيت هاب (GitHub)`, `لينكد إن (LinkedIn)`, `إكس / تويتر (X / Twitter)`, `الموقع الشخصي (Website)`).
- **Exact Target Files Modified:**
  - `_includes/print-social-links.html`
- **Git Commit SHA & Evidence:**
  - Full SHA: `ca6898b883a5264dbee9088c849bfd6a00fdf079`
  - Short SHA: `ca6898b`
  - Commit Date: 2026-09-12 12:54:03 +0300
  - Commit Subject: `fix(typography,i18n): upgrade Arabic font loading and isolate print social links`
- **Verification Method & Passing Results:**
  - Verified `is_ar` conditional and `<span dir="ltr">` wrapping in `_includes/print-social-links.html`.
  - Print rendering verified: URLs and punctuation remain strictly LTR formatted in printed Arabic resumes.

---

### 3.12 P0.12: Documentation & Metadata Version Alignment

- **Historical Context & Origin:** Release engineering and repository governance audit.
- **Problem Statement & Root Cause:**
  Version declarations had drifted between `0.5.2`, `0.6.0`, and `0.6.1` across documentation, security policies, and AI coding instructions, creating confusion for gem consumers and automated workflows.
- **Technical Remediation & Implementation Details:**
  1. Unified release version to `0.7.0` in `bilingual-jekyll-resume-theme.gemspec`.
  2. Updated `SECURITY.md` supported version matrix to cover `0.7.x` and `0.6.x`.
  3. Synchronized AI instructions in `CLAUDE.md`, updated `README.md` with features (dark mode, modern favicon suite, WCAG accessibility), and compiled release notes in `CHANGELOG.md`.
  4. Updated documentation guides in `docs/`.
- **Exact Target Files Modified:**
  - `bilingual-jekyll-resume-theme.gemspec`
  - `SECURITY.md`
  - `CLAUDE.md`
  - `README.md`
  - `CHANGELOG.md`
  - `docs/DATA_GUIDE.md`
- **Git Commit SHAs & Evidence:**
  - Commit 1: `967e0f01fabab1595bcfeb7ba4d4fa44fc672ef0` (`chore(release): bump version to 0.7.0`)
  - Commit 2: `8284ee7c0ffe351b823ad8ea0854b8e6d6afecd5` (`feat(docs): enhance README and DATA_GUIDE with dark mode, typography, and error page details`)
  - Tag: `v0.7.0`
- **Verification Method & Passing Results:**
  - Ran `gem build bilingual-jekyll-resume-theme.gemspec`: successfully built `bilingual-jekyll-resume-theme-0.7.0.gem`.
  - Verified consistent `0.7.0` version strings across all documentation.

---

### 3.13 P0.13: Make `description` Optional in `skills.yml`

- **Historical Context & Origin:** GitHub Issue [#2](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/2).
- **Problem Statement & Root Cause:**
  In early releases, omitting the `description` key from an entry in `skills.yml` caused templates to unconditionally render empty `<p class="resume-item-copy"></p>` elements, creating unwanted vertical white space and breaking compact skill badge presentations.
- **Technical Remediation & Implementation Details:**
  Wrapped `<p class="resume-item-copy">{{ skill.description }}</p>` in `{% if skill.description %}` conditional guards in both `_includes/resume-section-en.html` and `_includes/resume-section-ar.html`.
- **Exact Target Files Modified:**
  - `_includes/resume-section-ar.html`
  - `_includes/resume-section-en.html`
- **Git Commit SHA & Evidence:**
  - Full SHA: `601dbf9d81a621366d3a0e46f7079da42aa73e75`
  - Short SHA: `601dbf9`
  - Commit Date: 2025-11-05 08:06:24 +0000
  - Commit Subject: `feat(skills): make description optional in skills.yml`
  - GitHub Issue: Closed [#2](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/2)
- **Verification Method & Passing Results:**
  - Confirmed `{% if skill.description %}` guard in both section templates.
  - Tested skill entries without `description`: renders cleanly without empty `<p>` tags.

---

### 3.14 P0.14: Make `summary` Optional in `recognitions.yml`

- **Historical Context & Origin:** GitHub Issue [#3](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/3).
- **Problem Statement & Root Cause:**
  Recognition and award entries required a `summary` field in data files. When omitted, templates emitted empty description tags.
- **Technical Remediation & Implementation Details:**
  Enclosed summary output in guarded `{% if recognition.summary %}` blocks in both English and Arabic resume section templates.
- **Exact Target Files Modified:**
  - `_includes/resume-section-ar.html`
  - `_includes/resume-section-en.html`
- **Git Commit SHA & Evidence:**
  - Full SHA: `34b46613dc561a3d1868fdf8d64f7cfd80e02e5d`
  - Short SHA: `34b4661`
  - Commit Date: 2025-11-05 08:30:02 +0000
  - Commit Subject: `feat(recognition): make summary optional in recognition.yml`
  - GitHub Issue: Closed [#3](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/3)
- **Verification Method & Passing Results:**
  - Confirmed `{% if recognition.summary %}` guard in both section templates.
  - Tested recognition entries without `summary`: renders without empty description tags.

---

### 3.15 P0.15: Make `summary` Optional in `Associations.yml`

- **Historical Context & Origin:** GitHub Issue [#4](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/4).
- **Problem Statement & Root Cause:**
  Professional association entries frequently require only the organization name, role, and dates. Forcing a mandatory `summary` field required users to provide placeholder strings.
- **Technical Remediation & Implementation Details:**
  Enclosed association summary rendering in `{% if item.summary %}` blocks in both English and Arabic resume section templates.
- **Exact Target Files Modified:**
  - `_includes/resume-section-ar.html`
  - `_includes/resume-section-en.html`
- **Git Commit SHA & Evidence:**
  - Full SHA: `a12cdc8b9d64db5c3368db6dc270c03a4f353538`
  - Short SHA: `a12cdc8`
  - Commit Date: 2025-11-05 08:34:07 +0000
  - Commit Subject: `feat(association): make summary optional in association.yml`
  - GitHub Issue: Closed [#4](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/4)
- **Verification Method & Passing Results:**
  - Confirmed `{% if item.summary %}` guard in both section templates.
  - Tested association entries without `summary`: renders cleanly with organization and role only.

---

### 3.16 P0.16: Move Resume Header Intro from Config to Data File

- **Historical Context & Origin:** GitHub Issue [#5](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/5).
- **Problem Statement & Root Cause:**
  Storing candidate intro/bio text in `_config.yml` under `resume_header_intro` prevented language-specific bios for bilingual resumes and required full Jekyll server reboots for simple bio text edits.
- **Technical Remediation & Implementation Details:**
  1. Migrated bio content to `_data/en/header.yml` and `_data/ar/header.yml` under the `intro:` key.
  2. Added independent language visibility toggle flags: `resume_header_intro_en` and `resume_header_intro_ar`.
  3. Maintained backward compatibility fallback to `site.resume_header_intro`:
     `resume_data.header.intro | default: site.resume_header_intro`.
- **Exact Target Files Modified:**
  - `_layouts/resume-ar.html`
  - `_layouts/resume-en.html`
  - `_data/en/header.yml`
  - `_data/ar/header.yml`
  - `docs/_config.sample.yml`
- **Git Commit SHA & Evidence:**
  - Full SHA: `d026de92817b3de76843e18b8770c20136ae0691`
  - Short SHA: `d026de9`
  - Commit Date: 2025-11-05 09:47:53 +0000
  - Commit Subject: `refactor(intro): move intro text from _config to data file`
  - GitHub Issue: Closed [#5](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/5)
- **Verification Method & Passing Results:**
  - Verified independent Arabic and English bio rendering from `_data/ar/header.yml` and `_data/en/header.yml`.
  - Verified backward compatibility with `site.resume_header_intro`.

---

## 4. Exhaustive Technical Records: Priority 1 & 2 Completed Features (P1.4 & P2.4)

### 4.1 P1.4: Configurable Avatar Image URL, Bilingual Alt Text & Accessible Link Mode

- **Historical Context & Origin:** Personalization and accessibility audit of avatar rendering in resume layouts.
- **Problem Statement & Root Cause:**
  Avatar image markup was hardcoded directly into `_layouts/resume-en.html` and `_layouts/resume-ar.html` with fixed path `/assets/images/Profile-min.jpg`, hardcoded non-descriptive alt text (`"my photo"` / `"صورتي"`), and hardcoded `target="_blank"` link to `/` (violating WCAG standards for in-site navigation). Users could not specify custom image paths, external CDN URLs, customize alt text, or disable link wrapping.
- **Technical Remediation & Implementation Details:**
  1. Created modular component `_includes/avatar.html`:
     - Safely resolves local assets with `relative_url` and passes external HTTP/HTTPS CDN URLs unmodified:
       ```liquid
       {% assign avatar_raw = site.avatar_url | default: site.avatar | default: '/assets/images/Profile-min.jpg' %}
       {% if avatar_raw contains "://" %}
         {% assign avatar_src = avatar_raw %}
       {% else %}
         {% assign avatar_src = avatar_raw | relative_url %}
       {% endif %}
       ```
     - Establishes a bilingual alt text fallback hierarchy:
       - English: `site.avatar_alt_en` → `site.avatar_alt` → candidate full name → `"Profile photo"`
       - Arabic: `site.avatar_alt_ar` → `site.avatar_alt` → candidate full name → `"الصورة الشخصية"`
     - Accessible link wrapping: defaults to `target="_self"` for WCAG compliance, configurable destination via `site.avatar_link`, or unlinked image rendering via `site.avatar_link: false`.
     - Preserves Schema.org `itemprop="image"` microdata and `no-print` print suppression.
  2. Refactored `resume-en.html` and `resume-ar.html` to invoke `{% include avatar.html lang="en" %}` / `{% include avatar.html lang="ar" %}`.
  3. Documented configuration options in `docs/CONFIG_GUIDE.md` and `docs/INCLUDES_GUIDE.md`.
- **Exact Target Files Modified / Created:**
  - `_includes/avatar.html` (Created)
  - `_layouts/resume-ar.html` (Modified)
  - `_layouts/resume-en.html` (Modified)
  - `docs/CONFIG_GUIDE.md` (Modified)
  - `docs/INCLUDES_GUIDE.md` (Modified)
- **Git Commit SHA & Evidence:**
  - Full SHA: `a17cc603a3633bb5dc67589bcc01ce7ef886d88c`
  - Short SHA: `a17cc60`
  - Commit Date: 2026-09-12 14:18:55 +0300
  - Commit Subject: `feat(avatar): add configurable avatar URL, bilingual alt text, and reusable include`
- **Verification Method & Passing Results:**
  - Tested local path: `avatar_url: "/assets/images/custom.jpg"` resolves correctly with `relative_url`.
  - Tested external CDN: `avatar_url: "https://images.unsplash.com/photo-..."` passes unchanged.
  - Tested alt text fallback chain: emits candidate name when alt is unset; emits custom alt when set.
  - Tested `avatar_link: false`: outputs unlinked `<img>` tag.
  - Tested default link: renders `target="_self"` with proper title.

---

### 4.2 P2.4: Site-Wide Dark Mode & Bilingual HTTP Error Suite (404, 403, 500)

- **Historical Context & Origin:** GitHub Issue [#8](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/8) and error handling audit.
- **Problem Statement & Root Cause:**
  1. The dark mode toggle was confined strictly to resume layouts (`resume-en.html`, `resume-ar.html`). Visiting default markdown pages, profile landing pages, or error pages presented a light-only interface, jarring users in low-light environments.
  2. Profile layout card-centering styles leaked onto generic markdown pages using the default layout.
  3. Error pages were rudimentary, unstyled, and lacked bilingual Arabic/English copy, navigation return paths, and dark mode adaptation.
- **Technical Remediation & Implementation Details:**
  1. Injected `{% include dark-mode-toggle.html %}` into `_layouts/default.html` under the `dark-mode` condition, establishing universal dark mode across profile, custom markdown, and error pages.
  2. Standardized configuration across all layouts: supports `site.dark_mode: enabled/true`, legacy `site.resume_dark_mode: enabled/true`, and front-matter override `page.dark_mode: true/false`.
  3. Added synchronous anti-FOUC script in `_includes/shared-head.html` before stylesheets render, ensuring zero flash of unstyled content on reload.
  4. Scoped profile centering styles to `.profile-container` and `body.layout-profile` in `_sass/_profile.scss`.
  5. Implemented comprehensive dark-mode-aware typography rules in `_sass/_all-pages.scss` for headings, paragraphs, lists, code, tables, and blockquotes inside `.main-content`.
  6. Shipped a complete bilingual HTTP error suite:
     - Reusable `_layouts/error.html` with universal dark mode support.
     - Centralized `_data/error_pages.yml` with side-by-side English and Arabic copy for 404, 403, 500, and 503 status codes.
     - Dedicated standalone error pages: `404.html`, `403.html`, and `500.html`.
     - Accessible navigation return links (Home, Resume EN, Resume AR) and an interactive reload button (`window.location.reload()`) for server errors (`500`, `503`).
- **Exact Target Files Modified / Created:**
  - `_layouts/default.html` (Modified)
  - `_layouts/error.html` (Created)
  - `_layouts/profile.html` (Modified)
  - `_layouts/resume-en.html` (Modified)
  - `_layouts/resume-ar.html` (Modified)
  - `_data/error_pages.yml` (Created)
  - `404.html` (Created)
  - `403.html` (Created)
  - `500.html` (Created)
  - `_sass/_all-pages.scss` (Modified)
  - `_sass/_profile.scss` (Modified)
  - `_sass/_dark-mode.scss` (Modified)
  - `bilingual-jekyll-resume-theme.gemspec` (Modified)
  - `docs/CONFIG_GUIDE.md` (Modified)
  - `docs/LAYOUTS_GUIDE.md` (Modified)
  - `docs/DATA_GUIDE.md` (Modified)
  - `README.md` (Modified)
- **Git Commit SHAs & Evidence:**
  - Commit 1: `853a9ac1eaf11aadec62f198f6b7e9cdb2d3c209` (`feat(dark-mode): implement universal dark mode and isolate profile layout styles`)
  - Commit 2: `4eab127d8cc3a4cedccca89943482fd3a067ee14` (`feat(error-pages): add bilingual error suite (404, 403, 500) and reusable layout`)
  - Commit 3: `2dcb813` (`feat: Add dark mode toggle with system preference detection`)
  - Commit 4: `8284ee7c0ffe351b823ad8ea0854b8e6d6afecd5` (`feat(docs): enhance README and DATA_GUIDE with dark mode, typography, and error page details`)
  - GitHub Issue: Closed [#8](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/8) via PR [#24](https://github.com/kmutahar/bilingual-jekyll-resume-theme/pull/24)
- **Verification Method & Passing Results:**
  - Verified `404.html`, `403.html`, and `500.html` render via `_layouts/error.html`.
  - Verified bilingual English/Arabic strings loaded from `_data/error_pages.yml`.
  - Verified reload button displays on 500/503 errors and triggers `window.location.reload()`.
  - Verified dark mode toggle operates on default, profile, and error layouts with localStorage persistence and anti-FOUC script.
  - Verified profile layout styles are strictly scoped to `.profile-container` and `body.layout-profile`.

---

## 5. v1.0.0 Delivered Features (1.7, 2.8, 3.2, 3.3, 4.1, 4.6)

The v1.0.0 multilingual release was executed on branch `feature/extended-multilingual-v1.0.0` from an implementation plan that has since been retired; this section, [`../CHANGELOG.md`](../CHANGELOG.md), and [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md) are its permanent record. v1.0.0 is a hard break with no compatibility aliases; the full removed-to-replacement table is in [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md#breaking-changes--migration-v090-to-v100). All deliverables, including the CI/CD pipeline (#206) and the validator (#13), are verified live and permanently archived here.

### 5.1 Feature 1.7: Native Email Support in Social Links Include (#215)

- **Problem:** `social_links` had no `email` key; an email link needed a hand-edited include.
- **Delivered:** `site.social_links.email` renders an envelope icon linking to `mailto:` with `itemprop="email"`, `aria-label`, `title`, and a `.sr-only` label in `_includes/social-links.html`, plus an email line in `_includes/print-social-links.html`.
- **Commit:** `d53e53ca14df4fe48581dfb73e33933b9ba57792` (`feat(social): add native email support to social links (Closes #215)`).

### 5.2 Feature 2.8: Header Contact Icon and Text Alignment in Arabic Layout (#217)

- **Problem:** In `_layouts/resume-ar.html`, header contact items rendered text before icon, unlike the English layout.
- **Delivered:** Each contact item leads with its icon, then the link or text, with `dir="ltr"` kept on phone numbers and emails. The unified `_layouts/resume.html` carries the icon-first markup for every direction.
- **Commit:** `315356972b326d9fcd5ff58e0208da9a2140116f` (`feat(a11y): align Arabic header contact icons icon-first (Closes #217)`).

### 5.3 Feature 4.1: Extended Multilingual Support (#15)

- **Problem:** Separate `resume-en` / `resume-ar` layouts, section dispatchers, and head includes duplicated about 1,100 lines of Liquid; `*_en` / `*_ar` config keys and hardcoded strings made a third language require a fork.
- **Delivered:**
  1. Six locale dictionaries, `_data/locales/{en,ar,es,fr,de,ur}.yml`, with identical key sets: `direction`, `font_family`, `font_url`, `line_height`, `ui.*`, `error_pages`, `present_values`, `months`. `_data/ar/months.yml` and `_data/error_pages.yml` were folded in and deleted. Sites override keys through their own `_data/locales/` (Jekyll deep merge) or add languages with a complete file.
  2. Stylesheets split by direction: `_sass/_resume.scss` became `_sass/_resume-ltr.scss` (main, reading `--font-locale` / `--line-height-locale`); `_sass/_resume-rtl.scss` lost its font rules and became language-neutral; entrypoints `assets/css/cv-ltr.scss` / `cv-rtl.scss` replaced `cv.scss` / `cv-ar.scss`.
  3. `_includes/date-formatter.html` replaced `_includes/ar-date.html`; `_includes/resume-section.html` replaced the two per-language dispatchers; `_layouts/resume.html` replaced `resume-en.html`, `resume-ar.html`, `resume-head-en.html`, and `resume-head-ar.html`.
  4. Every remaining consumer (`error.html`, `error_pages_generator.rb`, `default.html`, `profile.html`, `avatar.html`, `print-social-links.html`, `hreflang.html`, `language-switcher.html`, `dark-mode-toggle.html`, `data-loader.html`) reads the active locale and `site.languages`; no template branches on a language code.
  5. `languages.<lang>` config block and `default_lang` replaced every `*_en` / `*_ar` key.
  6. Sherlock Holmes demo resume in all six languages under `docs/_data/` and `docs/demo/`, rendered by the `docs/_data/_config.demo.yml` overlay.
- **Commits:** `54b40a4` (locales), `3e840a7` (stylesheets), `5058532` (date formatter), `c37df29` (section dispatcher), `da2cd74` (layout), `3f467fe` (consumers), `5188e96` (demo data).
- **Verification:** `bundle exec jekyll build --config docs/_data/_config.sample.yml,docs/_data/_config.demo.yml` renders `/en/cv/`, `/ar/cv/`, `/es/cv/`, `/fr/cv/`, `/de/cv/`, `/ur/cv/` with the correct `dir`, font, section titles, and month names; `./bin/validate-resume docs/_data` reports 0 errors and 0 warnings across all six languages.

### 5.4 Feature 4.6: Deprecation Retirement & Legacy Fallbacks Cleanup (#214)

- **Problem:** Three deprecated fallbacks were still live in templates, and two retired keys needed confirmation of removal.
- **Delivered:** Removed the `site.avatar` fallback from `_includes/avatar.html`, the `analytics.ga` Universal Analytics branch from `_includes/analytics-head.html`, and the singular `resume_section.recognition` fallback (dropped in `_includes/resume-section.html`). Confirmed `site.resume_dark_mode` and `site.resume_header_intro` have no remaining references.
- **Commit:** `2c88adf75c915cb682634ac0c98a2211caedb101` (`chore(cleanup): purge deprecated site.avatar, analytics.ga, and resume_dark_mode fallbacks`).

### 5.5 Feature 3.2: Automated CI/CD Build & Verification Pipeline (#206)

- **Problem:** Absence of automated continuous integration allowed invalid front-matter, broken YAML data, or gem specification packaging defects to reach consumers unnoticed.
- **Delivered:** Configured `.github/workflows/ci.yml` matrix testing across modern Ruby releases (3.3, 3.4, 4.0), strict Jekyll demo build, RuboCop, unit test execution, and gem packaging verification. Added `.github/workflows/lint.yml` and CI status badge to `README.md`.
- **Commit:** `3be935f` (carried in from `feature/resume-validator-ecosystem`, verified live on PR #220).

### 5.6 Feature 3.3: YAML Resume Data Validator & Schema Linter (#13)

- **Problem:** Non-technical user errors in YAML syntax (missing fields, wrong data types, malformed dates, cross-locale file asymmetries) resulted in cryptic Liquid build failures.
- **Delivered:** Standalone CLI tool `bin/validate-resume` and core engine `lib/bilingual-jekyll-resume-theme/resume_validator.rb` validating all 13 standard resume files, date formats, active flags, and multi-locale parity. Includes build-time Jekyll plugin `_plugins/resume_validator.rb`, Rake task `rake validate`, comprehensive guide `docs/VALIDATION_GUIDE.md`, and full Minitest suite `test/test_resume_validator.rb`.
- **Commit:** `3be935f` (carried in from `feature/resume-validator-ecosystem`, verified live on PR #220).

---

## 6. v1.0.1 Delivered Features (2.11, 2.12)

The v1.0.1 maintenance release addressed two visual widget improvements scoped together before v1.0.0. Both were verified against live LTR and RTL builds and merged directly into `master`.

### 6.1 Feature 2.11: Pin Language-Switcher/Dark-Mode-Toggle to Fixed Corners (#227)

- **Problem:** `.language-switcher` and `.dark-mode-toggle` previously swapped top-left/top-right corners based on `locale.direction`, with mirror rules duplicated across `_sass/_layout.scss`, `_sass/_dark-mode.scss`, and `_sass/_resume-rtl.scss`.
- **Delivered:** Pinned `.language-switcher` fixed to top-left and `.dark-mode-toggle` fixed to top-right across all locales (LTR and RTL), removing all three RTL override locations. Verified against live `ar/cv/` and `ur/cv/` builds at desktop and mobile widths confirming no collision with right-aligned Arabic header titles.
- **Commit:** `305408c8885c194ad71d88831179b287d4a10ec3` (`feat(layout): pin language-switcher/dark-mode-toggle to fixed corners (Closes #227)`).

### 6.2 Feature 2.12: Dropdown Language Switcher (#228)

- **Problem:** `_includes/language-switcher.html` rendered one button per configured language in a flat row, taking excessive horizontal space and wrapping across multiple rows on mobile screens as locales increased.
- **Delivered:** Replaced the button row with a semantic `<details>/<summary>` disclosure element wrapping a `<nav>` landmark of per-language links with zero new JavaScript. Preserves full no-JS graceful degradation, keyboard navigation (Tab, Enter/Space, Esc), and accessible screen-reader states.
- **Commit:** `f37c6f6b410f5de4841ed36115db60408c805293` (`feat(i18n): replace language-switcher button row with a dropdown (Closes #228)`).

---

## 7. Verification Protocols & Independent Audit Attestation

The following independent verification commands confirm the integrity of the codebase following the completion of all 18 remediation tasks:

### 7.1 RubyGem Packaging Verification
```bash
gem build bilingual-jekyll-resume-theme.gemspec
```
*Passing Result:* Successfully built RubyGem `bilingual-jekyll-resume-theme-0.7.0.gem` with zero packaging errors. All new files (`404.html`, `403.html`, `500.html`, `_layouts/error.html`, `_data/error_pages.yml`, `_includes/avatar.html`) are verified in the gem manifest.

### 7.2 Liquid Syntax & Template Tag Inspection
All modified templates (`_layouts/resume-ar.html`, `_layouts/resume-en.html`, `_layouts/default.html`, `_layouts/error.html`, `_includes/analytics-body.html`, `_includes/analytics-head.html`, `_includes/avatar.html`, `_includes/resume-section-*.html`, `_includes/shared-head.html`, `_includes/social-links.html`, `_includes/print-social-links.html`) contain valid, balanced Liquid tags and conform to Jekyll 3.9+ / 4.x standards.

### 7.3 WCAG 2.1 AA Accessibility Attestation
- All social links contain `aria-label`, `title`, and visually-hidden `<span class="sr-only">` text.
- All SVG icons contain `aria-hidden="true" focusable="false"`.
- Avatar image component includes bilingual fallback alt text, Schema.org `itemprop="image"`, and accessible link targets.

### 7.4 RTL & Bidirectional Text Isolation Attestation
- Arabic templates enforce `dir="rtl"` root direction with `<span dir="ltr">` isolation for telephone links, URLs, and printed social links.
- Arabic Google Font Cairo loads reliably across all themes and custom palettes with preconnect hints.

---

## 8. Closed Redundant Duplicate Issues Registry & Root Cause Analysis

### 8.1 Duplicate Creation Root Cause Analysis (RCA)

Between `2026-09-12T11:37:00Z` and `2026-09-12T12:10:49Z`, an automated script executed 13 successive batch sweeps across the repository issue tracker. In each cycle, a batch of 14 items was generated:
1. 11 remediation items corresponding to Phase 0 bug fixes (P0.1–P0.11): immediately closed upon creation.
2. 1 documentation item (P0.12): immediately closed upon creation.
3. 1 avatar feature item (P1.4 / #205): immediately closed upon creation.
4. 1 Social Media feature enhancement (P1.3): created and left OPEN.
5. 1 CI/CD pipeline feature enhancement (P3.2): created and left OPEN.

Because 13 successive batch runs were triggered, 13 identical copies of the Social Media feature and 13 identical copies of the CI/CD pipeline feature were generated with identical titles, labels, milestones, and initial descriptions at strict intervals of 14 issue numbers:
- **Social Media:** `#36`, `#50`, `#64`, `#78`, `#92`, `#106`, `#120`, `#134`, `#148`, `#162`, `#176`, `#190`, and `#204`.
- **CI/CD:** `#38`, `#52`, `#66`, `#80`, `#94`, `#108`, `#122`, `#136`, `#150`, `#164`, `#178`, `#192`, and `#206`.

The 13th batch produced `#204` and `#206`, which are designated as the **canonical active open issues** in [`/FEATURE_ROADMAP.md`](../FEATURE_ROADMAP.md). All preceding 24 issues were formally closed on GitHub using GitHub's native `state_reason: "duplicate"` linking to `#204` and `#206`, preceded by an explanatory cross-reference comment.

### 8.2 Social Media Platform Closed Duplicates

The duplicate issues share the title `"Expand Social Media Platforms (Mastodon, Discord, Bluesky, etc.)"`, labels `["enhancement", "phase-1"]`, and milestone `"Phase 1 (Quick Wins - 1-2 weeks)"`.

| Issue # | Title | Created (UTC) | Closed (UTC) | Status | Canonical Reference | Resolution Details |
|---|---|---|---|---|---|---|
| [#36](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/36) | Expand Social Media Platforms | 2026-09-12T11:38:25Z | 2026-09-12T14:04:23Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#50](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/50) | Expand Social Media Platforms | 2026-09-12T11:41:09Z | 2026-09-12T14:04:35Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#64](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/64) | Expand Social Media Platforms | 2026-09-12T11:43:53Z | 2026-09-12T14:04:47Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#78](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/78) | Expand Social Media Platforms | 2026-09-12T11:46:36Z | 2026-09-12T14:04:59Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#92](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/92) | Expand Social Media Platforms | 2026-09-12T11:49:20Z | 2026-09-12T14:05:11Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#106](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/106) | Expand Social Media Platforms | 2026-09-12T11:52:03Z | 2026-09-12T14:05:23Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#120](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/120) | Expand Social Media Platforms | 2026-09-12T11:54:47Z | 2026-09-12T14:05:35Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#134](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/134) | Expand Social Media Platforms | 2026-09-12T11:57:31Z | 2026-09-12T14:05:47Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#148](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/148) | Expand Social Media Platforms | 2026-09-12T12:00:15Z | 2026-09-12T14:05:59Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#162](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/162) | Expand Social Media Platforms | 2026-09-12T12:02:59Z | 2026-09-12T14:06:11Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#176](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/176) | Expand Social Media Platforms | 2026-09-12T12:05:43Z | 2026-09-12T14:06:23Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |
| [#190](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/190) | Expand Social Media Platforms | 2026-09-12T12:08:26Z | 2026-09-12T14:06:35Z | `CLOSED (duplicate)` | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | Closed via GitHub API with cross-reference comment to #204 |

### 8.3 CI/CD Pipeline Closed Duplicates

The duplicate issues share the title `"Automated CI/CD Build & Verification Pipeline"`, labels `["enhancement", "phase-3"]`, and milestone `"Phase 3 (Long-term - 2-3 months)"`.

| Issue # | Title | Created (UTC) | Closed (UTC) | Status | Canonical Reference | Resolution Details |
|---|---|---|---|---|---|---|
| [#38](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/38) | Automated CI/CD Build & Pipeline | 2026-09-12T11:38:36Z | 2026-09-12T14:06:45Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#52](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/52) | Automated CI/CD Build & Pipeline | 2026-09-12T11:41:20Z | 2026-09-12T14:06:57Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#66](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/66) | Automated CI/CD Build & Pipeline | 2026-09-12T11:44:04Z | 2026-09-12T14:07:09Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#80](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/80) | Automated CI/CD Build & Pipeline | 2026-09-12T11:46:48Z | 2026-09-12T14:07:21Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#94](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/94) | Automated CI/CD Build & Pipeline | 2026-09-12T11:49:31Z | 2026-09-12T14:07:33Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#108](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/108) | Automated CI/CD Build & Pipeline | 2026-09-12T11:52:15Z | 2026-09-12T14:07:45Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#122](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/122) | Automated CI/CD Build & Pipeline | 2026-09-12T11:54:58Z | 2026-09-12T14:07:57Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#136](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/136) | Automated CI/CD Build & Pipeline | 2026-09-12T11:57:42Z | 2026-09-12T14:08:09Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#150](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/150) | Automated CI/CD Build & Pipeline | 2026-09-12T12:00:26Z | 2026-09-12T14:08:21Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#164](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/164) | Automated CI/CD Build & Pipeline | 2026-09-12T12:03:10Z | 2026-09-12T14:08:33Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#178](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/178) | Automated CI/CD Build & Pipeline | 2026-09-12T12:05:54Z | 2026-09-12T14:08:45Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |
| [#192](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/192) | Automated CI/CD Build & Pipeline | 2026-09-12T12:08:37Z | 2026-09-12T14:08:57Z | `CLOSED (duplicate)` | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | Closed via GitHub API with cross-reference comment to #206 |

### 8.4 Closing Comment Audit Trail

Each duplicate issue received a courteous explanatory comment before closure on GitHub:
- **Social Media Comment:**
  > Closing as duplicate of canonical issue #204 ("Expand Social Media Platforms (Mastodon, Discord, Bluesky, etc.)").
  >
  > All specification, tracking, and implementation discussion for expanding supported social media platforms has been consolidated into #204 and the master roadmap in `FEATURE_ROADMAP.md`.
- **CI/CD Pipeline Comment:**
  > Closing as duplicate of canonical issue #206 ("Automated CI/CD Build & Verification Pipeline").
  >
  > All specification, tracking, and implementation discussion for the automated CI/CD build and verification pipeline has been consolidated into #206 and the master roadmap in `FEATURE_ROADMAP.md`.

---

## 9. Pull Requests & Ancillary GitHub Records

| PR # | Status | Title | Description | Resolution |
|---|---|---|---|---|
| [#1](https://github.com/kmutahar/bilingual-jekyll-resume-theme/pull/1) | `CLOSED` | Mend Bolt onboarding | Automated onboarding PR for Mend Bolt vulnerability scanning bot | Closed as bot onboarding was superseded by native GitHub security tools. |
| [#24](https://github.com/kmutahar/bilingual-jekyll-resume-theme/pull/24) | `MERGED` | feat: Add dark mode toggle with system preference detection | Implemented dark mode engine, toggle component, and color scheme tokens | Merged into `master` on 2026-08-21; formally resolved issue #8 (P2.4). |

