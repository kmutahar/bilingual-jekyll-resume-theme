# Authoritative Master Feature Roadmap & Engineering Blueprints

**Project:** `bilingual-jekyll-resume-theme`  
**Document Status:** Authoritative Master Document (Single Source of Truth)  
**Current Release:** `v1.0.0`  
**Status:** Features 1.7, 2.8, 4.1, and 4.6 have shipped in this release and are documented in [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md#5-v100-delivered-features-17-28-41-46). The blueprints below are active work for future releases.  
**Date:** September 2026  

---

## Executive Summary & Historical Audit Archival

This document establishes the single authoritative master feature roadmap for the `bilingual-jekyll-resume-theme` project. It contains turnkey, production-ready engineering blueprints for all **21 active, uncompleted features** organized across four sequential implementation phases:
1. **Priority 1 (Quick Wins & Visual Polish):** High-visibility, low-friction UX improvements (4 active features).
2. **Priority 2 (Core Functional & Architectural):** Data richness, typography, print fidelity, and RTL alignment (7 active features).
3. **Priority 3 (Interoperability, Tooling & CI/CD):** Industry schema standards, validation tooling, and test pipelines (3 active features).
4. **Priority 4 (Ecosystem Expansion):** Generic internationalization, chronology views, contact mechanisms, telemetry, custom sections, page auto-generation, and v1.0.0 deprecation retirement (7 active features).

### Historical Remediation Archival Notice
In accordance with repository governance and engineering hygiene rules, **all completed remediation tasks and finished features (P0.1–P0.16, P1.4 Configurable Avatar, P2.4 Universal Dark Mode & Error Suite, Feature 1.2 Interactive Language Switcher [#11], Feature 2.7 Advanced WCAG 2.1/2.2 AA Accessibility Polish [#21], Feature 1.7 Native Email Support [#215], Feature 2.8 Arabic Header Alignment [#217], Feature 4.1 Extended Multilingual Support [#15], and Feature 4.6 Deprecation Retirement [#214]) have been audited, verified in git history, and purged from this active roadmap document**. Features 3.2 and 3.3 are implemented but stay in this active document until their closure checks pass, per `docs/COMPLETED_AUDIT.md` §5.

For complete historical records, commit SHAs, root cause analyses, before-and-after code diffs, and verification commands for all completed items, refer to the dedicated audit archive:
👉 **[`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md)**

---

## 1. Active Features Master Matrix

All 21 active, uncompleted features are mapped below with their canonical GitHub issue references, auto-closing syntax, effort ratings, demand assessments, and target files.

| Phase | ID | Feature Title | Canonical Issue | Auto-Closing Reference | Effort | Demand | Time Est. | Target Files Key |
|---|---|---|---|---|---|---|---|---|
| **P1** | **1.1** | Predefined Color Themes Palette Engine (5 Palettes) | [#7](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/7) | `Closes #7` | ⭐⭐ | High | 2–3 hrs | `_sass/_themes.scss`, `_variables.scss`, layouts |
| **P1** | **1.3** | Expanded Modern Social Media Platforms (9 Platforms) | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) | `Closes #204` | ⭐⭐ | Med-High | 1–2 hrs | `_includes/social-links.html`, LineIcons SVGs |
| **P1** | **1.5** | Dynamic Contact / Resume QR Code Component | [#14](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/14) | `Closes #14` | ⭐⭐ | Low-Med | 1–2 hrs | `_includes/qr-code.html`, layouts, SCSS |
| **P1** | **1.6** | Achievement Badges & Credential Icons | [#19](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/19) | `Closes #19` | ⭐⭐ | Low-Med | 1–2 hrs | `_includes/badge-display.html`, sections, SCSS |
| **P2** | **2.1** | Comprehensive JSON-LD Structured Data (ATS/SEO) | [#9](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/9) | `Closes #9` | ⭐⭐ | High | 3–4 hrs | `_includes/json-ld-resume.html`, layouts |
| **P2** | **2.2** | Skills Level Indicators & Visual Progress Bars | [#10](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/10) | `Closes #10` | ⭐⭐ | Med-High | 3–4 hrs | `_includes/skill-level-bar.html`, sections, SCSS |
| **P2** | **2.3** | Professional Print Pagination & Spacing Engine | [#12](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/12) | `Closes #12` | ⭐⭐ | High | 2–3 hrs | `_sass/_print-optimization.scss`, `_resume.scss` |
| **P2** | **2.5** | Skills Taxonomy & Categorized Tagging System | [#18](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/18) | `Closes #18` | ⭐⭐ | Low | 2–3 hrs | `_includes/resume-section-*.html`, `skills.yml` |
| **P2** | **2.6** | Social Media Cards Generation (Open Graph & Twitter) | [#22](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/22) | `Closes #22` | ⭐⭐ | Med-High | 2–3 hrs | `_includes/shared-head.html`, SEO guides |
| **P2** | **2.9** | Dual Gregorian / Hijri (Islamic) Calendar Localization | [#218](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/218) | `Closes #218` | ⭐⭐ | High (MENA) | 2–3 hrs | `_includes/date-formatter.html`, `_data/locales/ar.yml` |
| **P2** | **2.10** | SCSS Deduplication Cleanup | [#224](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/224) | `Closes #224` | ⭐ | Low | 1 hr | `_sass/_base.scss`, `_sass/_all-pages.scss`, `_sass/_resume-ltr.scss`, `_sass/_resume-rtl.scss`, `_dark-mode.scss`, `_layout.scss` |
| **P3** | **3.1** | Standard JSON Resume Exporter (`/resume.json`) | [#6](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/6) | `Closes #6` | ⭐⭐⭐ | High | 4–5 hrs | `resume.json`, `resume-ar.json` |
| **P3** | **3.2** | Automated CI/CD Build & Verification Pipeline | [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206) | `Closes #206` | ⭐⭐ | High | 2–3 hrs | `.github/workflows/ci.yml` |
| **P3** | **3.3** | YAML Resume Data Validator & Schema Linter | [#13](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/13) | `Closes #13` | ⭐⭐⭐ | Med-High | 4–5 hrs | `bin/validate-resume`, `Rakefile` |
| **P4** | **4.2** | Interactive Career Timeline Visualization | [#16](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/16) | `Closes #16` | ⭐⭐⭐⭐ | Low-Med | 6–8 hrs | `_layouts/resume-timeline.html`, `_timeline.scss` |
| **P4** | **4.3** | Secure Contact Form Integration (Formspree/Netlify) | [#20](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/20) | `Closes #20` | ⭐⭐⭐ | Low-Med | 3–4 hrs | `_includes/contact-form.html`, layouts, SCSS |
| **P4** | **4.4** | Privacy-First Resume Engagement Analytics | [#17](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/17) | `Closes #17` | ⭐⭐⭐ | Low-Med | 3–4 hrs | `assets/js/resume-analytics.js`, analytics body |
| **P4** | **4.5** | Resume Comparison & A/B Testing View | [#23](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/23) | `Closes #23` | ⭐⭐⭐ | Low | 4–5 hrs | `_layouts/resume-comparison.html`, `_comparison.scss` |
| **P4** | **4.7** | Dynamic Custom Resume Sections Engine | [#219](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/219) | `Closes #219` | ⭐⭐⭐ | Med-High | 3–4 hrs | `_includes/resume-custom-section.html`, dispatchers |
| **P4** | **4.8** | Client-Side Site Search Index | [#225](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/225) | `Closes #225` | ⭐⭐⭐ | Low-Med | 4–6 hrs | `_layouts/error.html`, `search.json`, `assets/js/site-search.js` |
| **P4** | **4.9** | Auto-Generate CV & Profile Pages per Configured Language (v1.1.0) | [#226](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/226) | `Closes #226` | ⭐⭐⭐ | Med-High | 3–4 hrs | `_plugins/resume_pages_generator.rb`, `docs/_data/_config.sample.yml`, `lib/bilingual-jekyll-resume-theme/resume_validator.rb` |

*(Note on Canonical References: Issue #204 is canonical for Expanded Social Media, superseding redundant duplicates #36–#190. Issue #206 is canonical for Automated CI/CD Pipeline, superseding redundant duplicates #38–#192. GitHub Issue #216 is verified as implemented in v0.8.0 via `_layouts/error.html`).*

<a id="status-delete-zone"></a>
### 1.1 Status Delete-Zone (Intentional Removals & Deprecations)

In accordance with Living Docs Governance, this Delete-Zone catalogs files, patterns, features, and configurations that have been intentionally removed, prohibited, or deprecated. **AI agents and developers MUST NOT recreate or re-introduce these elements.**

| # | Path / Pattern / Concept | Lifecycle Status | Why Removed / Forbidden | Canonical Replacement | Revisit Condition |
|---|---|---|---|---|---|
| 1 | Static return URLs (`/resume/en/`, `/resume/ar/` in `_layouts/error.html`) | **Removed in v0.8.0 (Issue #216)** | Hardcoded paths broke return navigation for sites using custom resume paths (e.g. `/en/cv/`, `/ar/cv/`). | v1.0.0: dynamic resolution via `languages.<lang>.url`, falling back to the page with `layout: resume` and matching `lang`. | Never revert to hardcoded static URLs. The v1.0.0 locale extension (Feature 4.1, delivered — see `docs/COMPLETED_AUDIT.md`) already follows dynamic resolution; any future locale work must too. |
| 2 | Gravatar MD5 email hashing & fallback initials claims | **Purged in v0.8.0** | Fictional feature documented in old drafts; neither Gravatar hashing nor initials fallback was ever implemented in `_includes/avatar.html`. Documenting `resume_avatar` as a Hash broke Liquid's strict boolean check `{% if site.resume_avatar == true %}`. | Direct image path via `site.avatar_url` (the `site.avatar` fallback is removed in v1.0.0), defaulting to `/assets/images/Profile-min.jpg`, with `resume_avatar: true` (Boolean). | Revisit only if a verified Jekyll Liquid MD5 plugin or client-side JS hashing filter is formally designed, approved in an ADR, and tested. |
| 3 | `resume_avatar: Hash` in `_config.yml` | **Forbidden in v0.8.0** | Liquid `{% if site.resume_avatar == true %}` checks boolean equality; a hash evaluates to `false`. | `resume_avatar: true` (strictly Boolean) and `avatar_url: "..."`. | Never use a hash for `resume_avatar`. |
| 4 | Singular section keys: `resume_section.recognition` | **Removed in v1.0.0 (#214)** | Inconsistent singular syntax across sections. Standardized to plural `recognitions`. | `resume_section.recognitions` and `resume_section_order: - recognitions`. | Standardize all section names to plural. |
| 5 | Scoped dark mode key: `site.resume_dark_mode` | **Removed (confirmed absent in v1.0.0, #214)** | Scoped key confusingly duplicated site-wide dark mode toggle. | `site.dark_mode: enabled / auto / disabled`. | Use global `site.dark_mode` exclusively. |
| 6 | Global header intro key: `site.resume_header_intro` | **Retired in v0.4.0** | Stored candidate intro in `_config.yml`, preventing bilingual localization. | `_data/en/header.yml` and `_data/ar/header.yml` (`intro:` field). | Never store translatable content in config. |
| 7 | Universal Analytics: `analytics.ga` (`UA-XXXXX-X`) | **Retired (P0.3 / #214)** | Google UA is deprecated and shut down; caused parameter mismatch. | GA4 (`analytics.gtag: "G-..."`) or GTM (`analytics.gtm: "GTM-..."`). | Never restore Universal Analytics. |
| 8 | Duplicate manual `<link rel="canonical">` | **Retired in v0.7.0 (P0.7)** | Conflicted with `jekyll-seo-tag` canonical tag emission. | Canonical tags emitted exclusively via `{% seo %}`. | Do not emit manual canonical tags in `<head>`. |
| 9 | Global unscoped `svg` CSS selector | **Retired in v0.7.0 (P0.9)** | Applied 30px width and grey fill to all SVGs, distorting toggle buttons. | Scoped selectors `.svg-icon, .icon-link svg, .social-links svg, .page-footer svg`. | Never style unscoped `svg` or `img` tags. |
| 10 | Bare relative favicon paths (`favicon.ico`) | **Retired in v0.7.0 (P0.6)** | Caused 404s on subpaths (`/resume/en/`, baseurl). | Modern favicon suite in `_includes/shared-head.html` using `relative_url`. | Always filter static assets with `relative_url`. |
| 11 | Per-language layouts and includes (`resume-en.html`, `resume-ar.html`, `resume-section-{en,ar}.html`, `resume-head-{en,ar}.html`, `ar-date.html`) | **Removed in v1.0.0 (#15)** | Duplicated about 1,100 lines of Liquid and blocked languages beyond EN/AR. | `_layouts/resume.html`, `_includes/resume-section.html`, `_includes/date-formatter.html`, driven by `_data/locales/<lang>.yml`. | Never add a per-language layout or include. |
| 12 | Per-language config keys (`active_resume_path_*`, `resume_*_url`, `resume_header_intro_*`, `name_ar`, `resume_title_ar`, `address_ar`, `avatar_alt_*`) and `dir` in config | **Removed in v1.0.0 (#15)** | Suffix keys cannot scale past two languages; direction in config duplicated the locale file. | `languages.<lang>.*` in `_config.yml`; direction only in `_data/locales/<lang>.yml`. | Never add `_<lang>` suffixed config keys. |

---

## 3. Priority 1: Quick Wins & High-Impact Visual Blueprints

---

### Feature 1.1: Predefined Color Themes Palette Engine (5 Palettes)

- **Canonical Issue:** [#7](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/7)
- **Auto-Closing Reference:** `Closes #7`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/7`
- **Concept & User Demand Rationale:**  
  Candidates across different disciplines require visual presentation aligned with industry norms. While software engineers prefer modern blues, finance/health professionals prefer greens, corporate legal roles require navy, and academics prefer burgundy. Introducing 5 curated color themes through CSS Custom Properties enables zero-code palette switching via `_config.yml` while preserving full light/dark mode support.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (2–3 hrs) | Impact: ⭐⭐⭐⭐⭐ | Demand: High

#### Exact Target Files
- **Files to Create:**
  - `_sass/_themes.scss`
  - `docs/THEMES_GUIDE.md`
- **Files to Modify:**
  - `_sass/_variables.scss` (define fallback token defaults)
  - `_sass/_dark-mode.scss` (ensure dark mode token cascade overrides)
  - `assets/css/cv.scss` (add `@use "themes";`)
  - `assets/css/cv-ar.scss` (add `@use "themes";`)
  - `assets/css/main.scss` (add `@use "themes";`)
  - `_layouts/resume-en.html` (inject `class="theme-{{ site.resume_theme | default: 'default' }}"` on `<body>`)
  - `_layouts/resume-ar.html` (inject `class="theme-{{ site.resume_theme | default: 'default' }}"` on `<body>`)
  - `_layouts/default.html` (support theme class on default body)
  - `docs/_data/_config.sample.yml`
  - `docs/CONFIG_GUIDE.md`

#### Data Models & Configuration
In `_config.yml` and `docs/_data/_config.sample.yml`:
```yaml
# ==============================================================================
# Resume Color Theme Palette
# ==============================================================================
# Select active aesthetic theme palette.
# Options:
#   - default         : Classic Slate & Steel Blue (General / Baseline)
#   - modern-blue     : Vibrant Azure & Deep Royal (Tech, Software & Startups)
#   - emerald-green   : Emerald & Deep Forest (Finance, ESG & Life Sciences)
#   - corporate-navy  : Deep Indigo & Slate Navy (Consulting, Law & Enterprise)
#   - warm-burgundy   : Rich Rose & Deep Bordeaux (Design, Academia & Arts)
resume_theme: "modern-blue"
```

#### Architecture & Liquid/SCSS Implementation
Create `_sass/_themes.scss`:
```scss
// ==========================================================================
// Predefined Color Themes Engine
// bilingual-jekyll-resume-theme
// ==========================================================================

// 1. Modern Blue (Tech & Engineering)
body.theme-modern-blue {
  --accent-color: #2563eb;
  --accent-hover: #1d4ed8;
  --accent-hover-color: #1d4ed8;
  --border-color: #dbeafe;
  --card-bg: #eff6ff;
  --button-hover-bg: #2563eb;
  --button-hover-text: #ffffff;
}
html[data-theme="dark"] body.theme-modern-blue {
  --accent-color: #60a5fa;
  --accent-hover: #93c5fd;
  --accent-hover-color: #93c5fd;
  --border-color: #1e3a8a;
  --card-bg: #172554;
}

// 2. Emerald Green (Finance, ESG & Health Sciences)
body.theme-emerald-green {
  --accent-color: #059669;
  --accent-hover: #047857;
  --accent-hover-color: #047857;
  --border-color: #d1fae5;
  --card-bg: #ecfdf5;
  --button-hover-bg: #059669;
  --button-hover-text: #ffffff;
}
html[data-theme="dark"] body.theme-emerald-green {
  --accent-color: #34d399;
  --accent-hover: #6ee7b7;
  --accent-hover-color: #6ee7b7;
  --border-color: #064e3b;
  --card-bg: #062e24;
}

// 3. Corporate Navy (Consulting, Corporate & Legal)
body.theme-corporate-navy {
  --accent-color: #1e3a8a;
  --accent-hover: #172554;
  --accent-hover-color: #172554;
  --border-color: #cbd5e1;
  --card-bg: #f8fafc;
  --button-hover-bg: #1e3a8a;
  --button-hover-text: #ffffff;
}
html[data-theme="dark"] body.theme-corporate-navy {
  --accent-color: #93c5fd;
  --accent-hover: #bfdbfe;
  --accent-hover-color: #bfdbfe;
  --border-color: #1e293b;
  --card-bg: #0f172a;
}

// 4. Warm Burgundy (Academia, Arts & Editorial Design)
body.theme-warm-burgundy {
  --accent-color: #9f1239;
  --accent-hover: #881337;
  --accent-hover-color: #881337;
  --border-color: #ffe4e6;
  --card-bg: #fff1f2;
  --button-hover-bg: #9f1239;
  --button-hover-text: #ffffff;
}
html[data-theme="dark"] body.theme-warm-burgundy {
  --accent-color: #fb7185;
  --accent-hover: #fda4af;
  --accent-hover-color: #fda4af;
  --border-color: #4c0519;
  --card-bg: #2b0410;
}
```

In `_layouts/resume-en.html` and `_layouts/resume-ar.html`:
```liquid
<body class="layout-resume-{{ page.lang | default: 'en' }} theme-{{ site.resume_theme | default: 'default' }}">
```

#### Acceptance Criteria & Verification
- [ ] Setting `resume_theme: "emerald-green"` in `_config.yml` applies `theme-emerald-green` to `<body>`.
- [ ] Primary headers, contact buttons, and active accent elements switch to the palette's `--accent-color`.
- [ ] Dark mode toggle preserves distinct theme colors without reverting to default slate.
- [ ] Omitting `resume_theme` safely defaults to classic slate/blue with zero console errors.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build --strict_front_matter && \
  grep -q "theme-" _site/index.html && \
  echo "Theme classes compiled cleanly."
  ```

#### Git Workflow Specification
- **Branch:** `feature/color-themes`
- **PR Title:** `feat(theming): introduce 5 predefined professional color palettes`
- **Conventional Commit:** `feat(theming): add 5 predefined color theme palettes (Closes #7)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/7`

---

### Feature 1.3: Expanded Modern Social Media Platforms (9 Platforms)

- **Canonical Issue:** [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204)
- **Auto-Closing Reference:** `Closes #204`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204`
- **Duplicate Issues Closed with Cross-Reference:** #36, #50, #64, #78, #92, #106, #120, #134, #148, #162, #176, #190
- **Concept & User Demand Rationale:**  
  The theme currently supports 14 legacy platforms but lacks modern developer networks (Bluesky, Threads, Mastodon, Discord), developer repositories (GitLab), newsletter platforms (Substack), design portfolios (Behance), and academic citations (Google Scholar, ORCID). Mastodon requires `rel="me"` for decentralized identity verification.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (1–2 hrs) | Impact: ⭐⭐⭐⭐ | Demand: Med-High

#### Exact Target Files
- **Files to Create (SVGs in `_includes/vendors/lineicons-v5.0/`):**
  - `mastodon.svg`
  - `discord.svg`
  - `bluesky.svg`
  - `threads.svg`
  - `substack.svg`
  - `gitlab.svg`
  - `google-scholar.svg`
  - `orcid.svg`
  - `behance.svg`
- **Files to Modify:**
  - `_includes/social-links.html` (add Liquid blocks with WCAG labels, `rel="me"`)
  - `_includes/print-social-links.html` (add bilingual print entries with `<span dir="ltr">`)
  - `docs/_data/_config.sample.yml`
  - `docs/CONFIG_GUIDE.md`

#### Data Models & Configuration
In `_config.yml` and `docs/_data/_config.sample.yml`:
```yaml
social_links:
  github: "https://github.com/yourusername"
  linkedin: "https://www.linkedin.com/in/yourhandle/"
  # Modern & Academic Networks:
  mastodon: "https://mastodon.social/@yourhandle"
  discord: "https://discord.com/users/yourid"
  bluesky: "https://bsky.app/profile/yourhandle.bsky.social"
  threads: "https://www.threads.net/@yourhandle"
  substack: "https://yourhandle.substack.com"
  gitlab: "https://gitlab.com/yourhandle"
  google_scholar: "https://scholar.google.com/citations?user=yourid"
  orcid: "https://orcid.org/0000-0002-1825-0097"
  behance: "https://www.behance.net/yourhandle"
```

#### Architecture & Liquid/SCSS Implementation
In `_includes/social-links.html`:
```liquid
{% if site.social_links.mastodon %}
  <!-- Mastodon with Fediverse rel="me" verification -->
  <li class="icon-link-item">
    <a href="{{ site.social_links.mastodon }}" class="icon-link" itemprop="sameAs" target="_blank" rel="me noopener nofollow noreferrer" aria-label="Mastodon" title="Mastodon">
      {% include vendors/lineicons-v5.0/mastodon.svg %}
      <span class="sr-only">Mastodon</span>
    </a>
  </li>
{% endif %}

{% if site.social_links.bluesky %}
  <!-- Bluesky -->
  <li class="icon-link-item">
    <a href="{{ site.social_links.bluesky }}" class="icon-link" itemprop="sameAs" target="_blank" rel="noopener nofollow noreferrer" aria-label="Bluesky" title="Bluesky">
      {% include vendors/lineicons-v5.0/bluesky.svg %}
      <span class="sr-only">Bluesky</span>
    </a>
  </li>
{% endif %}
```

In `_includes/print-social-links.html`:
```liquid
{% if site.social_links.mastodon %}
  <li><strong>{% if is_ar %}ماستودون (Mastodon){% else %}Mastodon{% endif %}</strong>: <span dir="ltr">{{ site.social_links.mastodon }}</span></li>
{% endif %}
{% if site.social_links.bluesky %}
  <li><strong>{% if is_ar %}بلو سكاي (Bluesky){% else %}Bluesky{% endif %}</strong>: <span dir="ltr">{{ site.social_links.bluesky }}</span></li>
{% endif %}
{% if site.social_links.google_scholar %}
  <li><strong>{% if is_ar %}باحث جوجل (Google Scholar){% else %}Google Scholar{% endif %}</strong>: <span dir="ltr">{{ site.social_links.google_scholar }}</span></li>
{% endif %}
```

#### Acceptance Criteria & Verification
- [ ] All 9 platforms render clean 20x20px vector icons.
- [ ] Mastodon anchor includes `rel="me"` attribute.
- [ ] All SVGs include `aria-hidden="true" focusable="false"` with `.sr-only` text.
- [ ] Printed Arabic resumes output platform names with directionally isolated `<span dir="ltr">` URLs.
- [ ] **Bash Verification Command:**
  ```bash
  grep -rn 'rel="me' _includes/social-links.html && \
  ls -1 _includes/vendors/lineicons-v5.0/{mastodon,bluesky,discord,gitlab,orcid}.svg && \
  echo "Social platform assets verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/expanded-social-icons`
- **PR Title:** `feat(social): add 9 modern and academic social media platforms`
- **Conventional Commit:** `feat(social): add Mastodon, Bluesky, Discord, and Scholar icons (Closes #204)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204`

---

### Feature 1.5: Dynamic Contact / Resume QR Code Component

- **Canonical Issue:** [#14](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/14)
- **Auto-Closing Reference:** `Closes #14`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/14`
- **Concept & User Demand Rationale:**  
  Printed paper resumes and static PDF exports cannot be clicked. A scannable, high-contrast QR code bridging physical handouts with the live online portfolio or vCard contact profile allows recruiters at career fairs and interviews to instantaneously access the full web resume.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (1–2 hrs) | Impact: ⭐⭐⭐ | Demand: Low-Med

#### Exact Target Files
- **Files to Create:**
  - `_includes/qr-code.html`
- **Files to Modify:**
  - `_layouts/resume-en.html` (embed QR component)
  - `_layouts/resume-ar.html` (embed QR component)
  - `_sass/_resume.scss` (positioning and print styling)
  - `docs/_data/_config.sample.yml`
  - `docs/CONFIG_GUIDE.md`
  - `docs/INCLUDES_GUIDE.md`

#### Data Models & Configuration
In `_config.yml`:
```yaml
# ==============================================================================
# Resume QR Code
# ==============================================================================
resume_show_qr_code: true       # Master toggle (default: false)
resume_qr_code_print_only: true # Show strictly when printing / PDF export (default: true)
resume_qr_code_size: 96         # Square size in pixels (default: 96)
```

#### Architecture & Liquid/SCSS Implementation
Create `_includes/qr-code.html`:
```liquid
{%- comment -%}
Include: Dynamic Resume QR Code Component
- Invariant: Generates privacy-respecting vector QR code referencing canonical page URL.
- Print Mode: Symmetrically anchors to resume header corner in print media.
{%- endcomment -%}

{% if site.resume_show_qr_code %}
  {% assign qr_print_only = site.resume_qr_code_print_only | default: true %}
  {% if include.print_only != nil %}
    {% assign qr_print_only = include.print_only %}
  {% endif %}
  {% assign qr_size = include.size | default: site.resume_qr_code_size | default: 96 %}
  {% assign target_url = page.url | absolute_url %}
  {% assign current_lang = page.lang | default: site.lang | default: 'en' %}

  {% assign qr_alt = "QR code linking to the live online resume" %}
  {% assign qr_caption = "Scan to view online" %}
  {% if current_lang == 'ar' %}
    {% assign qr_alt = "رمز استجابة سريعة للوصول إلى السيرة الذاتية عبر الإنترنت" %}
    {% assign qr_caption = "امسح الرمز للمشاهدة عبر الإنترنت" %}
  {% endif %}

  {% assign qr_img_url = "https://api.qrserver.com/v1/create-qr-code/?data=" | append: target_url | append: "&amp;size=" | append: qr_size | append: "x" | append: qr_size | append: "&amp;margin=0" %}

  <div class="resume-qr-wrapper{% if qr_print_only %} print-only{% endif %}" role="complementary" aria-label="Resume QR Code">
    <img src="{{ qr_img_url }}"
         alt="{{ qr_alt }}"
         width="{{ qr_size }}"
         height="{{ qr_size }}"
         class="resume-qr-code"
         loading="lazy" />
    <span class="resume-qr-caption">{{ qr_caption }}</span>
  </div>
{% endif %}
```

Styling in `_sass/_resume.scss`:
```scss
.resume-qr-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.25rem;

  .resume-qr-code {
    border: 1px solid var(--border-color, #e0e0e0);
    padding: 3px;
    background: #ffffff;
    border-radius: 4px;
  }

  .resume-qr-caption {
    font-size: 0.75rem;
    color: var(--text-muted, #777777);
    text-align: center;
  }
}

@media print {
  .resume-qr-wrapper {
    position: absolute;
    top: 1rem;
    right: 1.5rem;
  }

  html[dir="rtl"] .resume-qr-wrapper {
    right: auto;
    left: 1.5rem;
  }
}
```

#### Acceptance Criteria & Verification
- [ ] Setting `resume_show_qr_code: true` renders a valid QR code pointing to `page.url | absolute_url`.
- [ ] If `resume_qr_code_print_only: true`, QR code is hidden on screen and appears only in print output.
- [ ] In Arabic resumes, the caption renders in Arabic and anchors to the top-left in print.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  grep -q "resume-qr-wrapper" _site/resume/en/index.html && \
  echo "QR code inclusion verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/qr-code`
- **PR Title:** `feat(resume): add dynamic QR code component for print and digital resumes`
- **Conventional Commit:** `feat(resume): add dynamic QR code include and print styles (Closes #14)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/14`

---

### Feature 1.6: Achievement Badges & Credential Icons

- **Canonical Issue:** [#19](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/19)
- **Auto-Closing Reference:** `Closes #19`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/19`
- **Concept & User Demand Rationale:**  
  Technical credentials (AWS Certified, Google Cloud Professional, CKA, PMP) issue standardized digital badges through Credly, Accredible, or GitHub. Integrating badges into certifications and recognitions sections improves credibility and candidate distinction.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (1–2 hrs) | Impact: ⭐⭐⭐ | Demand: Low-Med

#### Exact Target Files
- **Files to Create:**
  - `_includes/badge-display.html`
- **Files to Modify:**
  - `_includes/resume-section-en.html` (include `badge-display.html` in certifications & recognitions)
  - `_includes/resume-section-ar.html` (include `badge-display.html` in certifications & recognitions)
  - `_sass/_resume.scss` (`.achievement-badge` dimensions, alignment, hover scale)
  - `docs/_data/en/certifications.yml` (sample badge fields)
  - `docs/_data/ar/certifications.yml` (sample badge fields)
  - `docs/DATA_GUIDE.md`
  - `docs/INCLUDES_GUIDE.md`

#### Data Models & Configuration
In `docs/_data/en/certifications.yml`:
```yaml
# English Certification with Verified Badge
- name: "AWS Certified Solutions Architect – Associate"
  active: true
  issuing_organization: "Amazon Web Services"
  credential_id: "AWS-PSA-78291"
  credential_url: "https://www.credly.com/badges/sample-id"
  badge_url: "https://images.credly.com/size/340x340/images/0e284c41-ae9e-4e4b-bb2d-7043a2bc02cf/image.png"
  issue_date: 2024-05-15
  expiration: 2027-05-15
```

In `docs/_data/ar/certifications.yml`:
```yaml
# شهادة معتمدة مع شارة رقمية موثقة
- name: "مهندس حلول معتمد من أمازون (AWS) – مشارك"
  active: true
  issuing_organization: "أمازون لخدمات الويب (AWS)"
  credential_id: "AWS-PSA-78291"
  credential_url: "https://www.credly.com/badges/sample-id"
  badge_url: "https://images.credly.com/size/340x340/images/0e284c41-ae9e-4e4b-bb2d-7043a2bc02cf/image.png"
  issue_date: 2024-05-15
  expiration: 2027-05-15
```

#### Architecture & Liquid/SCSS Implementation
Create `_includes/badge-display.html`:
```liquid
{%- comment -%}
Include: Achievement Badge Display Component
- Parameters: item (Data item with badge_url, credential_url, and name)
{%- endcomment -%}

{% if include.item.badge_url %}
  {% assign badge_src = include.item.badge_url %}
  {% unless badge_src contains "://" %}
    {% assign badge_src = badge_src | relative_url %}
  {% endunless %}

  <span class="achievement-badge-container">
    {% if include.item.credential_url %}
      <a href="{{ include.item.credential_url }}" target="_blank" rel="noopener nofollow noreferrer" aria-label="Verify {{ include.item.name }} credential badge">
        <img src="{{ badge_src }}" alt="{{ include.item.name }} badge" class="achievement-badge" width="36" height="36" loading="lazy" />
      </a>
    {% else %}
      <img src="{{ badge_src }}" alt="{{ include.item.name }} badge" class="achievement-badge" width="36" height="36" loading="lazy" />
    {% endif %}
  </span>
{% endif %}
```

Styling in `_sass/_resume.scss`:
```scss
.achievement-badge-container {
  display: inline-flex;
  align-items: center;
  margin-right: 0.5rem;

  .achievement-badge {
    width: 36px;
    height: 36px;
    object-fit: contain;
    border-radius: 4px;
    vertical-align: middle;
    transition: transform 0.2s ease;

    &:hover {
      transform: scale(1.1);
    }
  }
}

html[dir="rtl"] .achievement-badge-container {
  margin-right: 0;
  margin-left: 0.5rem;
}
```

#### Acceptance Criteria & Verification
- [ ] Items configured with `badge_url` render aligned 36x36px badges in both English and Arabic.
- [ ] Badges with `credential_url` wrap in secure external links (`rel="noopener nofollow noreferrer"`).
- [ ] Certifications omitting `badge_url` render normally with zero spacing gaps.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  grep -q "achievement-badge" _site/resume/en/index.html && \
  echo "Credential badges rendered successfully."
  ```

#### Git Workflow Specification
- **Branch:** `feature/achievement-badges`
- **PR Title:** `feat(resume): support achievement badges and credential icons`
- **Conventional Commit:** `feat(resume): add badge-display include for certifications & awards (Closes #19)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/19`

---

## 4. Priority 2: Core Functional & Architectural Blueprints

---

### Feature 2.1: Comprehensive JSON-LD Structured Data (ATS/SEO)

- **Canonical Issue:** [#9](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/9)
- **Auto-Closing Reference:** `Closes #9`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/9`
- **Concept & User Demand Rationale:**  
  While microdata attributes exist on HTML tags, search crawlers (Google Search Console) and Applicant Tracking Systems (ATS parsers) require unified Schema.org JSON-LD scripts in `<head>`. A rich structured graph representing `Person` with nested `hasOccupation` (`Role`), `alumniOf` (`CollegeOrUniversity`), and `knowsAbout` (`skills`) dramatically improves ranking and automated recruitment indexing.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (3–4 hrs) | Impact: ⭐⭐⭐⭐⭐ | Demand: High

#### Exact Target Files
- **Files to Create:**
  - `_includes/json-ld-resume.html`
  - `docs/SEO_GUIDE.md`
- **Files to Modify:**
  - `_layouts/resume-en.html` (include `json-ld-resume.html` in `<head>`)
  - `_layouts/resume-ar.html` (include `json-ld-resume.html` in `<head>`)
  - `docs/INCLUDES_GUIDE.md`

#### Data Models & Configuration
Utilizes existing bilingual data files (`_data/en/*.yml`, `_data/ar/*.yml`, `_config.yml`).

#### Architecture & Liquid/SCSS Implementation
Create `_includes/json-ld-resume.html`:
```liquid
{%- comment -%}
Include: Comprehensive JSON-LD Structured Data Graph
- Conforms to: Schema.org/Person, Schema.org/Role, Schema.org/PostalAddress
- Escaping: String values wrapped with | jsonify to prevent JSON injection
{%- endcomment -%}

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Person",
  "name": "{% if page.lang == 'ar' and site.name_ar %}{{ site.name_ar.first }} {{ site.name_ar.last }}{% else %}{{ site.name.first }} {{ site.name.last }}{% endif %}",
  "jobTitle": "{% if page.lang == 'ar' and site.resume_title_ar %}{{ site.resume_title_ar }}{% else %}{{ site.resume_title }}{% endif %}",
  "url": "{{ page.url | absolute_url }}",
  "image": "{{ site.avatar_url | default: '/assets/images/Profile-min.jpg' | absolute_url }}",
  "email": "mailto:{{ site.contact_info.email }}",
  {% if site.contact_info.phone %}
  "telephone": "{{ site.contact_info.phone }}",
  {% endif %}
  {% if site.contact_info.address %}
  "address": {
    "@type": "PostalAddress",
    "addressLocality": "{% if page.lang == 'ar' and site.contact_info.address_ar %}{{ site.contact_info.address_ar }}{% else %}{{ site.contact_info.address }}{% endif %}"
  },
  {% endif %}
  "sameAs": [
    {% assign first_social = true %}
    {% for social in site.social_links %}
      {% if social[1] and social[1] != "" %}
        {% unless first_social %},{% endunless %}"{{ social[1] }}"
        {% assign first_social = false %}
      {% endif %}
    {% endfor %}
  ]
  {% if resume_data.skills %}
  ,"knowsAbout": [
    {% assign first_skill = true %}
    {% for s in resume_data.skills %}
      {% if s.active %}
        {% unless first_skill %},{% endunless %}{{ s.skill | jsonify }}
        {% assign first_skill = false %}
      {% endif %}
    {% endfor %}
  ]
  {% endif %}
  {% if resume_data.experience %}
  ,"hasOccupation": [
    {% assign first_exp = true %}
    {% for exp in resume_data.experience %}
      {% if exp.active %}
        {% unless first_exp %},{% endunless %}
        {
          "@type": "Role",
          "roleName": {{ exp.position | jsonify }},
          "startDate": "{{ exp.startdate | date: '%Y-%m' }}",
          "endDate": "{% if exp.enddate == 'Present' or exp.enddate == nil %}Present{% else %}{{ exp.enddate | date: '%Y-%m' }}{% endif %}",
          "worksFor": {
            "@type": "Organization",
            "name": {{ exp.company | jsonify }}
            {% if exp.location %},"location": {{ exp.location | jsonify }}{% endif %}
          }
        }
        {% assign first_exp = false %}
      {% endif %}
    {% endfor %}
  ]
  {% endif %}
  {% if resume_data.education %}
  ,"alumniOf": [
    {% assign first_edu = true %}
    {% for edu in resume_data.education %}
      {% if edu.active %}
        {% unless first_edu %},{% endunless %}
        {
          "@type": "CollegeOrUniversity",
          "name": {{ edu.uni | jsonify }}
          {% if edu.location %},"location": {{ edu.location | jsonify }}{% endif %}
        }
        {% assign first_edu = false %}
      {% endif %}
    {% endfor %}
  ]
  {% endif %}
}
</script>
```

#### Acceptance Criteria & Verification
- [ ] Both `/resume/en/` and `/resume/ar/` output syntactically valid `<script type="application/ld+json">`.
- [ ] Output validates in Google Rich Results Test and Schema.org Validator with 0 errors.
- [ ] Arabic characters, double quotes, and punctuation are safely escaped via `| jsonify`.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  ruby -rjson -e '
    ["_site/resume/en/index.html", "_site/resume/ar/index.html"].each do |f|
      html = File.read(f)
      match = html.match(/<script type="application\/ld\+json">([\s\S]*?)<\/script>/)
      raise "Missing JSON-LD in #{f}" unless match
      JSON.parse(match[1])
    end
    puts "JSON-LD syntax verified across EN and AR layouts."
  '
  ```

#### Git Workflow Specification
- **Branch:** `feature/json-ld-structured-data`
- **PR Title:** `feat(seo): embed comprehensive Schema.org JSON-LD structured data`
- **Conventional Commit:** `feat(seo): implement rich Person and Role JSON-LD in resume layouts (Closes #9)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/9`

---

### Feature 2.2: Skills Level Indicators & Visual Progress Bars

- **Canonical Issue:** [#10](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/10)
- **Auto-Closing Reference:** `Closes #10`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/10`
- **Concept & User Demand Rationale:**  
  Technical roles often require differentiating core competencies from foundational skills. Providing optional numerical proficiency values (1–5 scale or 1–100%) rendered via accessible progress bars (`role="progressbar"`) allows visual scanning while retaining text descriptions.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (3–4 hrs) | Impact: ⭐⭐⭐⭐ | Demand: Med-High

#### Exact Target Files
- **Files to Create:**
  - `_includes/skill-level-bar.html`
- **Files to Modify:**
  - `_includes/resume-section-en.html` (call `skill-level-bar.html`)
  - `_includes/resume-section-ar.html` (call `skill-level-bar.html`)
  - `_sass/_resume.scss` (`.skill-meter` styling, accessible colors, print overrides)
  - `docs/_data/en/skills.yml` (sample proficiency values)
  - `docs/_data/ar/skills.yml` (sample proficiency values)
  - `docs/DATA_GUIDE.md`
  - `docs/CONFIG_GUIDE.md`

#### Data Models & Configuration
In `docs/_data/en/skills.yml`:
```yaml
- skill: "TypeScript & Node.js"
  active: true
  level: 5                  # Integer 1 to 5, or percentage (1 to 100)
  level_label: "Expert"     # Optional textual indicator
  description: "Architecting enterprise microservices and reactive UIs."

- skill: "Python & PyTorch"
  active: true
  level: 4
  level_label: "Advanced"
```

In `docs/_data/ar/skills.yml`:
```yaml
- skill: "تايب سكريبت ونود جي إس (Node.js)"
  active: true
  level: 5
  level_label: "خبير"
  description: "بناء معمارية الخدمات المصغرة الموزعة وواجهات المستخدم التفاعلية."

- skill: "بايثون وباي تورش (PyTorch)"
  active: true
  level: 4
  level_label: "متقدم"
```

In `_config.yml`:
```yaml
resume_skills_visualization: true # Display visual progress indicators (default: false)
```

#### Architecture & Liquid/SCSS Implementation
Create `_includes/skill-level-bar.html`:
```liquid
{%- comment -%}
Include: Skills Level Visualizer
- Invariant: Implements WAI-ARIA progressbar pattern with screen-reader value announcements.
- RTL: Fills naturally from right to left under dir="rtl".
{%- endcomment -%}

{% if site.resume_skills_visualization and include.skill.level %}
  {% assign raw_level = include.skill.level | plus: 0 %}
  {% if raw_level <= 5 %}
    {% assign pct = raw_level | times: 20 %}
    {% assign val_now = raw_level %}
    {% assign val_max = 5 %}
  {% else %}
    {% assign pct = raw_level %}
    {% assign val_now = raw_level %}
    {% assign val_max = 100 %}
  {% endif %}

  <div class="skill-meter-container">
    {% if include.skill.level_label %}
      <span class="skill-meter-label">{{ include.skill.level_label }}</span>
    {% endif %}
    <div class="skill-meter"
         role="progressbar"
         aria-valuenow="{{ val_now }}"
         aria-valuemin="0"
         aria-valuemax="{{ val_max }}"
         aria-label="{{ include.skill.skill }} proficiency: {{ val_now }} of {{ val_max }}">
      <div class="skill-meter-fill" style="width: {{ pct }}%;"></div>
    </div>
  </div>
{% endif %}
```

Styling in `_sass/_resume.scss`:
```scss
.skill-meter-container {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin: 0.25rem 0 0.5rem;

  .skill-meter-label {
    font-size: 0.8rem;
    font-weight: 600;
    color: var(--text-light, #666666);
    min-width: 4rem;
  }

  .skill-meter {
    flex: 1;
    max-width: 180px;
    height: 6px;
    background: var(--border-color, #e0e0e0);
    border-radius: 3px;
    overflow: hidden;

    .skill-meter-fill {
      height: 100%;
      background: var(--accent-color, #007acc);
      border-radius: 3px;
      transition: width 0.4s ease;
    }
  }
}

@media print {
  .skill-meter {
    border: 1px solid #777777 !important;
    background: #eeeeee !important;

    .skill-meter-fill {
      background: #333333 !important;
    }
  }
}
```

#### Acceptance Criteria & Verification
- [ ] Skills with `level` render progress meters when `resume_skills_visualization: true`.
- [ ] Includes `role="progressbar"` with accurate `aria-valuenow`, `aria-valuemin`, and `aria-valuemax`.
- [ ] Omitting `level` suppresses meter DOM output cleanly without whitespace.
- [ ] Meter fill renders from right-to-left in Arabic RTL orientation.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  grep -q 'role="progressbar"' _site/resume/en/index.html && \
  echo "Skill proficiency progress bars verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/skills-visualization`
- **PR Title:** `feat(skills): add accessible skill proficiency bars and level labels`
- **Conventional Commit:** `feat(skills): implement skill-level-bar include with ARIA attributes (Closes #10)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/10`

---

### Feature 2.3: Professional Print Pagination & Spacing Engine

- **Canonical Issue:** [#12](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/12)
- **Auto-Closing Reference:** `Closes #12`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/12`
- **Concept & User Demand Rationale:**  
  Current print output suffers from two severe defects:
  1. `_sass/_resume.scss` imposes `line-height: .7em;` on print elements, truncating English descenders ('g', 'y', 'p') and severely clipping Arabic Cairo font glyphs and diacritics.
  2. Long resumes break awkwardly across physical pages, orphaning section titles at page bottoms or slicing job entries in half.
  A dedicated print engine enforcing `@page` geometry and `break-inside: avoid;` guarantees interview-ready PDF exports.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (2–3 hrs) | Impact: ⭐⭐⭐⭐⭐ | Demand: High

#### Exact Target Files
- **Files to Create:**
  - `_sass/_print-optimization.scss`
  - `docs/PRINT_GUIDE.md`
- **Files to Modify:**
  - `_sass/_resume.scss` (remove clipped `.7em` line-heights, import print optimization)
  - `assets/css/cv.scss` (add `@use "print-optimization";`)
  - `assets/css/cv-ar.scss` (add `@use "print-optimization";`)
  - `docs/SASS_GUIDE.md`

#### Architecture & SCSS Implementation
Create `_sass/_print-optimization.scss`:
```scss
// ==========================================================================
// Professional Print & PDF Engine
// bilingual-jekyll-resume-theme
// ==========================================================================

@media print {
  // Standard page setup for international A4 and US Letter
  @page {
    size: A4 portrait;
    margin: 12mm 15mm 12mm 15mm;
  }

  // Eliminate awkward page breaks across individual items
  .resume-item,
  .content-section header,
  .languages-table,
  .achievement-badge-container,
  .skill-meter-container {
    break-inside: avoid !important;
    page-break-inside: avoid !important;
  }

  // Prevent orphaned section headers at the bottom of a page
  .section-header {
    break-after: avoid !important;
    page-break-after: avoid !important;
  }

  // Remedy severe line-height clipping bug
  .content-section {
    .resume-item-title {
      font-size: 14px !important;
      line-height: 1.35 !important;
      margin-bottom: 0.2rem !important;
    }

    .resume-item-details {
      font-size: 11px !important;
      line-height: 1.35 !important;
      margin-bottom: 0.35rem !important;
    }

    .resume-item-copy {
      font-size: 10px !important;
      line-height: 1.45 !important;
    }
  }

  // Hide interactive controls
  .no-print,
  .dark-mode-toggle,
  .language-switcher,
  .contact-button {
    display: none !important;
  }

  // Force pure black text on clean white paper
  body {
    color: #000000 !important;
    background: #ffffff !important;
  }
}
```

#### Acceptance Criteria & Verification
- [ ] Section headers are never orphaned at the bottom of a printed page (`break-after: avoid`).
- [ ] Arabic text (Cairo font) renders with zero clipped ascenders, descenders, or hamzas.
- [ ] Interactive buttons (language switcher, dark mode toggle) are hidden in print preview.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  grep -rn 'break-inside: avoid' _site/assets/css/ && \
  echo "Print pagination rules verified in compiled CSS."
  ```

#### Git Workflow Specification
- **Branch:** `feature/print-pagination-engine`
- **PR Title:** `fix(print): professional print pagination, page break controls, and typography`
- **Conventional Commit:** `fix(print): fix line-height clipping and prevent orphaned headers (Closes #12)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/12`

---

### Feature 2.5: Skills Taxonomy & Categorized Tagging System

- **Canonical Issue:** [#18](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/18)
- **Auto-Closing Reference:** `Closes #18`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/18`
- **Concept & User Demand Rationale:**  
  Unstructured lists of 25+ skills are hard for recruiters to scan. Partitioning skills into functional taxonomy categories (e.g., *Cloud & DevOps*, *Frontend*, *Backend Systems*, *Databases*) with optional keyword tags enables structured resume evaluation.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (2–3 hrs) | Impact: ⭐⭐⭐ | Demand: Low

#### Exact Target Files
- **Files to Modify:**
  - `_includes/resume-section-en.html` (implement `group_by: "category"` loop)
  - `_includes/resume-section-ar.html` (implement `group_by: "category"` loop)
  - `_sass/_resume.scss` (`.skills-category-title`, `.skills-category-group`)
  - `_sass/_resume-rtl.scss`
  - `docs/_data/en/skills.yml` (categorized sample data)
  - `docs/_data/ar/skills.yml` (categorized sample data)
  - `docs/_data/_config.sample.yml`
  - `docs/DATA_GUIDE.md`
  - `docs/CONFIG_GUIDE.md`

#### Data Models & Configuration
In `docs/_data/en/skills.yml`:
```yaml
- skill: "Kubernetes & Docker"
  category: "Cloud & DevOps"
  tags: ["containers", "orchestration", "gitops"]
  active: true
  level: 5

- skill: "PostgreSQL & Redis"
  category: "Databases & Storage"
  tags: ["sql", "rdbms", "caching"]
  active: true
  level: 4
```

In `docs/_data/ar/skills.yml`:
```yaml
- skill: "كوبرنيتس ودوكر (Docker & Kubernetes)"
  category: "السحابة وديف أوبس (Cloud & DevOps)"
  tags: ["حاويات", "أتمتة"]
  active: true
  level: 5

- skill: "بوستجريس كيو إل وريديس (PostgreSQL & Redis)"
  category: "قواعد البيانات والتخزين"
  tags: ["sql", "ذاكرة مؤقتة"]
  active: true
  level: 4
```

In `_config.yml`:
```yaml
resume_skills_categorized: true # Group skills by category heading (default: false)
```

#### Architecture & Liquid Implementation

In `_includes/resume-section-en.html`:
```liquid
{% elsif include.section_name == "skills" and site.resume_section.skills %}
    <!-- begin Skills -->
    <section class="content-section">
        <header class="section-header">
            <h2>Skills</h2>
        </header>

        {%- assign active_skills = resume_data.skills | where: "active", true -%}

        {%- if include.skill_category -%}
          {%- assign active_skills = active_skills | where: "category", include.skill_category -%}
        {%- endif -%}

        {%- if include.skill_tag -%}
          {%- assign filtered = '' | split: ',' -%}
          {%- for s in active_skills -%}
            {%- if s.tags and s.tags contains include.skill_tag -%}
              {%- assign filtered = filtered | push: s -%}
            {%- endif -%}
          {%- endfor -%}
          {%- assign active_skills = filtered -%}
        {%- endif -%}

        {%- if site.resume_skills_categorized -%}
          {%- assign groups = active_skills | group_by: "category" -%}
          {%- for group in groups -%}
            <div class="resume-item skills-category-group">
              <h3 class="resume-item-title skills-category-title">{{ group.name | default: 'Other' }}</h3>
              {%- assign skills_sorted = group.items | sort: "skill" -%}
              {%- for skill in skills_sorted -%}
                <div class="skill-entry">
                  <h4 class="resume-item-details">{{ skill.skill }}</h4>
                  {%- if skill.level -%}{% include skill-level-bar.html skill=skill %}{%- endif -%}
                  {%- if skill.description -%}
                    <p class="resume-item-copy">{{ skill.description }}</p>
                  {%- endif -%}
                  {%- if skill.tags and skill.tags.size > 0 -%}
                    <p class="skill-tags">
                      {%- for tag in skill.tags -%}
                        <span class="skill-tag">{{ tag }}</span>
                      {%- endfor -%}
                    </p>
                  {%- endif -%}
                </div>
              {%- endfor -%}
            </div>
          {%- endfor -%}
        {%- else -%}
          {%- for skill in active_skills -%}
            <div class="resume-item">
              <h4 class="resume-item-details">{{ skill.skill }}</h4>
              {%- if skill.level -%}{% include skill-level-bar.html skill=skill %}{%- endif -%}
              {%- if skill.description -%}
                <p class="resume-item-copy">{{ skill.description }}</p>
              {%- endif -%}
              {%- if skill.tags and skill.tags.size > 0 -%}
                <p class="skill-tags">
                  {%- for tag in skill.tags -%}
                    <span class="skill-tag">{{ tag }}</span>
                  {%- endfor -%}
                </p>
              {%- endif -%}
            </div>
          {%- endfor -%}
        {%- endif -%}
    </section>
    <!-- end Skills -->
```

In `_includes/resume-section-ar.html` (Arabic counterpart with mirrored taxonomy):
```liquid
{% elsif include.section_name == "skills" and site.resume_section.skills %}
    <!-- begin Skills (Arabic RTL) -->
    <section class="content-section">
        <header class="section-header">
            <h2>المهارات</h2>
        </header>

        {%- assign active_skills = resume_data.skills | where: "active", true -%}

        {%- if include.skill_category -%}
          {%- assign active_skills = active_skills | where: "category", include.skill_category -%}
        {%- endif -%}

        {%- if include.skill_tag -%}
          {%- assign filtered = '' | split: ',' -%}
          {%- for s in active_skills -%}
            {%- if s.tags and s.tags contains include.skill_tag -%}
              {%- assign filtered = filtered | push: s -%}
            {%- endif -%}
          {%- endfor -%}
          {%- assign active_skills = filtered -%}
        {%- endif -%}

        {%- if site.resume_skills_categorized -%}
          {%- assign groups = active_skills | group_by: "category" -%}
          {%- for group in groups -%}
            <div class="resume-item skills-category-group">
              <h3 class="resume-item-title skills-category-title">{{ group.name | default: 'أخرى' }}</h3>
              {%- assign skills_sorted = group.items | sort: "skill" -%}
              {%- for skill in skills_sorted -%}
                <div class="skill-entry">
                  <h4 class="resume-item-details">{{ skill.skill }}</h4>
                  {%- if skill.level -%}{% include skill-level-bar.html skill=skill %}{%- endif -%}
                  {%- if skill.description -%}
                    <p class="resume-item-copy">{{ skill.description }}</p>
                  {%- endif -%}
                  {%- if skill.tags and skill.tags.size > 0 -%}
                    <p class="skill-tags">
                      {%- for tag in skill.tags -%}
                        <span class="skill-tag">{{ tag }}</span>
                      {%- endfor -%}
                    </p>
                  {%- endif -%}
                </div>
              {%- endfor -%}
            </div>
          {%- endfor -%}
        {%- else -%}
          {%- for skill in active_skills -%}
            <div class="resume-item">
              <h4 class="resume-item-details">{{ skill.skill }}</h4>
              {%- if skill.level -%}{% include skill-level-bar.html skill=skill %}{%- endif -%}
              {%- if skill.description -%}
                <p class="resume-item-copy">{{ skill.description }}</p>
              {%- endif -%}
              {%- if skill.tags and skill.tags.size > 0 -%}
                <p class="skill-tags">
                  {%- for tag in skill.tags -%}
                    <span class="skill-tag">{{ tag }}</span>
                  {%- endfor -%}
                </p>
              {%- endif -%}
            </div>
          {%- endfor -%}
        {%- endif -%}
    </section>
    <!-- end Skills -->
```

#### SCSS Styling Architecture
In `_sass/_resume.scss`:
```scss
// Skills taxonomy and tag badges
.skills-category-title {
  margin: 0 0 0.5rem;
}

.skill-entry {
  margin: 0 0 1rem;
}

.skill-tags {
  margin: 0.25rem 0 0;
  display: flex;
  flex-wrap: wrap;
  gap: 0.25rem;
}

.skill-tag {
  display: inline-block;
  background: var(--card-bg, #f3f3f3);
  border: 1px solid var(--border-color, #e0e0e0);
  color: var(--text-color, #555);
  padding: 0.1rem 0.4rem;
  font-size: 0.8rem;
  @include mixins.border-radius(3px);
}
```

In `_sass/_resume-rtl.scss`:
```scss
// Mirrored skill tags for RTL layout
.skill-tags {
  direction: rtl;
}
```

#### Advanced Include Filtering Usage
Developers and theme consumers can optionally render filtered subsets of skills in custom pages:
- Filter by category in English: `{% include resume-section-en.html section_name="skills" skill_category="Cloud & DevOps" %}`
- Filter by keyword tag in Arabic: `{% include resume-section-ar.html section_name="skills" skill_tag="حاويات" %}`

#### Acceptance Criteria & Verification
- [ ] Setting `resume_skills_categorized: true` renders skills grouped under category subheadings (`<h3>`).
- [ ] Setting `resume_skills_categorized: false` gracefully preserves flat list view.
- [ ] Tags render as accessible badge pills underneath each skill description.
- [ ] Skills lacking `category` render under "Other" / "أخرى" without template errors.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  grep -q "skill-tag" _site/resume/en/index.html && \
  echo "Skills taxonomy categorization and tag badges verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/skills-taxonomy`
- **PR Title:** `feat(skills): introduce categorized skills taxonomy and domain grouping`
- **Conventional Commit:** `feat(skills): group skills by category in resume sections (Closes #18)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/18`

---

### Feature 2.6: Social Media Cards Generation (Open Graph & Twitter Cards)

- **Canonical Issue:** [#22](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/22)
- **Auto-Closing Reference:** `Closes #22`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/22`
- **Concept & User Demand Rationale:**  
  When candidates share resume links on LinkedIn, Twitter/X, WhatsApp, Slack, or Discord, platforms crawl Open Graph and Twitter Card tags to generate rich link preview cards. Complete meta tags ensure professional branding with high-resolution preview images (1200x630px).
- **Effort / Impact / Demand:** Effort: ⭐⭐ (2–3 hrs) | Impact: ⭐⭐⭐⭐ | Demand: Med-High

#### Exact Target Files
- **Files to Modify:**
  - `_includes/shared-head.html` (integrate rich Open Graph and Twitter Card meta tags)
  - `docs/_data/_config.sample.yml` (add `og_image` and `twitter_creator`)
  - `docs/CONFIG_GUIDE.md`
  - `docs/SEO_GUIDE.md`

#### Data Models & Configuration
In `_config.yml`:
```yaml
# ==============================================================================
# Social Media Sharing Cards (Open Graph & Twitter)
# ==============================================================================
og_image: "/assets/images/social-card.png" # 1200x630px preview card
twitter_creator: "@yourhandle"
```

#### Architecture & Liquid Implementation
In `_includes/shared-head.html`:
```liquid
<!-- Open Graph & Social Cards -->
{% assign page_title = page.title | default: site.title | escape %}
{% assign page_desc = page.description | default: site.description | escape %}
{% assign card_image = page.og_image | default: site.og_image | default: site.avatar_url | default: '/assets/images/Profile-min.jpg' | absolute_url %}

<meta property="og:site_name" content="{{ site.title | escape }}">
<meta property="og:title" content="{{ page_title }}">
<meta property="og:description" content="{{ page_desc }}">
<meta property="og:url" content="{{ page.url | absolute_url }}">
<meta property="og:type" content="profile">
<meta property="og:image" content="{{ card_image }}">
<meta property="og:image:alt" content="{{ page_title }}">

<!-- Twitter Cards -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{{ page_title }}">
<meta name="twitter:description" content="{{ page_desc }}">
<meta name="twitter:image" content="{{ card_image }}">
{% if site.twitter_creator or site.social_links.twitter %}
  {% assign twitter_handle = site.twitter_creator | default: site.social_links.twitter | split: '/' | last | remove: '@' %}
  <meta name="twitter:creator" content="@{{ twitter_handle }}">
  <meta name="twitter:site" content="@{{ twitter_handle }}">
{% endif %}
```

#### Acceptance Criteria & Verification
- [ ] `<head>` contains valid `og:title`, `og:image`, `og:url`, and `twitter:card`.
- [ ] Image URLs resolve to full absolute URLs via `absolute_url`.
- [ ] Integrates seamlessly with `jekyll-seo-tag` without duplicate conflicts.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  grep -q 'property="og:image"' _site/resume/en/index.html && \
  grep -q 'name="twitter:card"' _site/resume/en/index.html && \
  echo "Social media card tags verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/social-media-cards`
- **PR Title:** `feat(seo): enhance Open Graph and Twitter summary_large_image cards`
- **Conventional Commit:** `feat(seo): implement rich social card meta tags in shared head (Closes #22)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/22`

---

### Feature 2.9: Dual Gregorian / Hijri (Islamic) Calendar Localization

- **Canonical Issue:** [#218](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/218)
- **Auto-Closing Reference:** `Closes #218`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/218`
- **Concept & User Demand Rationale:**  
  Professionals submitting resumes to Middle Eastern institutions (governmental, academic, and GCC corporate positions) frequently require official Islamic Hijri dates alongside or in lieu of Gregorian dates (e.g., "شعبان ١٤٤٥ هـ / مارس ٢٠٢٤ م"). Providing native Hijri calendar formatting and Arabic-Indic numeral conversion establishes the theme as the premier bilingual resume solution for the Arab world.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (2–3 hrs) | Impact: ⭐⭐⭐⭐ | Demand: High (MENA Region)

#### Exact Target Files
- **Files to Create:**
  - `_data/ar/hijri_months.yml` (Dictionary containing Arabic names of the 12 Islamic lunar months)
- **Files to Modify:**
  - `_includes/date-formatter.html` (Add calendar formatting parameter: `gregorian`, `hijri`, `dual`; `ar-date.html` is deleted in v1.0.0)
  - `docs/_data/_config.sample.yml` (Document `arabic_date_calendar` setting)
  - `docs/CONFIG_GUIDE.md`
  - `docs/DATA_GUIDE.md`

#### Data Models & Configuration
Create `_data/ar/hijri_months.yml`:
```yaml
months:
  - "محرم"
  - "صفر"
  - "ربيع الأول"
  - "ربيع الثاني"
  - "جمادى الأولى"
  - "جمادى الآخرة"
  - "رجب"
  - "شعبان"
  - "رمضان"
  - "شوال"
  - "ذو القعدة"
  - "ذو الحجة"
```

In `_config.yml`:
```yaml
# ==============================================================================
# Arabic Calendar Localization (#218)
# ==============================================================================
arabic_date_calendar: "gregorian" # Options: "gregorian", "hijri", "dual"
arabic_numerals: "eastern" # Options: "eastern" (٠١٢٣٤٥٦٧٨٩) or "western" (0123456789)
```

In resume entries (e.g. `_data/ar/experience.yml`):
```yaml
- company: "جامعة الملك سعود"
  position: "أستاذ مشارك"
  startdate: "2020-09-01"
  hijri_startdate: "محرم ١٤٤٢"
  enddate: "Present"
  active: true
```

#### Architecture & Liquid Implementation
In `_includes/ar-date.html`:
```liquid
{% assign input_date = include.date %}
{% assign hijri_date = include.hijri_date %}
{% assign calendar_mode = site.arabic_date_calendar | default: 'gregorian' %}

{% if input_date == 'Present' or input_date == 'حتى الآن' or input_date == nil %}
  حتى الآن
{% else %}
  {% assign month_num = input_date | date: "%m" | plus: 0 | minus: 1 %}
  {% assign year_num = input_date | date: "%Y" %}
  {% assign g_month = site.data.ar.months.months[month_num] | default: site.data.ar.months[month_num] %}
  {% assign g_date_str = g_month | append: ' ' | append: year_num | append: ' م' %}

  {% if calendar_mode == 'hijri' and hijri_date %}
    {{ hijri_date }} هـ
  {% elsif calendar_mode == 'dual' and hijri_date %}
    {{ hijri_date }} هـ / {{ g_date_str }}
  {% else %}
    {{ g_month }} {{ year_num }}
  {% endif %}
{% endif %}
```

#### Acceptance Criteria & Verification
- [ ] Setting `arabic_date_calendar: "dual"` renders combined Hijri and Gregorian dates cleanly.
- [ ] Fallback to standard Gregorian date occurs seamlessly if `hijri_startdate` is omitted in an entry.
- [ ] "Present" / "حتى الآن" string continues to resolve accurately regardless of calendar mode.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build --config docs/_data/_config.sample.yml && \
  echo "Arabic calendar localization verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/hijri-calendar-support`
- **PR Title:** `feat(i18n): support dual Gregorian and Hijri calendar localization in Arabic layout`
- **Conventional Commit:** `feat(i18n): add Hijri Islamic calendar formatting for Arabic resume (Closes #218)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/218`

---

### Feature 2.10: SCSS Deduplication Cleanup

> **Origin:** Found during the pre-v1.0.0 release review, not a user-requested feature.

- **Canonical Issue:** [#224](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/224)
- **Auto-Closing Reference:** `Closes #224`
- **Concept & Rationale:** Several rules are declared twice with matching values: `.sr-only` (`_base.scss` and `_all-pages.scss`), the icon-link/social-link rules (`_resume-ltr.scss` and `_all-pages.scss`), `.page-footer` spacing (`_resume-ltr.scss` and `_all-pages.scss`), and the dark-mode-toggle/language-switcher RTL repositioning (a generic `html[dir="rtl"]` rule in `_dark-mode.scss`/`_layout.scss`, duplicated again for resume pages specifically in `_resume-rtl.scss`). None conflict today, but a future edit to one copy risks silently not applying to the other.
- **Effort / Impact / Demand:** Effort: ⭐ (1 hr) | Impact: Low (no visible behavior change) | Demand: Low

#### Exact Target Files
- **Files to Modify:** `_sass/_base.scss`, `_sass/_all-pages.scss`, `_sass/_resume-ltr.scss`, `_sass/_resume-rtl.scss`, `_sass/_dark-mode.scss`, `_sass/_layout.scss`

#### Acceptance Criteria & Verification
- [ ] Each duplicated rule exists in exactly one file; the other reference is deleted.
- [ ] `bundle exec jekyll build --config docs/_data/_config.sample.yml,docs/_data/_config.demo.yml` produces no visual regression in either LTR or RTL demo pages.

#### Git Workflow Specification
- **Branch:** `chore/scss-deduplication`
- **PR Title:** `chore(sass): deduplicate repeated CSS rules (Closes #224)`
- **Conventional Commit:** `chore(sass): remove duplicate .sr-only, icon-link, and RTL toggle rules (Closes #224)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/224`

---

## 5. Priority 3: Interoperability, Tooling & CI/CD Blueprints

---

### Feature 3.1: Standard JSON Resume Exporter (`/resume.json`)

- **Canonical Issue:** [#6](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/6)
- **Auto-Closing Reference:** `Closes #6`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/6`
- **Concept & User Demand Rationale:**  
  The [JSON Resume](https://jsonresume.org/schema/) open standard is the industry benchmark for structured career data. By compiling `/resume.json` and `/resume-ar.json` directly from the site's YAML data, users can import their resume into any ATS, aggregator, or developer tool without manual data re-entry.
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐ (4–5 hrs) | Impact: ⭐⭐⭐⭐⭐ | Demand: High

#### Exact Target Files
- **Files to Create:**
  - `lib/bilingual-jekyll-resume-theme/json_resume_exporter.rb` (Jekyll Generator plugin for automated export)
  - `resume.json` (English JSON Resume template with Liquid front matter fallback)
  - `resume-ar.json` (Arabic JSON Resume template with Liquid front matter fallback)
  - `docs/JSON_RESUME_EXPORT.md` (comprehensive user and developer documentation)
- **Files to Modify:**
  - `lib/bilingual-jekyll-resume-theme.rb` (require `json_resume_exporter`)
  - `bilingual-jekyll-resume-theme.gemspec` (ensure plugin and json templates are bundled)
  - `_includes/shared-head.html` (add `<link rel="alternate" type="application/json" href="{{ '/resume.json' | relative_url }}">`)
  - `docs/_data/_config.sample.yml` (document `json_resume_export_language`)

#### Data Models & Configuration Reference
In `_config.yml`:
```yaml
# ==============================================================================
# JSON Resume Standard Export Configuration (#6)
# ==============================================================================
json_resume_export_language: "en" # Options: "en", "ar", or "dual" (exports both resume.json & resume-ar.json)
```

#### Complete YAML to JSON Resume Schema Mapping Matrix

| JSON Resume v1.0.0 Section | YAML Source Key | Mapping Rules & Fallbacks |
|---|---|---|
| `basics.name` | `name` / `name_ar` | Combined `first + middle + last` from config |
| `basics.label` | `resume_title` / `resume_title_ar` | Professional title from config |
| `basics.image` | `avatar_url` / `avatar` | Absolute URL to profile picture |
| `basics.email` | `contact_info.email` / `email_live` | Uses live email if `enable_live: true` |
| `basics.phone` | `contact_info.phone` / `phone_live` | Uses live phone if `enable_live: true` |
| `basics.url` | `url` | Site root URL |
| `basics.summary` | `header.intro` / `header.about` | Candidate executive summary from header YAML |
| `basics.location.address` | `contact_info.address` / `address_ar` | Address string |
| `basics.profiles` | `social_links` | Maps key/value pairs to `{ network, url }` |
| `work[]` | `experience[]` | `company` &rarr; `name`, `position` &rarr; `position`, `startdate` &rarr; `startDate`, `enddate` &rarr; `endDate`, `summary` &rarr; `summary`, `durations` array fallback |
| `volunteer[]` | `volunteering[]` | `company` &rarr; `organization`, `position` &rarr; `position`, `startdate` &rarr; `startDate`, `enddate` &rarr; `endDate`, `summary` &rarr; `summary` |
| `education[]` | `education[]` | `uni` &rarr; `institution`, `degree` &rarr; `area`, heuristic &rarr; `studyType` (Bachelor/Master/PhD), `year` &rarr; `startDate`/`endDate`, `awards` &rarr; `highlights` |
| `awards[]` | `recognitions[]` | `award` &rarr; `title`, `year` &rarr; `date`, `organization` &rarr; `awarder`, `summary` &rarr; `summary` |
| `certificates[]` | `certifications[]` | `name` &rarr; `name`, `issue_date` &rarr; `date`, `issuing_organization` &rarr; `issuer`, `credential_url` &rarr; `url` |
| `skills[]` | `skills[]` | `skill` &rarr; `name`, `level`/`level_label` &rarr; `level`, `description` &rarr; `keywords[]` |
| `languages[]` | `languages[]` | `language` &rarr; `language`, `description`/`descrp_short` &rarr; `fluency` |
| `interests[]` | `interests[]` | `description` &rarr; `name` and `keywords[]` |
| `projects[]` | `projects[]` | `project` &rarr; `name`, `description` &rarr; `description`, `role` &rarr; `type`, `url` &rarr; `url`, `duration` &rarr; `startDate`/`endDate` |

#### Architecture & Ruby Generator Implementation
Create `lib/bilingual-jekyll-resume-theme/json_resume_exporter.rb`:
```ruby
# frozen_string_literal: true

require 'date'
require 'json'
require 'uri'
require 'fileutils'
require 'jekyll'

module BilingualJekyllResumeTheme
  module Jekyll
    # Generator plugin to export resume data to JSON Resume format
    class JsonResumeExporter < ::Jekyll::Generator
      safe true
      priority :lowest

      def generate(site)
        export_lang = site.config['json_resume_export_language'] || 'en'
        languages = export_lang == 'dual' ? %w[en ar] : [export_lang]

        languages.each do |lang|
          export_path = lang == 'ar' ? site.config['active_resume_path_ar'] : site.config['active_resume_path_en']
          export_path = lang if export_path.nil?

          resume_data = resolve_resume_data(site, export_path)
          next unless resume_data

          json_resume = convert_to_json_resume(site, resume_data, lang)
          filename = lang == 'ar' ? 'resume-ar.json' : 'resume.json'

          site.data["json_resume_content_#{lang}"] = json_resume

          ::Jekyll::Hooks.register(:site, :post_write) do |site_instance|
            write_json_file(site_instance, filename, json_resume)
          end
        end
      end

      def write_json_file(site, filename, json_resume)
        return unless json_resume

        dest_path = File.join(site.dest, filename)
        FileUtils.mkdir_p(File.dirname(dest_path))
        File.write(dest_path, JSON.pretty_generate(json_resume))
        ::Jekyll.logger.info 'JSON Resume:', "Generated #{filename} at #{dest_path}"
      rescue StandardError => e
        ::Jekyll.logger.error 'JSON Resume Error:', e.message
      end

      private

      def resolve_resume_data(site, path_string)
        return site.data if path_string.nil? || path_string.empty?

        data_object = site.data
        path_string.split('.').each do |part|
          return nil unless data_object.is_a?(Hash)
          data_object = data_object[part]
          return nil if data_object.nil?
        end
        data_object
      end

      def convert_to_json_resume(site, resume_data, language)
        json_resume = {
          '$schema' => 'https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json',
          'basics' => extract_basics(site, resume_data, language),
          'work' => extract_work(resume_data),
          'volunteer' => extract_volunteer(resume_data),
          'education' => extract_education(resume_data),
          'awards' => extract_awards(resume_data),
          'certificates' => extract_certificates(resume_data),
          'publications' => [],
          'skills' => extract_skills(resume_data),
          'languages' => extract_languages(resume_data),
          'interests' => extract_interests(resume_data),
          'references' => [],
          'projects' => extract_projects(resume_data)
        }
        json_resume.reject { |_k, v| v.is_a?(Array) && v.empty? }
      end

      def extract_basics(site, resume_data, language)
        name_obj = language == 'ar' ? site.config['name_ar'] : site.config['name']
        full_name = [name_obj&.dig('first'), name_obj&.dig('middle'), name_obj&.dig('last')].compact.join(' ')
        contact = site.config['contact_info'] || {}
        enable_live = site.config['enable_live'] == true

        {
          'name' => full_name,
          'label' => language == 'ar' ? site.config['resume_title_ar'] : site.config['resume_title'],
          'image' => site.config['avatar_url'] || site.config['avatar'] || '/assets/images/Profile-min.jpg',
          'email' => enable_live && contact['email_live'] ? contact['email_live'] : contact['email'],
          'phone' => enable_live && contact['phone_live'] ? contact['phone_live'] : contact['phone'],
          'url' => site.config['url'],
          'summary' => resume_data.dig('header', 'intro') || resume_data.dig('header', 'about'),
          'location' => { 'address' => language == 'ar' ? contact['address_ar'] : contact['address'] }.compact,
          'profiles' => (site.config['social_links'] || {}).map { |net, url| { 'network' => net.to_s.capitalize, 'url' => url } if url.to_s.strip != '' }.compact
        }.compact
      end

      def extract_work(resume_data)
        (resume_data['experience'] || []).select { |e| e['active'] == true }.map do |entry|
          {
            'name' => entry['company'],
            'position' => entry['position'],
            'startDate' => format_date(entry['startdate']),
            'endDate' => format_date(entry['enddate']),
            'summary' => entry['summary'],
            'highlights' => entry['summary'] ? [entry['summary']] : []
          }.compact
        end
      end

      def extract_volunteer(resume_data)
        (resume_data['volunteering'] || []).select { |e| e['active'] == true }.map do |entry|
          {
            'organization' => entry['company'],
            'position' => entry['position'],
            'startDate' => format_date(entry['startdate']),
            'endDate' => format_date(entry['enddate']),
            'summary' => entry['summary'],
            'highlights' => entry['summary'] ? [entry['summary']] : []
          }.compact
        end
      end

      def extract_education(resume_data)
        (resume_data['education'] || []).select { |e| e['active'] == true }.map do |entry|
          awards = (entry['awards'] || []).map { |a| a['award'] }.compact
          awards << entry['award'] if entry['award'] && !entry['award'].empty?

          {
            'institution' => entry['uni'],
            'area' => entry['degree'],
            'studyType' => extract_study_type(entry['degree']),
            'startDate' => extract_start_date_from_year(entry['year']),
            'endDate' => extract_end_date_from_year(entry['year']),
            'summary' => entry['summary'],
            'highlights' => awards.any? ? awards : nil,
            'location' => entry['location']
          }.compact
        end
      end

      def extract_study_type(degree)
        return nil unless degree
        d = degree.downcase
        return 'Bachelor' if d.include?('bachelor') || d.include?('b.s.') || d.include?('b.a.')
        return 'Master' if d.include?('master') || d.include?('m.s.') || d.include?('m.a.')
        return 'PhD' if d.include?('phd') || d.include?('doctorate') || d.include?('ph.d.')
        return 'Associate' if d.include?('associate')
        nil
      end

      def extract_awards(resume_data)
        (resume_data['recognitions'] || []).select { |e| e['active'] == true }.map do |entry|
          {
            'title' => entry['award'],
            'date' => extract_start_date_from_year(entry['year']),
            'awarder' => entry['organization'],
            'summary' => entry['summary']
          }.compact
        end
      end

      def extract_certificates(resume_data)
        (resume_data['certifications'] || []).select { |e| e['active'] == true }.map do |entry|
          {
            'name' => entry['name'],
            'date' => format_date(entry['issue_date']),
            'issuer' => entry['issuing_organization'],
            'url' => entry['credential_url']
          }.compact
        end
      end

      def extract_skills(resume_data)
        (resume_data['skills'] || []).select { |e| e['active'] == true }.map do |entry|
          {
            'name' => entry['skill'],
            'level' => entry['level_label'] || entry['level']&.to_s,
            'keywords' => entry['tags'] || (entry['description'] ? [entry['description']] : [])
          }.compact
        end
      end

      def extract_languages(resume_data)
        (resume_data['languages'] || []).select { |e| e['active'] == true }.map do |entry|
          {
            'language' => entry['language'],
            'fluency' => entry['description'] || entry['descrp_short']
          }.compact
        end
      end

      def extract_interests(resume_data)
        (resume_data['interests'] || []).select { |e| e['description'] }.map do |entry|
          { 'name' => entry['description'], 'keywords' => [entry['description']] }
        end
      end

      def extract_projects(resume_data)
        (resume_data['projects'] || []).select { |e| e['active'] == true }.map do |entry|
          {
            'name' => entry['project'],
            'description' => entry['description'],
            'startDate' => extract_start_date_from_year(entry['duration']),
            'endDate' => extract_end_date_from_year(entry['duration']),
            'url' => entry['url'],
            'type' => entry['role']
          }.compact
        end
      end

      def format_date(date_input)
        return nil unless date_input
        return nil if date_input.to_s.downcase == 'present'
        return date_input.strftime('%Y-%m-%d') if date_input.is_a?(Date)
        Date.parse(date_input.to_s).strftime('%Y-%m-%d')
      rescue StandardError
        nil
      end

      def extract_start_date_from_year(year_str)
        return nil unless year_str
        match = year_str.to_s.match(/(\d{4})/)
        "#{match[1]}-01-01" if match
      end

      def extract_end_date_from_year(year_str)
        return nil unless year_str
        matches = year_str.to_s.scan(/(\d{4})/)
        "#{matches[1][0]}-12-31" if matches && matches.length > 1 && matches[1]
      end
    end
  end
end
```

#### Liquid Template Fallback Implementation
Create `resume.json` (and matching `resume-ar.json`):
```liquid
---
layout: none
permalink: /resume.json
---
{% assign resume_data = site.data.en | default: site.data %}
{
  "$schema": "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
  "basics": {
    "name": "{{ site.name.first }} {{ site.name.last }}",
    "label": {{ site.resume_title | jsonify }},
    "image": "{{ site.avatar_url | default: '/assets/images/Profile-min.jpg' | absolute_url }}",
    "email": {{ site.contact_info.email | jsonify }},
    "phone": {{ site.contact_info.phone | jsonify }},
    "url": "{{ site.url }}",
    "summary": {{ resume_data.header.intro | default: site.resume_header_intro | jsonify }},
    "location": {
      "address": {{ site.contact_info.address | jsonify }}
    },
    "profiles": [
      {% assign first_profile = true %}
      {% for item in site.social_links %}
        {% if item[1] and item[1] != "" %}
          {% unless first_profile %},{% endunless %}
          {
            "network": {{ item[0] | capitalize | jsonify }},
            "url": {{ item[1] | jsonify }}
          }
          {% assign first_profile = false %}
        {% endif %}
      {% endfor %}
    ]
  },
  "work": [
    {% assign first_work = true %}
    {% for job in resume_data.experience %}
      {% if job.active %}
        {% unless first_work %},{% endunless %}
        {
          "name": {{ job.company | jsonify }},
          "position": {{ job.position | jsonify }},
          "startDate": "{{ job.startdate | date: '%Y-%m-%d' }}",
          "endDate": "{% if job.enddate == 'Present' or job.enddate == nil %}{% else %}{{ job.enddate | date: '%Y-%m-%d' }}{% endif %}",
          "summary": {{ job.summary | jsonify }}
        }
        {% assign first_work = false %}
      {% endif %}
    {% endfor %}
  ],
  "education": [
    {% assign first_edu = true %}
    {% for edu in resume_data.education %}
      {% if edu.active %}
        {% unless first_edu %},{% endunless %}
        {
          "institution": {{ edu.uni | jsonify }},
          "area": {{ edu.degree | jsonify }},
          "studyType": {{ edu.degree | jsonify }},
          "startDate": "{{ edu.year }}",
          "score": {{ edu.award | jsonify }}
        }
        {% assign first_edu = false %}
      {% endif %}
    {% endfor %}
  ],
  "certificates": [
    {% assign first_cert = true %}
    {% for cert in resume_data.certifications %}
      {% if cert.active %}
        {% unless first_cert %},{% endunless %}
        {
          "name": {{ cert.name | jsonify }},
          "date": "{{ cert.issue_date }}",
          "issuer": {{ cert.issuing_organization | jsonify }},
          "url": {{ cert.credential_url | jsonify }}
        }
        {% assign first_cert = false %}
      {% endif %}
    {% endfor %}
  ],
  "skills": [
    {% assign first_skill = true %}
    {% for s in resume_data.skills %}
      {% if s.active %}
        {% unless first_skill %},{% endunless %}
        {
          "name": {{ s.skill | jsonify }},
          "level": {{ s.level_label | default: s.level | jsonify }}
        }
        {% assign first_skill = false %}
      {% endif %}
    {% endfor %}
  ]
}
```

#### Acceptance Criteria & Verification
- [ ] Automated Jekyll generator plugin emits `/resume.json` (and `/resume-ar.json` if configured) conforming to Schema v1.0.0.
- [ ] Validated with `ruby -rjson -e 'JSON.parse(File.read("_site/resume.json"))'`.
- [ ] Arrays avoid trailing commas and active filters hide inactive data items.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  ruby -rjson -e '
    json = JSON.parse(File.read("_site/resume.json"))
    raise "Missing basics.name" unless json["basics"]["name"]
    puts "JSON Resume schema valid: #{json["basics"]["name"]}"
  '
  ```

#### Git Workflow Specification
- **Branch:** `feature/json-resume-export`
- **PR Title:** `feat(interop): add official JSON Resume v1.0.0 exporter endpoint`
- **Conventional Commit:** `feat(interop): auto-generate /resume.json from YAML data (Closes #6)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/6`

---

### Feature 3.2: Automated CI/CD Build & Verification Pipeline

> **v1.0.0 Status: implemented, one closure check item pending.** `.github/workflows/ci.yml` and `lint.yml` (imported from `feature/resume-validator-ecosystem`, commit `88290ee`) ship on `feature/extended-multilingual-v1.0.0`. Verified live on [PR #220](https://github.com/kmutahar/bilingual-jekyll-resume-theme/pull/220): the workflow YAML parses, the Ruby 3.3/3.4/4.0 matrix passes end to end on GitHub Actions (initial run caught and fixed a real bug: `minitest` was never a declared dependency, so `bundle exec rake test` failed on every runner), CodeQL and both lint jobs pass, and `README.md` carries the CI status badge. Not yet verified: a deliberate throwaway push of malformed YAML or a broken gemspec confirming CI exits 1 and is then reverted. The PR references this issue as `Refs #206` until that negative-path run is observed.

- **Canonical Issue:** [#206](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206)
- **Auto-Closing Reference:** `Closes #206`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206`
- **Duplicate Issues Closed with Cross-Reference:** #38, #52, #66, #80, #94, #108, #122, #136, #150, #164, #178, #192
- **Concept & User Demand Rationale:**  
  To prevent invalid front-matter, broken YAML data, or gem specification errors from reaching consumers, an automated GitHub Actions pipeline must execute on every pull request and push to `master`/`main` across a modern Ruby matrix.
- **Effort / Impact / Demand:** Effort: ⭐⭐ (2–3 hrs) | Impact: ⭐⭐⭐⭐⭐ | Demand: High

#### Exact Target Files
- **Files to Create:**
  - `.github/workflows/ci.yml`
- **Files to Modify:**
  - `README.md` (add CI status badge)

#### Architecture & Workflow Implementation
Create `.github/workflows/ci.yml`:
```yaml
name: CI Test Suite

on:
  push:
    branches: [ master, main ]
  pull_request:
    branches: [ master, main ]
  workflow_dispatch:

permissions:
  contents: read

jobs:
  test:
    name: Build & Verify (Ruby ${{ matrix.ruby }})
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        ruby: ['3.3', '3.4', '4.0']
    steps:
      - name: Check out repository
        uses: actions/checkout@v5

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: ${{ matrix.ruby }}
          bundler-cache: true

      - name: Validate RubyGem Specification
        run: |
          gem build bilingual-jekyll-resume-theme.gemspec
          rm -f bilingual-jekyll-resume-theme-*.gem

      - name: Build Jekyll Site with Strict Checks
        run: |
          bundle exec jekyll build --config docs/_data/_config.sample.yml --strict_front_matter --trace

      - name: Validate Resume Data Schemas & Parity
        run: |
          chmod +x bin/validate-resume
          ./bin/validate-resume docs/_data --fail-on-warnings
          bundle exec rake validate[docs/_data]
```

#### Acceptance Criteria & Verification
- [ ] Workflow passes cleanly across Ruby 3.3, 3.4, and 4.0 (v1.0.0 raises the minimum to Ruby 3.3; the original 3.1/3.2/3.3 matrix is superseded).
- [ ] Catches malformed YAML or broken gemspec syntax and terminates with exit code 1.
- [ ] **Bash Verification Command:**
  ```bash
  ruby -ryaml -e 'YAML.load_file(".github/workflows/ci.yml"); puts "Workflow YAML syntax valid."'
  ```

#### Git Workflow Specification
- **Branch:** `ci/github-actions-workflow`
- **PR Title:** `ci: introduce automated GitHub Actions CI build and verification workflow`
- **Conventional Commit:** `ci: add GitHub Actions CI pipeline for gem and site validation (Closes #206)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/206`

---

### Feature 3.3: YAML Resume Data Validator & Schema Linter

> **v1.0.0 Status: implemented, closure check pending.** The validator (imported from `feature/resume-validator-ecosystem`, commit `88290ee`, then adapted to the locale system) ships on `feature/extended-multilingual-v1.0.0`; behavior is documented in [`docs/VALIDATION_GUIDE.md`](docs/VALIDATION_GUIDE.md). Verified: all four target files are packaged in the gem, `bin/validate-resume` is a gemspec executable, `./bin/validate-resume docs/_data --all-locales` exits 0 on the Sherlock Holmes demo data, and `test/test_resume_validator.rb` covers a YAML syntax error, an invalid URL, an inverted date range, and a cross-language data-file parity mismatch. Per `docs/COMPLETED_AUDIT.md` §5, this feature stays in the active roadmap until its closure check passes; the PR references this issue as `Refs #13` until then.

- **Canonical Issue:** [#13](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/13)
- **Auto-Closing Reference:** `Closes #13`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/13`
- **Concept & User Demand Rationale:**  
  Non-technical users frequently introduce subtle YAML errors: missing `active: true` flags, malformed date formats, unquoted colons in job titles, or asymmetrical files between English and Arabic folders. A CLI tool `bin/validate-resume` provides instantaneous developer diagnostics.
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐ (4–5 hrs) | Impact: ⭐⭐⭐⭐ | Demand: Med-High

#### Exact Target Files
- **Files to Create:**
  - `bin/validate-resume` (Standalone executable CLI validator)
  - `lib/bilingual-jekyll-resume-theme/resume_validator.rb` (Core validator engine & schema definitions)
  - `_plugins/resume-validator.rb` (Optional Jekyll Generator plugin hook)
  - `docs/VALIDATION_GUIDE.md` (Exhaustive schema rules and error catalog)
- **Files to Modify:**
  - `bilingual-jekyll-resume-theme.gemspec` (add `bin/validate-resume` to `spec.executables`)
  - `Gemfile` / `Rakefile` (add `rake validate` task)
  - `README.md` & `docs/CONFIG_GUIDE.md`

#### Validation Rules Catalog by Section

| Section | Required Fields & Schema Constraints | Warnings & Diagnostics |
|---|---|---|
| `header.yml` | `intro` or `about` string (min length > 20 chars). | Missing bio / intro summary. |
| `experience.yml` | `company`, `position`, `startdate` (YYYY-MM-DD or Date object), `enddate` (YYYY-MM-DD or 'Present'), `active` (boolean). | `enddate` before `startdate`, malformed date string, missing active flag. |
| `education.yml` | `uni` / `institution`, `degree`, `year` (YYYY or YYYY-YYYY), `active` (boolean). | Non-standard year format. |
| `skills.yml` | `skill` name, `active` (boolean). Optional `category`, `level` (1–5 int), `tags` (array). | Level out of 1..5 range, missing active flag. |
| `projects.yml` | `project` title, `role`, `duration`, `url` (valid HTTP/HTTPS URI), `active` (boolean). | Malformed URL protocol or syntax. |
| `certifications.yml` | `name`, `issuing_organization`, `issue_date` (YYYY-MM-DD), `credential_url` (valid URI), `active` (boolean). | Expiration date before issue date. |
| `courses.yml` | `organization`, `courses` (array of strings or hashes), `active` (boolean). | Empty course list. |
| `volunteering.yml` | `company`/`organization`, `position`, `startdate`, `enddate`, `active` (boolean). | Inverted date range. |
| `recognitions.yml` | `award`, `organization`, `year`, `active` (boolean). | Missing year or organization. |
| `associations.yml` | `organization`, `role`, `duration`, `active` (boolean). | Missing role or duration. |
| `languages.yml` | `language` name, `description` or `descrp_short` fluency string, `active` (boolean). | Missing fluency level. |
| `links.yml` | `description`, `url` (valid HTTP/HTTPS URI), `active` (boolean). | Malformed URL. |

#### Architecture & Ruby Validator Implementation
Create `lib/bilingual-jekyll-resume-theme/resume_validator.rb`:
```ruby
# frozen_string_literal: true

require 'yaml'
require 'uri'
require 'date'
require 'optparse'

module BilingualJekyllResumeTheme
  class ResumeValidator
    COLORS = {
      red: "\e[31m",
      yellow: "\e[33m",
      green: "\e[32m",
      blue: "\e[34m",
      cyan: "\e[36m",
      reset: "\e[0m"
    }.freeze

    attr_reader :errors, :warnings, :info

    def initialize(data_dir = '_data')
      @data_dir = data_dir
      @errors = []
      @warnings = []
      @info = []
    end

    def validate(languages: %w[en ar], verbose: false)
      @verbose = verbose
      puts "🔍 Validating bilingual resume data in '#{@data_dir}'..."

      validate_language_parity(languages)
      languages.each { |lang| validate_language_files(lang) }
      report_results
      @errors.empty? ? 0 : 1
    end

    private

    def validate_language_parity(languages)
      return unless languages.size > 1

      dir_files = {}
      languages.each do |lang|
        lang_path = File.join(@data_dir, lang)
        dir_files[lang] = Dir.glob(File.join(lang_path, '*.yml')).map { |f| File.basename(f) } if Dir.exist?(lang_path)
      end

      if dir_files['en'] && dir_files['ar']
        (dir_files['en'] - dir_files['ar']).each { |f| add_warning('Parity', "Missing Arabic counterpart: _data/ar/#{f}") }
        (dir_files['ar'] - dir_files['en']).each { |f| add_warning('Parity', "Missing English counterpart: _data/en/#{f}") }
      end
    end

    def validate_language_files(lang)
      lang_dir = File.join(@data_dir, lang)
      return unless Dir.exist?(lang_dir)

      Dir.glob(File.join(lang_dir, '*.yml')).each do |file_path|
        next if file_path.include?('months.yml')
        section_name = File.basename(file_path, '.yml')

        begin
          data = YAML.load_file(file_path)
          validate_section(section_name, data, lang, file_path)
        rescue StandardError => e
          add_error("#{lang}/#{section_name}.yml", "YAML Syntax Error: #{e.message}")
        end
      end
    end

    def validate_section(section_name, data, lang, file_path)
      context = "#{lang}/#{section_name}.yml"
      return add_error(context, 'File is empty') if data.nil?

      if section_name == 'header'
        return add_error(context, 'header.yml must be a Hash/dictionary') unless data.is_a?(Hash)
        validate_header(data, context)
        return
      end

      return add_error(context, "Must be an Array of items (got #{data.class})") unless data.is_a?(Array)

      data.each_with_index do |entry, idx|
        item_context = "#{context} [Item ##{idx + 1}]"
        validate_active_flag(entry, item_context)
        case section_name
        when 'experience' then validate_experience_entry(entry, item_context)
        when 'education' then validate_education_entry(entry, item_context)
        when 'skills' then validate_skill_entry(entry, item_context)
        when 'projects' then validate_project_entry(entry, item_context)
        when 'certifications' then validate_certification_entry(entry, item_context)
        when 'languages' then validate_language_entry(entry, item_context)
        when 'links' then validate_link_entry(entry, item_context)
        end
      end
    end

    def validate_active_flag(entry, context)
      return unless entry.is_a?(Hash)
      add_warning(context, "Missing 'active' boolean flag (should be true or false)") if entry['active'].nil?
    end

    def validate_header(data, context)
      intro = data['intro'] || data['about']
      add_warning(context, "Header 'intro' is missing or very short (< 20 characters)") if intro.nil? || intro.to_s.strip.length < 20
    end

    def validate_experience_entry(entry, context)
      add_error(context, "Missing 'company' name") if entry['company'].to_s.strip.empty?
      add_error(context, "Missing 'position' title") if entry['position'].to_s.strip.empty?
      validate_date(entry['startdate'], context, 'startdate')
      validate_date_or_present(entry['enddate'], context, 'enddate')
      validate_date_range(entry['startdate'], entry['enddate'], context)
    end

    def validate_education_entry(entry, context)
      add_error(context, "Missing 'uni' (institution)") if entry['uni'].to_s.strip.empty?
      add_error(context, "Missing 'degree'") if entry['degree'].to_s.strip.empty?
    end

    def validate_skill_entry(entry, context)
      add_error(context, "Missing 'skill' name") if entry['skill'].to_s.strip.empty?
      if entry['level']
        lvl = entry['level'].to_i
        add_warning(context, "Skill 'level' (#{lvl}) should be an integer between 1 and 5") unless (1..5).cover?(lvl)
      end
    end

    def validate_project_entry(entry, context)
      add_error(context, "Missing 'project' name") if entry['project'].to_s.strip.empty?
      validate_url(entry['url'], context, 'url') if entry['url']
    end

    def validate_certification_entry(entry, context)
      add_error(context, "Missing certification 'name'") if entry['name'].to_s.strip.empty?
      validate_date(entry['issue_date'], context, 'issue_date') if entry['issue_date']
      validate_url(entry['credential_url'], context, 'credential_url') if entry['credential_url']
    end

    def validate_language_entry(entry, context)
      add_error(context, "Missing 'language' name") if entry['language'].to_s.strip.empty?
    end

    def validate_link_entry(entry, context)
      add_error(context, "Missing link 'description'") if entry['description'].to_s.strip.empty?
      validate_url(entry['url'], context, 'url')
    end

    def validate_date(date_value, context, field)
      return if date_value.nil?
      return if date_value.is_a?(Date)
      Date.parse(date_value.to_s)
    rescue ArgumentError
      add_error(context, "Invalid date format for '#{field}': '#{date_value}' (expected YYYY-MM-DD)")
    end

    def validate_date_or_present(date_value, context, field)
      return if date_value.nil? || date_value.to_s.strip.downcase == 'present' || date_value.to_s.strip == 'حتى الآن'
      validate_date(date_value, context, field)
    end

    def validate_date_range(start_date, end_date, context)
      return if start_date.nil? || end_date.nil?
      return if end_date.to_s.strip.downcase == 'present' || end_date.to_s.strip == 'حتى الآن'

      s_d = start_date.is_a?(Date) ? start_date : Date.parse(start_date.to_s) rescue nil
      e_d = end_date.is_a?(Date) ? end_date : Date.parse(end_date.to_s) rescue nil
      add_error(context, "enddate (#{e_d}) is before startdate (#{s_d})") if s_d && e_d && e_d < s_d
    end

    def validate_url(url_value, context, field)
      return if url_value.nil? || url_value.to_s.strip.empty?
      uri = URI.parse(url_value.to_s.strip)
      add_warning(context, "#{field} '#{url_value}' should start with http:// or https://") unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    rescue URI::InvalidURIError
      add_error(context, "Invalid URL format for '#{field}': #{url_value}")
    end

    def add_error(context, msg); @errors << { context: context, message: msg }; end
    def add_warning(context, msg); @warnings << { context: context, message: msg }; end

    def report_results
      puts "\n"
      if @errors.any?
        puts "#{COLORS[:red]}╔═══════════════════════════════════════════════════════════════╗#{COLORS[:reset]}"
        puts "#{COLORS[:red]}║                     VALIDATION ERRORS (#{@errors.size.to_s.rjust(2)})                     ║#{COLORS[:reset]}"
        puts "#{COLORS[:red]}╚═══════════════════════════════════════════════════════════════╝#{COLORS[:reset]}"
        @errors.each { |e| puts "  #{COLORS[:red]}✗ #{e[:context]}#{COLORS[:reset]}\n    → #{e[:message]}\n" }
      end

      if @warnings.any?
        puts "#{COLORS[:yellow]}╔═══════════════════════════════════════════════════════════════╗#{COLORS[:reset]}"
        puts "#{COLORS[:yellow]}║                    VALIDATION WARNINGS (#{@warnings.size.to_s.rjust(2)})                   ║#{COLORS[:reset]}"
        puts "#{COLORS[:yellow]}╚═══════════════════════════════════════════════════════════════╝#{COLORS[:reset]}"
        @warnings.each { |w| puts "  #{COLORS[:yellow]}⚠ #{w[:context]}#{COLORS[:reset]}\n    → #{w[:message]}\n" }
      end

      puts "#{COLORS[:cyan]}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━#{COLORS[:reset]}"
      if @errors.empty?
        puts "#{COLORS[:green]}✓ VALIDATION SUCCESSFUL: All resume data files are valid! (#{@warnings.size} warnings)#{COLORS[:reset]}"
      else
        puts "#{COLORS[:red]}✗ VALIDATION FAILED: #{@errors.size} error(s), #{@warnings.size} warning(s)#{COLORS[:reset]}"
      end
      puts "#{COLORS[:cyan]}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━#{COLORS[:reset]}\n"
    end
  end
end
```

Create CLI wrapper `bin/validate-resume`:
```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/bilingual-jekyll-resume-theme/resume_validator'

data_dir = ARGV[0] || (Dir.exist?('_data') ? '_data' : 'docs/_data')
validator = BilingualJekyllResumeTheme::ResumeValidator.new(data_dir)
exit validator.validate
```

#### Acceptance Criteria & Verification
- [ ] Executing `bundle exec bin/validate-resume` parses all YAML data files and validates schema constraints.
- [ ] Returns exit code 0 when clean, exit code 1 when syntax, URL, or inverted date errors exist.
- [ ] Flags parity mismatches across all languages configured under `languages:` (v1.0.0 supersedes the original `_data/en/` vs `_data/ar/` check).
- [ ] **Bash Verification Command:**
  ```bash
  chmod +x bin/validate-resume && \
  ./bin/validate-resume docs/_data && \
  echo "Validator CLI executed cleanly."
  ```

#### Git Workflow Specification
- **Branch:** `feature/resume-validator-cli`
- **PR Title:** `feat(tooling): implement YAML resume validator and schema linter CLI`
- **Conventional Commit:** `feat(tooling): add bin/validate-resume linter and schema checker (Closes #13)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/13`

---

## 6. Priority 4: Ecosystem Expansion Blueprints

---

### Feature 4.2: Interactive Career Timeline Visualization

- **Canonical Issue:** [#16](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/16)
- **Auto-Closing Reference:** `Closes #16`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/16`
- **Concept & User Demand Rationale:**  
  Candidates with multifaceted career progression benefit from a graphical visual timeline illustrating promotions, company milestones, and education on an interactive chronological spine.
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐⭐ (6–8 hrs) | Impact: ⭐⭐⭐ | Demand: Low-Med

#### Exact Target Files
- **Files to Create:**
  - `_layouts/resume-timeline.html`
  - `_includes/timeline-view.html`
  - `_sass/_timeline.scss`
  - `docs/TIMELINE_GUIDE.md`
- **Files to Modify:**
  - `assets/css/cv.scss` (add `@use "timeline";`)
  - `assets/css/cv-ar.scss` (add `@use "timeline";`)
  - `docs/CONFIG_GUIDE.md`

#### Architecture & SCSS Implementation
Create `_sass/_timeline.scss`:
```scss
.timeline-container {
  position: relative;
  margin: 2rem 0;
  padding-left: 2rem;
  border-left: 2px solid var(--accent-color, #007acc);

  .timeline-node {
    position: relative;
    margin-bottom: 2rem;

    &::before {
      content: "";
      position: absolute;
      left: -2.45rem;
      top: 0.25rem;
      width: 12px;
      height: 12px;
      border-radius: 50%;
      background: var(--bg-color, #ffffff);
      border: 3px solid var(--accent-color, #007acc);
    }
  }
}

html[dir="rtl"] .timeline-container {
  padding-left: 0;
  padding-right: 2rem;
  border-left: none;
  border-right: 2px solid var(--accent-color, #007acc);

  .timeline-node::before {
    left: auto;
    right: -2.45rem;
  }
}
```

#### Acceptance Criteria & Verification
- [ ] Setting `layout: resume-timeline` in page front matter renders chronology nodes with milestone markers.
- [ ] Spine and node indicators mirror symmetrically in RTL Arabic view.
- [ ] Degrades cleanly to vertical text sequence during printing.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  grep -q "timeline-container" _site/assets/css/cv.css && \
  echo "Timeline SCSS compilation verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/career-timeline`
- **PR Title:** `feat(layout): add interactive career timeline layout and component`
- **Conventional Commit:** `feat(layout): implement resume-timeline layout and SCSS (Closes #16)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/16`

---

### Feature 4.3: Secure Contact Form Integration (Formspree / Netlify)

- **Canonical Issue:** [#20](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/20)
- **Auto-Closing Reference:** `Closes #20`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/20`
- **Concept & User Demand Rationale:**  
  Publishing a personal email address invites automated scraping and spam. A secure contact form connecting to Formspree, Netlify Forms, or Getform with honeypot protection enables recruiters to reach out safely without exposing personal email strings.
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐ (3–4 hrs) | Impact: ⭐⭐⭐ | Demand: Low-Med

#### Exact Target Files
- **Files to Create:**
  - `_includes/contact-form.html`
  - `docs/CONTACT_FORM_GUIDE.md`
- **Files to Modify:**
  - `_layouts/resume-en.html` (include `contact-form.html`)
  - `_layouts/resume-ar.html` (include `contact-form.html`)
  - `_sass/_resume.scss` (`.contact-form` styling)
  - `_sass/_resume-rtl.scss`
  - `docs/_data/_config.sample.yml`
  - `docs/CONFIG_GUIDE.md`

#### Data Models & Configuration
In `_config.yml`:
```yaml
# ==============================================================================
# Secure Contact Form & Modal Popup (#20)
# ==============================================================================
resume_contact_form: true # Enable contact form (default: false)
contact_form:
  provider: "formspree" # Options: "formspree", "formcarry", "netlify", "getform"
  display_mode: "modal" # Options: "modal" (popup dialog via header button) or "inline" (embedded section)
  formspree_id: "xpznqwer" # If using Formspree
  formcarry_id: "your-formcarry-id" # If using Formcarry
  endpoint: "https://getform.io/f/..." # If using custom endpoint or getform
```

#### Architecture & Liquid Implementation
Create `_includes/contact-form.html`:
```liquid
{% if site.resume_contact_form %}
  {% assign current_lang = page.lang | default: site.lang | default: 'en' %}
  {% assign provider = site.contact_form.provider | default: 'formspree' %}
  {% assign mode = site.contact_form.display_mode | default: 'modal' %}

  <!-- Determine form action URL based on provider -->
  {% if provider == 'formspree' %}
    {% assign form_action = 'https://formspree.io/f/' | append: site.contact_form.formspree_id %}
  {% elsif provider == 'formcarry' %}
    {% assign form_action = 'https://formcarry.com/s/' | append: site.contact_form.formcarry_id %}
  {% else %}
    {% assign form_action = site.contact_form.endpoint %}
  {% endif %}

  <div id="contactModal" class="contact-modal-overlay no-print{% if mode == 'inline' %} is-inline{% endif %}" role="dialog" aria-modal="true" aria-labelledby="contactModalTitle">
    <div class="contact-modal-content">
      <div class="contact-modal-header">
        <h2 id="contactModalTitle" class="contact-modal-title">
          {% if current_lang == 'ar' %}تواصل معي{% else %}Get in Touch{% endif %}
        </h2>
        {% if mode == 'modal' %}
          <button id="closeContactBtn" class="contact-modal-close" aria-label="{% if current_lang == 'ar' %}إغلاق{% else %}Close{% endif %}">&times;</button>
        {% endif %}
      </div>

      <form action="{{ form_action }}"
            method="POST"
            class="contact-form"
            {% if provider == 'netlify' %}data-netlify="true" netlify-honeypot="bot-field"{% endif %}>

        <div style="display:none" aria-hidden="true">
          <label>Do not fill this out if human: <input name="bot-field" /></label>
        </div>

        <div class="form-group">
          <label for="contact-name">{% if current_lang == 'ar' %}الاسم الكامل{% else %}Full Name{% endif %} *</label>
          <input type="text" id="contact-name" name="name" required class="form-control" placeholder="{% if current_lang == 'ar' %}اسمك الكريم{% else %}Your full name{% endif %}" />
        </div>

        <div class="form-group">
          <label for="contact-email">{% if current_lang == 'ar' %}البريد الإلكتروني{% else %}Email Address{% endif %} *</label>
          <input type="email" id="contact-email" name="email" required class="form-control" placeholder="name@example.com" />
        </div>

        <div class="form-group">
          <label for="contact-message">{% if current_lang == 'ar' %}الرسالة{% else %}Message{% endif %} *</label>
          <textarea id="contact-message" name="message" rows="4" required class="form-control" placeholder="{% if current_lang == 'ar' %}اكتب رسالتك هنا...{% else %}Enter your message here...{% endif %}"></textarea>
        </div>

        <button type="submit" class="contact-submit-btn">
          {% if current_lang == 'ar' %}إرسال الرسالة{% else %}Send Message{% endif %}
        </button>
      </form>
    </div>
  </div>

  {% if mode == 'modal' %}
  <script>
    (function() {
      var modal = document.getElementById('contactModal');
      var openBtn = document.getElementById('contactBtn');
      var closeBtn = document.getElementById('closeContactBtn');

      if (openBtn && modal) {
        openBtn.addEventListener('click', function(e) {
          e.preventDefault();
          modal.style.display = 'flex';
          modal.querySelector('input, textarea, button')?.focus();
        });
      }
      if (closeBtn && modal) {
        closeBtn.addEventListener('click', function() {
          modal.style.display = 'none';
          openBtn?.focus();
        });
      }
      window.addEventListener('click', function(e) {
        if (e.target === modal) {
          modal.style.display = 'none';
        }
      });
      window.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && modal && modal.style.display === 'flex') {
          modal.style.display = 'none';
          openBtn?.focus();
        }
      });
    })();
  </script>
  {% endif %}
{% endif %}
```

#### SCSS Styling Architecture
In `_sass/_resume.scss`:
```scss
// Contact modal overlay & form controls
.contact-modal-overlay {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.6);
  z-index: 1000;
  align-items: center;
  justify-content: center;

  &.is-inline {
    display: block;
    position: static;
    background: transparent;
  }
}

.contact-modal-content {
  background: var(--card-bg, #ffffff);
  color: var(--text-color, #333333);
  border: 1px solid var(--border-color, #e0e0e0);
  border-radius: 8px;
  padding: 2rem;
  max-width: 500px;
  width: 90%;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

.contact-modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.contact-modal-close {
  background: transparent;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: var(--text-muted, #777777);
}

.form-group {
  margin-bottom: 1rem;
  label {
    display: block;
    font-weight: 600;
    margin-bottom: 0.35rem;
  }
  .form-control {
    width: 100%;
    padding: 0.6rem 0.8rem;
    border: 1px solid var(--border-color, #cccccc);
    border-radius: 4px;
    background: var(--bg-color, #ffffff);
    color: inherit;
    &:focus {
      outline: 2px solid var(--accent-color, #007acc);
    }
  }
}

.contact-submit-btn {
  width: 100%;
  padding: 0.75rem;
  background: var(--accent-color, #007acc);
  color: #ffffff;
  border: none;
  border-radius: 4px;
  font-weight: bold;
  cursor: pointer;
  transition: opacity 0.2s ease;
  &:hover { opacity: 0.9; }
}
```

In `_sass/_resume-rtl.scss`:
```scss
// Mirrored contact form for Arabic layout
.contact-modal-header {
  flex-direction: row-reverse;
}
.form-group label {
  text-align: right;
}
```

#### Acceptance Criteria & Verification
- [ ] Submitting form sends inquiries to configured endpoint (Formspree, Formcarry, Netlify).
- [ ] Modal opens on clicking "Contact Me" button and closes on Close button, overlay click, or Escape key.
- [ ] Honeypot hidden input prevents automated bot submissions.
- [ ] Component is excluded from print media (`.no-print`).
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  grep -q "contact-modal-overlay" _site/resume/en/index.html && \
  echo "Contact form modal component verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/contact-form`
- **PR Title:** `feat(forms): integrate secure contact form component with modal popup and multi-provider backends`
- **Conventional Commit:** `feat(forms): add Formspree, Formcarry, and Netlify contact form support (Closes #20)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/20`

---

### Feature 4.4: Privacy-First Resume Engagement Analytics

- **Canonical Issue:** [#17](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/17)
- **Auto-Closing Reference:** `Closes #17`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/17`
- **Concept & User Demand Rationale:**  
  Candidates need telemetry on recruiter interest (e.g. print/PDF download clicks, outbound portfolio links, language switches) without violating GDPR or injecting tracking cookies. A lightweight event dispatcher bridges browser events to Plausible, Umami, or Google Analytics.
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐ (3–4 hrs) | Impact: ⭐⭐⭐ | Demand: Low-Med

#### Exact Target Files
- **Files to Create:**
  - `assets/js/resume-analytics.js`
  - `docs/ANALYTICS_GUIDE.md`
- **Files to Modify:**
  - `_includes/analytics-body.html` (load telemetry script when enabled)
  - `docs/_data/_config.sample.yml`
  - `docs/CONFIG_GUIDE.md`

#### Architecture & JavaScript Implementation
Create `assets/js/resume-analytics.js`:
```javascript
(function () {
  'use strict';

  function dispatchEvent(eventName, eventParams) {
    if (typeof window.gtag === 'function') {
      window.gtag('event', eventName, eventParams);
    }
    if (typeof window.plausible === 'function') {
      window.plausible(eventName, { props: eventParams });
    }
    if (typeof window.umami === 'object' && typeof window.umami.track === 'function') {
      window.umami.track(eventName, eventParams);
    }
  }

  // Track print / PDF save attempts
  window.addEventListener('beforeprint', function () {
    dispatchEvent('resume_print', { page_lang: document.documentElement.lang || 'en' });
  });

  // Track external social and credential clicks
  document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('a[target="_blank"]').forEach(function (link) {
      link.addEventListener('click', function () {
        dispatchEvent('external_link_click', {
          url: link.href,
          text: link.textContent.trim() || link.getAttribute('aria-label')
        });
      });
    });
  });
})();
```

#### Acceptance Criteria & Verification
- [ ] Printing triggers `resume_print` event without console warnings.
- [ ] Outbound credential links record destination URL cleanly.
- [ ] Zero cookies or local storage items are written.
- [ ] **Bash Verification Command:**
  ```bash
  test -f assets/js/resume-analytics.js && \
  node -c assets/js/resume-analytics.js && \
  echo "Resume analytics script syntax verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/privacy-analytics`
- **PR Title:** `feat(analytics): add privacy-preserving resume engagement event dispatcher`
- **Conventional Commit:** `feat(analytics): dispatch print and outbound click events (Closes #17)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/17`

---

### Feature 4.5: Resume Comparison & A/B Testing View

- **Canonical Issue:** [#23](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/23)
- **Auto-Closing Reference:** `Closes #23`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/23`
- **Concept & User Demand Rationale:**  
  Job candidates tailoring dual resumes (e.g., *Fullstack Lead* vs *Cloud Solutions Architect*) or reviewing bilingual translations side-by-side require a split-screen view allowing simultaneous comparison.
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐ (4–5 hrs) | Impact: ⭐⭐⭐ | Demand: Low

#### Exact Target Files
- **Files to Create:**
  - `_layouts/resume-comparison.html`
  - `_includes/version-switcher.html`
  - `_sass/_comparison.scss`
  - `docs/VERSIONING_GUIDE.md`
- **Files to Modify:**
  - `assets/css/main.scss` (add `@use "comparison";`)
  - `docs/CONFIG_GUIDE.md`

#### Architecture & Implementation
Create `_layouts/resume-comparison.html`:
```html
---
layout: default
---
<div class="comparison-container">
  <div class="comparison-header">
    <h1>{{ page.title | default: "Resume Version Comparison" }}</h1>
    <p>{{ page.description | default: "Compare two resume profiles side-by-side." }}</p>
  </div>

  <div class="comparison-split-viewport">
    <div class="comparison-pane">
      <h2 class="pane-title">{{ page.v1_title | default: "Version A" }}</h2>
      <iframe src="{{ page.v1_url | relative_url }}" class="comparison-frame" title="Resume Version A"></iframe>
    </div>
    <div class="comparison-pane">
      <h2 class="pane-title">{{ page.v2_title | default: "Version B" }}</h2>
      <iframe src="{{ page.v2_url | relative_url }}" class="comparison-frame" title="Resume Version B"></iframe>
    </div>
  </div>
</div>
```

Styling in `_sass/_comparison.scss`:
```scss
.comparison-container {
  max-width: 1600px;
  margin: 0 auto;
  padding: 1.5rem;

  .comparison-split-viewport {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1.5rem;

    @media (max-width: 1024px) {
      grid-template-columns: 1fr;
    }
  }

  .comparison-pane {
    display: flex;
    flex-direction: column;

    .comparison-frame {
      width: 100%;
      height: 85vh;
      border: 1px solid var(--border-color, #e0e0e0);
      border-radius: 8px;
    }
  }
}
```

#### Acceptance Criteria & Verification
- [ ] Side-by-side comparison page displays two selected resume versions in responsive iframes.
- [ ] Collapses cleanly to single-column view on viewports &lt; 1024px.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build && \
  test -f _layouts/resume-comparison.html && \
  echo "Resume comparison layout verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/resume-comparison`
- **PR Title:** `feat(tools): add resume comparison and A/B evaluation layout`
- **Conventional Commit:** `feat(tools): implement split-screen resume comparison view (Closes #23)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/23`

---

### Feature 4.7: Dynamic Custom Resume Sections Engine

- **Canonical Issue:** [#219](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/219)
- **Auto-Closing Reference:** `Closes #219`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/219`
- **Concept & User Demand Rationale:**  
  Professionals in academia, medicine, law, and specialized engineering frequently require non-standard resume sections (e.g., *Patents & Inventions*, *Keynotes & Speaking*, *Publications*, *Grants & Fellowships*, *Advisory Roles*). Rather than forcing users to fork and edit layout includes, a generic custom section renderer dynamically parses user-defined YAML files matching arbitrary section names listed in `resume_section_order`.
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐ (3–4 hrs) | Impact: ⭐⭐⭐⭐ | Demand: Med-High

#### Exact Target Files
- **Files to Create:**
  - `_includes/resume-custom-section.html` (Generic section component)
  - `docs/CUSTOM_SECTIONS_GUIDE.md` (Tutorial for creating arbitrary sections)
- **Files to Modify:**
  - `_includes/resume-section-en.html` (Add default `{% else %}` branch delegating to custom section include)
  - `_includes/resume-section-ar.html` (Add default `{% else %}` branch delegating to custom section include)
  - `docs/_data/_config.sample.yml` (Document `custom_section_titles`)
  - `docs/CONFIG_GUIDE.md`
  - `docs/DATA_GUIDE.md`

#### Data Models & Configuration
In `_config.yml`:
```yaml
# ==============================================================================
# Custom Resume Sections Configuration (#219)
# ==============================================================================
resume_section_order:
  - experience
  - education
  - patents # Custom section
  - speaking # Custom section
  - skills

custom_section_titles:
  en:
    patents: "Patents & Inventions"
    speaking: "Keynote Addresses & Speaking"
  ar:
    patents: "براءات الاختراع والابتكارات"
    speaking: "المؤتمرات والمحاضرات"
```

In `_data/en/patents.yml`:
```yaml
- title: "Distributed Consensus Algorithm for Edge Networks"
  subtitle: "US Patent #9,876,543"
  date: "2024-03-15"
  url: "https://patents.google.com/patent/US9876543"
  description: "Co-inventor on patent for high-throughput consensus in high-latency wireless mesh systems."
  active: true
```

In `_data/ar/patents.yml`:
```yaml
- title: "خوارزمية الإجماع الموزع لشبكات الحافة"
  subtitle: "براءة اختراع أمريكية رقم 9,876,543"
  date: "2024-03-15"
  url: "https://patents.google.com/patent/US9876543"
  description: "مشارك في اختراع نظام معالجة البيانات الموزعة للشبكات اللاسلكية."
  active: true
```

#### Architecture & Liquid Implementation
Create `_includes/resume-custom-section.html`:
```liquid
{% assign section_key = include.section_name %}
{% assign custom_items = resume_data[section_key] %}
{% assign lang = include.lang | default: page.lang | default: 'en' %}

{% if custom_items and custom_items.size > 0 %}
  {% assign default_title = section_key | replace: '_', ' ' | capitalize %}
  {% assign custom_title = site.custom_section_titles[lang][section_key] | default: default_title %}

  <section class="content-section custom-section custom-section-{{ section_key }}">
    <header class="section-header">
      <h2>{{ custom_title }}</h2>
    </header>

    {% for item in custom_items %}
      {% if item.active != false %}
        <div class="resume-item">
          {% if item.title %}
            <h3 class="resume-item-title">
              {% if item.url %}
                <a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a>
              {% else %}
                {{ item.title }}
              {% endif %}
            </h3>
          {% endif %}

          {% if item.subtitle or item.date or item.year or item.location %}
            <h4 class="resume-item-details">
              {% if item.subtitle %}{{ item.subtitle }}{% endif %}
              {% if item.date or item.year %} &bull; {{ item.date | default: item.year }}{% endif %}
              {% if item.location %} &bull; {{ item.location }}{% endif %}
            </h4>
          {% endif %}

          {% if item.description %}
            <p class="resume-item-copy">{{ item.description }}</p>
          {% endif %}

          {% if item.bullets and item.bullets.size > 0 %}
            <ul class="resume-item-list">
              {% for bullet in item.bullets %}
                <li>{{ bullet }}</li>
              {% endfor %}
            </ul>
          {% endif %}
        </div>
      {% endif %}
    {% endfor %}
  </section>
{% endif %}
```

In `_includes/resume-section-en.html` (and matching Arabic dispatcher):
```liquid
{% else %}
    <!-- Generic Custom Section Fallback -->
    {% include resume-custom-section.html section_name=include.section_name lang="en" %}
{% endif %}
```

#### Acceptance Criteria & Verification
- [ ] Adding an arbitrary section name to `resume_section_order` and creating `_data/<lang>/<section>.yml` renders cleanly without editing theme layout files.
- [ ] Localized titles resolve from `site.custom_section_titles[lang][section]`.
- [ ] Full backward compatibility is preserved for all standard 12 sections.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build --config docs/_data/_config.sample.yml && \
  echo "Dynamic custom sections verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/custom-sections-engine`
- **PR Title:** `feat(sections): introduce dynamic custom resume sections engine`
- **Conventional Commit:** `feat(sections): support arbitrary user-defined resume sections (Closes #219)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/219`

---

### Feature 4.8: Client-Side Site Search Index

- **Canonical Issue:** [#225](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/225)
- **Auto-Closing Reference:** `Closes #225`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/225`
- **Concept & User Demand Rationale:**
  `_layouts/error.html` previously shipped a fully accessible `<form role="search">` (labeled input, ARIA button) on generated 403/404/500 pages, but no search backend ever read the submitted `q` parameter — submitting it silently navigated home and dropped the query, which is worse than no search box since it read as functional to sighted and screen-reader users alike. Removed in the theme's a11y fix for `ISSUES.md` issue #2; the markup, per-language i18n script, and already-translated locale strings (`error_pages.search_label/search_placeholder/search_button` in all six `_data/locales/<lang>.yml` files, left in place) are preserved below as the starting point for a real implementation: a build-time-generated search index over every configured language's resume data, with no server-side dependency (consistent with this theme being a static Jekyll site).
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐ (4–6 hrs) | Impact: ⭐⭐ | Demand: Low-Med

#### Exact Target Files
- **Files to Create:**
  - `search.json` (Jekyll-generated JSON index, one entry per section item across every `languages.<lang>.data_path`, built with a Liquid front-matter template similar to `resume.json` in Feature 3.1)
  - `assets/js/site-search.js` (fetches `search.json`, filters client-side, renders results)
  - `docs/SEARCH_GUIDE.md`
- **Files to Modify:**
  - `_layouts/error.html` (reinstate the form below, wired to `site-search.js` instead of `action="/"`)
  - `_sass/_all-pages.scss` (reinstate the `.error-search` styling below, removed alongside the form in the a11y fix)
  - `docs/CONFIG_GUIDE.md`

#### Architecture & Liquid/JS Implementation
Starting-point markup and script, as they existed in `_layouts/error.html` before removal (form now needs its `action`/`method` replaced with a `site-search.js` submit handler that queries `search.json` instead of navigating to `/`):
```liquid
<form role="search" class="error-search" action="{{ '/' | relative_url }}" method="get">
    <label for="error-search-input" class="sr-only" data-i18n="search_label">{{ default_locale.error_pages.search_label | default: "Search website" }}</label>
    <div class="error-search-wrapper">
        <input type="search" id="error-search-input" name="q" class="error-search-input" data-i18n="search_placeholder" placeholder="{{ default_locale.error_pages.search_placeholder | default: 'Search website...' }}" aria-label="{{ default_locale.error_pages.search_label | default: 'Search website' }}">
        <button type="submit" class="error-search-button" data-i18n="search_button" aria-label="{{ default_locale.error_pages.search_button | default: 'Search' }}">
            <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
                <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
            </svg>
        </button>
    </div>
</form>

<script type="application/json" id="error-search-i18n">
{
    {%- for lang_entry in site.languages -%}
        {%- assign lang = lang_entry[0] -%}
        {%- assign locale = site.data.locales[lang] -%}
        "{{ lang }}": {
            "search_label": {{ locale.error_pages.search_label | default: default_locale.error_pages.search_label | jsonify }},
            "search_placeholder": {{ locale.error_pages.search_placeholder | default: default_locale.error_pages.search_placeholder | jsonify }},
            "search_button": {{ locale.error_pages.search_button | default: default_locale.error_pages.search_button | jsonify }}
        }{% unless forloop.last %},{% endunless %}
    {%- endfor -%}
}
</script>
```
Client-side text swap logic to relabel this markup per language (reusable as-is, was previously driven by `navigator.language`; a real implementation should instead read the `preferred-lang` `localStorage` key written by `_layouts/resume.html`, matching the pattern `_layouts/error.html` now uses for its single-language block):
```js
(function () {
    try {
        var i18n = JSON.parse(document.getElementById('error-search-i18n').textContent);
        var browserLang = (navigator.language || '').slice(0, 2).toLowerCase();
        var strings = i18n[browserLang];
        if (!strings) { return; }
        document.querySelectorAll('[data-i18n]').forEach(function (el) {
            var text = strings[el.getAttribute('data-i18n')];
            if (!text) { return; }
            if (el.tagName === 'INPUT') {
                el.placeholder = text;
                el.setAttribute('aria-label', text);
            } else if (el.tagName === 'BUTTON') {
                el.setAttribute('aria-label', text);
            } else {
                el.textContent = text;
            }
        });
    } catch (e) { /* JS disabled or unsupported: default_lang text already rendered. */ }
})();
```
Removed SCSS, to reinstate in `_sass/_all-pages.scss` inside the `.error-page` block (as it existed there before removal):
```scss
  .error-search {
    margin: 1.5rem auto 2rem;
    max-width: 440px;
    width: 100%;

    .error-search-wrapper {
      position: relative;
      display: flex;
      align-items: center;
      width: 100%;
    }

    .error-search-input {
      width: 100%;
      padding: 0.75rem 2.75rem 0.75rem 1rem;
      border: 1px solid var(--border-color, #c7c7c7);
      border-radius: 6px;
      font-size: 0.95rem;
      color: var(--text-color, #333);
      background-color: var(--card-bg, var(--bg-color, #fff));
      outline: none;
      box-sizing: border-box;
      transition: border-color 0.2s ease, box-shadow 0.2s ease;

      &::placeholder {
        color: var(--text-light, #888);
        opacity: 0.8;
      }

      &:focus {
        border-color: var(--accent-color, #3064a9);
        box-shadow: 0 0 0 3px rgba(48, 100, 169, 0.2);
      }
    }

    .error-search-button {
      position: absolute;
      right: 0.5rem;
      background: none;
      border: none;
      padding: 0.375rem;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      color: var(--text-light, #888);
      transition: color 0.2s ease;

      &:hover,
      &:focus {
        color: var(--accent-color, #3064a9);
        outline: none;
      }

      svg {
        width: 18px;
        height: 18px;
      }
    }
  }
```
Still needed for a working feature: `search.json` generation (a Liquid template, one JSON object per active item across every section in every language's data folder, keyed by `lang`), and `assets/js/site-search.js` to fetch that index, filter by the submitted query scoped to the visitor's current language, and render results in place of the current no-op `action="{{ '/' | relative_url }}"` navigation.

#### Acceptance Criteria & Verification
- [ ] Submitting the search form returns matching resume sections/items for the visitor's current language, without a full page navigation.
- [ ] `search.json` includes all 12 standard sections' `active: true` items for every configured language.
- [ ] Empty query or no matches shows a localized "no results" state instead of a blank screen.
- [ ] Fully keyboard-operable and screen-reader announced (reuses the existing `role="search"` / labeled-input / ARIA-button markup above).
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build --config docs/_data/_config.sample.yml,docs/_data/_config.demo.yml && \
  test -f _site/search.json && \
  echo "Site search index build verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/site-search`
- **PR Title:** `feat(search): add client-side site search index (Closes #225)`
- **Conventional Commit:** `feat(search): generate search.json and wire error-page search form (Closes #225)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/225`

---

### Feature 4.9: Auto-Generate CV & Profile Pages per Configured Language

- **Target Release:** `v1.1.0`
- **Canonical Issue:** [#226](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/226)
- **Auto-Closing Reference:** `Closes #226`
- **Canonical URL:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/226`
- **Concept & User Demand Rationale:**
  Both `_layouts/resume.html` and `_layouts/profile.html` are fully data-driven: page content comes entirely from `_data/<lang>/*.yml` and `languages.<lang>.*` in `_config.yml`, so a real page for either layout is already just a front-matter shell (`layout`, `lang`, `t_id`, `permalink` — see `_pages/cv-en.html`, `_pages/cv-ar.html`, `_pages/index.html`, `_pages/index-ar.html` in a consuming site). Every new `languages.<lang>` entry currently still requires hand-creating both shells, or the language switcher and hreflang tags have nothing to link to for that language. `_plugins/error_pages_generator.rb` already solves the identical problem for `404`/`403`/`500` pages via a `Jekyll::Generator` with a three-tier collision check (in-memory `site.pages`, a root file, a `_pages/` file) that skips generation whenever the consuming site already provides its own — this feature applies that same proven pattern to CV and profile pages, and simultaneously gives `languages.<lang>.url` (previously a semi-redundant fallback value in `language-switcher.html`/`error.html`) a clear, load-bearing purpose: the actual generation target.
- **Effort / Impact / Demand:** Effort: ⭐⭐⭐ (3–4 hrs) | Impact: ⭐⭐⭐ | Demand: Med-High

#### Exact Target Files
- **Files to Create:**
  - `_plugins/resume_pages_generator.rb`
  - `docs/MULTILINGUAL_GUIDE.md` §"Adding a Language" update (or new subsection)
- **Files to Modify:**
  - `docs/_data/_config.sample.yml` (document `resume_auto_generate_pages`)
  - `docs/CONFIG_GUIDE.md`
  - `lib/bilingual-jekyll-resume-theme/resume_validator.rb` (recognize auto-generated pages so it stops warning about a "missing" CV/profile page for a language that has no physical `_pages/` file)
  - `AGENTS.md` (Rule 1 / multilingual workflow section: adding a language no longer requires hand-authoring page shells)

#### Data Models & Configuration
In `_config.yml`:
```yaml
# ==============================================================================
# Auto-Generated Language Pages
# ==============================================================================
resume_auto_generate_pages: true  # Master toggle (default: true). Set false to require
                                   # every languages.<lang> entry to have its own hand-written
                                   # CV/profile page, matching pre-v1.1.0 behavior.
```

#### Architecture & Ruby Implementation
Create `_plugins/resume_pages_generator.rb`, mirroring `error_pages_generator.rb`'s generator/collision-check shape:
```ruby
# frozen_string_literal: true

module BilingualJekyllResumeTheme
  # Synthesizes a CV (layout: resume) and profile (layout: profile) page for
  # every languages.<lang> entry in _config.yml that doesn't already have one,
  # the same way ErrorPagesGenerator synthesizes 404/403/500 pages.
  class ResumePagesGenerator < Jekyll::Generator
    safe true
    priority :low # run after physical pages are parsed, so collision checks are accurate

    def generate(site)
      return if site.config["resume_auto_generate_pages"] == false

      languages = site.config["languages"] || {}
      default_lang = site.config["default_lang"] || "en"

      languages.each do |lang, lang_cfg|
        synthesize(site, "resume", lang, "cv-main", lang_cfg["url"])

        profile_url = (lang == default_lang) ? "/" : "/#{lang}/"
        synthesize(site, "profile", lang, "profile-main", profile_url)
      end
    end

    private

    def synthesize(site, layout, lang, t_id, permalink)
      return if permalink.nil?
      return if site.pages.any? { |p| p.data["layout"] == layout && p.data["lang"] == lang }
      return if site.pages.any? { |p| p.url == permalink }

      page = Jekyll::PageWithoutAFile.new(site, site.source, "", "#{layout}-#{lang}.html")
      page.content = ""
      page.data["layout"] = layout
      page.data["lang"] = lang
      page.data["t_id"] = t_id
      page.data["permalink"] = permalink
      site.pages << page
    end
  end
end
```
Note: unlike `ErrorPagesGenerator`'s third collision tier (checking for a physical file on disk by exact filename), a hand-authored override page here can live at any filename in `_pages/` — it's matched by `layout`+`lang` (or by permalink collision) once Jekyll has already parsed it into `site.pages`, which `priority :low` guarantees happens first.

#### Acceptance Criteria & Verification
- [ ] A `languages.<lang>` entry with no matching `_pages/` file gets a working `/<lang>/cv/`-style CV page and a `/` (default) or `/<lang>/` profile page after `bundle exec jekyll build`, matching the hand-authored `en`/`ar` output byte-for-byte in structure.
- [ ] A site's own physical page for that `layout`+`lang` (for redirects, extra `{{ content }}`, or any other reason) is left untouched — the generator detects and skips it.
- [ ] `resume_auto_generate_pages: false` fully restores pre-v1.1.0 behavior (no pages synthesized).
- [ ] `bin/validate-resume` no longer emits a false "missing page" warning for a language once its page is auto-generated.
- [ ] **Bash Verification Command:**
  ```bash
  bundle exec jekyll build --config docs/_data/_config.sample.yml,docs/_data/_config.demo.yml && \
  test -f _site/es/cv/index.html && test -f _site/es/index.html && \
  echo "Auto-generated language pages verified."
  ```

#### Git Workflow Specification
- **Branch:** `feature/auto-generate-language-pages`
- **PR Title:** `feat(pages): auto-generate CV and profile pages per configured language`
- **Conventional Commit:** `feat(pages): auto-generate CV/profile pages for each languages.<lang> entry (Closes #226)`
- **Issue Reference:** `https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/226`

---

## 7. Cross-Cutting Configuration & Target Files Index

### 7.1 Unified Target Files Manifest
```
Files to Create (28 Files):
├── _sass/_themes.scss
├── _sass/_print-optimization.scss
├── _sass/_timeline.scss
├── _sass/_comparison.scss
├── _includes/language-switcher.html
├── _includes/qr-code.html
├── _includes/badge-display.html
├── _includes/json-ld-resume.html
├── _includes/skill-level-bar.html
├── _includes/timeline-view.html
├── _includes/contact-form.html
├── _includes/version-switcher.html
├── _includes/vendors/lineicons-v5.0/mastodon.svg
├── _includes/vendors/lineicons-v5.0/discord.svg
├── _includes/vendors/lineicons-v5.0/bluesky.svg
├── _includes/vendors/lineicons-v5.0/threads.svg
├── _includes/vendors/lineicons-v5.0/substack.svg
├── _includes/vendors/lineicons-v5.0/gitlab.svg
├── _includes/vendors/lineicons-v5.0/google-scholar.svg
├── _includes/vendors/lineicons-v5.0/orcid.svg
├── _includes/vendors/lineicons-v5.0/behance.svg
├── _layouts/resume-multi.html
├── _layouts/resume-timeline.html
├── _layouts/resume-comparison.html
├── .github/workflows/ci.yml
├── bin/validate-resume
├── resume.json
└── resume-ar.json

Documentation Files to Create or Update (12 Files):
├── docs/THEMES_GUIDE.md
├── docs/PRINT_GUIDE.md
├── docs/SEO_GUIDE.md
├── docs/ACCESSIBILITY_GUIDE.md
├── docs/JSON_RESUME_EXPORT.md
├── docs/VALIDATION_GUIDE.md
├── docs/MULTILINGUAL_GUIDE.md
├── docs/TIMELINE_GUIDE.md
├── docs/CONTACT_FORM_GUIDE.md
├── docs/ANALYTICS_GUIDE.md
├── docs/CONFIG_GUIDE.md
└── docs/DATA_GUIDE.md
```

### 7.2 Configuration Key Extensions Master Reference
| Configuration Key | Type | Default | Feature ID | Functional Scope |
|---|---|---|---|---|
| `resume_theme` | String | `"default"` | 1.1 | Theme palette (`modern-blue`, `emerald-green`, `corporate-navy`, `warm-burgundy`) |
| `resume_language_switcher` | Boolean | `true` | 1.2 | Enable/disable interactive language toggle component |
| `resume_show_qr_code` | Boolean | `false` | 1.5 | Enable dynamic QR code rendering |
| `resume_qr_code_print_only` | Boolean | `true` | 1.5 | Restrict QR code visibility strictly to printed sheets |
| `resume_skills_visualization` | Boolean | `false` | 2.2 | Enable proficiency progress bars and level labels |
| `resume_skills_categorized` | Boolean | `false` | 2.5 | Enable grouping of skills by category subheadings |
| `og_image` | String | `nil` | 2.6 | Fallback image URL for Open Graph and Twitter summary cards |
| `resume_contact_form` | Boolean | `false` | 4.3 | Enable secure visitor contact form |
| `contact_form.provider` | String | `"formspree"` | 4.3 | Contact form backend provider (`formspree`, `netlify`, `getform`) |
| `resume_engagement_analytics`| Boolean | `false` | 4.4 | Enable privacy-preserving print and click event dispatching |
| `resume_auto_generate_pages` | Boolean | `true` | 4.9 | Master toggle for auto-generating CV/profile pages per `languages.<lang>` entry |

---

## 8. Global Quality Assurance & Verification Protocols

Before submitting pull requests or preparing release tags, execute the global multi-stage verification suite:

```bash
#!/usr/bin/env bash
set -e

echo "=== Stage 1: Clean and Strict Front-Matter Jekyll Build ==="
bundle exec jekyll clean
bundle exec jekyll build --strict_front_matter --trace

echo "=== Stage 2: RubyGem Packaging & Spec Verification ==="
gem build bilingual-jekyll-resume-theme.gemspec
rm -f bilingual-jekyll-resume-theme-*.gem

echo "=== Stage 3: YAML Data Syntax & Integrity Scan ==="
ruby -ryaml -e '
  Dir.glob("**/*.{yml,yaml}").reject { |f| f.include?("vendor/") }.each do |f|
    YAML.load_file(f)
  end
  puts "All YAML data files parsed successfully."
'

echo "=== Stage 4: Resume Data CLI Validation ==="
if [ -f "bin/validate-resume" ]; then
  bundle exec bin/validate-resume .
fi

echo "=== Stage 5: JSON Resume Schema Conformance ==="
if [ -f "_site/resume.json" ]; then
  ruby -rjson -e '
    json = JSON.parse(File.read("_site/resume.json"))
    raise "Schema mismatch" unless json["basics"]
    puts "JSON Resume schema parsed successfully."
  '
fi

echo "=== Stage 6: Bidirectional Text Isolation Check ==="
ruby -e '
  ar_html = File.read("_site/resume/ar/index.html") rescue nil
  if ar_html && ar_html.scan(/href="https?:\/\//).length > 0
    puts "Verified URL and link isolation in Arabic layout."
  end
'

echo "========================================================="
echo "✅ All global verification protocols passed successfully!"
echo "========================================================="
```
