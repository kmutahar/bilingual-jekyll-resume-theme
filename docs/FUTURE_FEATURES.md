# Future Features & Enhancement Roadmap

This document outlines the architectural roadmap and planned feature enhancements for future releases of **bilingual-jekyll-resume-theme**. Each proposal includes a detailed description, user motivation, and concrete technical implementation notes detailing affected files, architecture decisions, and edge cases.

---

## Table of Contents

1. [Roadmap Overview & Prioritization Matrix](#roadmap-overview--prioritization-matrix)
2. [Feature Proposal 1: Automated CI/CD Headless PDF Generation & Header Download Action](#feature-proposal-1-automated-cicd-headless-pdf-generation--header-download-action)
3. [Feature Proposal 2: Seamless On-Page Bilingual Language Switcher Toggle](#feature-proposal-2-seamless-on-page-bilingual-language-switcher-toggle)
4. [Feature Proposal 3: JSON-LD Resume Schema & JSON Resume Standard Interoperability](#feature-proposal-3-json-ld-resume-schema--json-resume-standard-interoperability)
5. [Feature Proposal 4: Curated Multi-Theme Color Palette Presets](#feature-proposal-4-curated-multi-theme-color-palette-presets)
6. [Feature Proposal 5: Dynamic Arbitrary Custom Section Generator](#feature-proposal-5-dynamic-arbitrary-custom-section-generator)
7. [Feature Proposal 6: Categorized Skills Matrix with Interactive Proficiency Badges](#feature-proposal-6-categorized-skills-matrix-with-interactive-proficiency-badges)
8. [Feature Proposal 7: Dual Gregorian / Hijri (Islamic) Calendar Localization](#feature-proposal-7-dual-gregorian--hijri-islamic-calendar-localization)
9. [Feature Proposal 8: Print-Optimized Layout Engine with Dynamic Multi-Page Pagination Control](#feature-proposal-8-print-optimized-layout-engine-with-dynamic-multi-page-pagination-control)
10. [Contribution & Design Principles](#contribution--design-principles)

---

## Roadmap Overview & Prioritization Matrix

| # | Feature Proposal | Category | Target Release | Complexity | Impact |
|---|---|---|---|---|---|
| **1** | Automated Headless PDF Generation Action | Automation / Export | v0.7.0 | Medium | High |
| **2** | Seamless On-Page Bilingual Language Switcher | Navigation / UX | v0.7.0 | Low | High |
| **3** | JSON-LD Schema & JSON Resume Interoperability | SEO / ATS / Data | v0.7.0 | Medium | High |
| **4** | Curated Multi-Theme Color Palette Presets | Styling / Design | v0.8.0 | Low | Medium |
| **5** | Dynamic Arbitrary Custom Section Generator | Extensibility / Core | v0.8.0 | Medium | High |
| **6** | Categorized Skills Matrix & Visual Badges | Data / UI | v0.8.0 | Low | Medium |
| **7** | Dual Gregorian / Hijri Calendar Support | Arabic Localization | v0.9.0 | Medium | High |
| **8** | Print Engine & Multi-Page Pagination Control | Print / Layout | v0.9.0 | Medium | High |

---

## Feature Proposal 1: Automated CI/CD Headless PDF Generation & Header Download Action

### Description
Provide an automated GitHub Actions workflow utilizing headless Chromium (via Puppeteer or Playwright) to render pixel-perfect, print-optimized PDF resumes for both English and Arabic versions on every git push or release. In addition, introduce an optional customizable header button (`resume_download_pdf_en` / `resume_download_pdf_ar`) with localized icons and labels allowing site visitors to download the pre-compiled PDF directly.

### Motivation & User Benefit
Recruiters and hiring managers frequently require downloadable PDF copies of candidates' resumes. While users can currently use the browser's "Print to PDF" dialog, automated CI/CD generation ensures perfectly rendered, deterministic PDFs hosted alongside the static site with zero manual user effort.

### Technical Implementation Notes
- **Files to Add/Modify**:
  - `.github/workflows/generate-pdf.yml`: GitHub Actions workflow that installs Node.js, launches headless Chromium, waits for web font hydration, captures `@media print` styling to `assets/resume-en.pdf` and `assets/resume-ar.pdf`, and commits or deploys the generated assets to GitHub Pages.
  - `_includes/shared-head.html` / `_layouts/resume-en.html` / `_layouts/resume-ar.html`: Conditionally render a "Download PDF" / "تحميل السيرة الذاتية (PDF)" action button in the header when enabled via configuration.
  - `_config.yml` and `docs/_data/_config.sample.yml`: Add configuration block:
    ```yaml
    resume_download_pdf:
      enabled: true
      path_en: "/assets/resume-en.pdf"
      path_ar: "/assets/resume-ar.pdf"
    ```
- **Architecture & Edge Cases**:
  - Headless rendering must pass `--disable-gpu` and wait for web fonts (`document.fonts.ready`) to guarantee accurate typography rendering in both English and Arabic.
  - Dark mode toggle button, skip links, and interactive widgets must be hidden in the print stylesheet (`.no-print`) so they do not bleed into the captured PDF.

---

## Feature Proposal 2: Seamless On-Page Bilingual Language Switcher Toggle

### Description
Add an accessible, floating or header-docked language switch button that allows visitors to toggle instantaneously between the English (LTR) and Arabic (RTL) versions of the resume. The component dynamically determines the target URL using the existing `t_id` front matter translation group without requiring manual URL hardcoding in template files.

### Motivation & User Benefit
Currently, switching between languages requires visitors to navigate via manual links or custom navigation menus. A built-in, dedicated language switcher provides an intuitive, polished user experience for international and bilingual audiences.

### Technical Implementation Notes
- **Files to Add/Modify**:
  - `_includes/language-switcher.html`: Reusable Liquid component that iterates over `site.pages`, filters for matching `page.t_id`, and builds the alternate language hyperlink with localized label (`العربية` on the English page, `English` on the Arabic page) and appropriate `hreflang` / `lang` attributes.
  - `_layouts/resume-en.html` and `_layouts/resume-ar.html`: Include `language-switcher.html` in the header or alongside the dark mode toggle button.
  - `_sass/_resume.scss` and `_sass/_resume-rtl.scss`: Styles for floating badge or header pill, with responsive positioning, hover states, and RTL mirror alignment.
  - `_config.yml` and `docs/_data/_config.sample.yml`: Add `resume_language_switcher: true` flag.
- **Architecture & Edge Cases**:
  - Must include `aria-label="Switch language to Arabic"` and `lang="ar"` on the English page to prevent assistive technologies from mispronouncing Arabic text.
  - Ensure zero layout shift (CLS) and suppress the switcher during print/PDF generation using `.no-print`.

---

## Feature Proposal 3: JSON-LD Resume Schema & JSON Resume Standard Interoperability

### Description
Enhance search engine visibility and automated Applicant Tracking System (ATS) parsing by injecting structured `schema.org/Person`, `schema.org/Occupation`, and `schema.org/EducationalOccupationalCredential` JSON-LD graphs into the document `<head>`. Furthermore, supply a standalone schema converter to enable frictionless import and export between the open-source JSON Resume standard (`jsonresume.org`) and this theme's YAML data files.

### Motivation & User Benefit
Modern recruiting pipelines and search engines rely heavily on machine-readable semantic data. Embedding structured JSON-LD increases organic discoverability in Google Search (Knowledge Panels, Job Search) and simplifies candidate data ingestion.

### Technical Implementation Notes
- **Files to Add/Modify**:
  - `_includes/schema-person.html`: Liquid template generating a valid JSON-LD `<script type="application/ld+json">` graph combining `resume_data.experience`, `resume_data.education`, `resume_data.skills`, `site.contact_info`, and `site.social_links`.
  - `_includes/shared-head.html`: Include `schema-person.html` when `site.enable_schema_org: true` (default: `true`).
  - `docs/DATA_GUIDE.md`: Add a dedicated section documenting the schema mapping and instructions for converting JSON Resume schemas to the theme's YAML structure.
- **Architecture & Edge Cases**:
  - Use Liquid's `jsonify` filter on all strings to safely escape quotes, linebreaks, and special characters.
  - Handle optional fields (such as phone numbers suppressed via `enable_live: false`) to avoid leaking unlisted personal contact details into public structured data.

---

## Feature Proposal 4: Curated Multi-Theme Color Palette Presets

### Description
Expand the current single `resume_theme: default` configuration into a rich library of professionally curated color presets (e.g., `modern-slate`, `emerald-professional`, `classic-navy`, `minimal-monochrome`, `warm-earth`). Each theme preset provides harmonious light and dark mode CSS variables that automatically adapt to system preferences and user toggle pins.

### Motivation & User Benefit
Candidates across different industries (e.g., finance, creative design, software engineering, academia) desire distinct aesthetic tones without having to manually write custom SCSS rules.

### Technical Implementation Notes
- **Files to Add/Modify**:
  - `_sass/_themes.scss`: New SCSS partial containing CSS Custom Property blocks scoped to `body.theme-slate`, `body.theme-emerald`, `body.theme-navy`, `body.theme-warm-earth`, and `body.theme-monochrome`.
  - `_sass/cv.scss`, `_sass/cv-ar.scss`, `assets/css/main.scss`: Import `_themes.scss`.
  - `_layouts/resume-en.html` and `_layouts/resume-ar.html`: Dynamically apply `class="theme-{{ site.resume_theme | default: 'default' }}"` to `<body>`.
  - `docs/CONFIG_GUIDE.md` and `docs/SASS_GUIDE.md`: Document theme preset names, color swatches, and override recipes.
- **Architecture & Edge Cases**:
  - Every theme preset must strictly adhere to WCAG 2.1 AA color contrast standards (minimum 4.5:1 for body text and 3.0:1 for large headings) across both light and dark variations.
  - Print styles must remain unstyled by color themes to conserve printer ink and maintain pure black text on white backgrounds.

---

## Feature Proposal 5: Dynamic Arbitrary Custom Section Generator

### Description
Allow users to add arbitrary custom resume sections (e.g., "Patents", "Workshops & Speaking", "Open Source Contributions", "Military Service", "Press & Media") purely via YAML configuration without needing to edit or override the theme's core Liquid templates. Custom sections support configurable layouts (timeline, bulleted list, key-value grid) and localized headings.

### Motivation & User Benefit
Currently, adding a non-standard section requires modifying both `resume-section-en.html` and `resume-section-ar.html`. A dynamic custom section engine eliminates template editing and makes the theme infinitely extensible for specialized professions.

### Technical Implementation Notes
- **Files to Add/Modify**:
  - `_includes/resume-custom-section.html`: Generic Liquid section renderer capable of parsing standard entity fields: `title`, `subtitle`, `date`/`year`, `location`, `url`, `description`, `bullets`, and `badge`.
  - `_includes/resume-section-en.html` and `_includes/resume-section-ar.html`: Add an `{% else %}` fallback branch that loads `resume_data[include.section_name]` and renders `resume-custom-section.html`.
  - `_config.yml` and `docs/_data/_config.sample.yml`: Support custom section names in `resume_section_order` and optional localized section title dictionaries:
    ```yaml
    custom_section_titles:
      en:
        patents: "Patents & Inventions"
        speaking: "Keynotes & Speaking"
      ar:
        patents: "براءات الاختراع"
        speaking: "المؤتمرات والمحاضرات"
    ```
  - `docs/CONFIG_GUIDE.md` and `docs/DATA_GUIDE.md`: Provide full custom section tutorials and schema examples.
- **Architecture & Edge Cases**:
  - Maintain 100% backward compatibility with all 12 built-in section names.
  - Provide a graceful fallback to a humanized title (`include.section_name | capitalize`) if a localized custom title is omitted in `_config.yml`.

---

## Feature Proposal 6: Categorized Skills Matrix with Interactive Proficiency Badges

### Description
Enhance the Skills section to support grouping skills into logical categories (e.g., "Languages", "Frameworks & Cloud", "Databases & Storage", "Tools & Methodologies") with optional visual proficiency badges (e.g., Expert, Advanced, Intermediate) or percentage bars. Includes optional lightweight JavaScript filtering allowing visitors to click a skill to highlight associated projects and experience entries.

### Motivation & User Benefit
Modern technical resumes feature expansive skillsets. Categorized skill groupings and visual proficiency badges make technical proficiencies easier for hiring managers to scan and assess quickly.

### Technical Implementation Notes
- **Files to Add/Modify**:
  - `_includes/resume-section-en.html` and `_includes/resume-section-ar.html`: Update the `skills` section renderer to support either flat skill lists (legacy) or category-grouped arrays with `category_name`, `skills: [{ name, level, badge }]`.
  - `_sass/_resume.scss` and `_sass/_resume-rtl.scss`: Styles for `.skill-category`, `.skill-badge`, `.skill-pill`, and level indicators with CSS custom property tokens for dark mode.
  - `docs/_data/en/skills.yml` and `docs/_data/ar/skills.yml`: Provide commented sample data demonstrating both flat and categorized schemas.
  - `docs/DATA_GUIDE.md`: Document the updated skills data schema.
- **Architecture & Edge Cases**:
  - Retain full backward compatibility for existing simple `skill` / `description` entries without requiring user data migration.
  - Compact rendering in `@media print` stylesheets to prevent excessive vertical height during printing.

---

## Feature Proposal 7: Dual Gregorian / Hijri (Islamic) Calendar Localization

### Description
Add native support for displaying Hijri (Umm al-Qura) dates alongside or in lieu of Gregorian dates in Arabic resumes (`resume-ar.html`), which is a standard requirement for governmental, academic, and corporate positions across Saudi Arabia and the Gulf (GCC) region.

### Motivation & User Benefit
Users submitting resumes to Middle Eastern institutions often require official Islamic Hijri dates (e.g., "شعبان ١٤٤٥ هـ / مارس ٢٠٢٤ م"). Providing built-in Hijri calendar support establishes the theme as the premier bilingual resume solution for the Arab world.

### Technical Implementation Notes
- **Files to Add/Modify**:
  - `_data/ar/hijri_months.yml`: Theme-bundled dictionary containing Arabic names of the 12 Islamic lunar months (محرم, صفر, ربيع الأول, ربيع الثاني, جمادى الأولى, جمادى الآخرة, رجب, شعبان, رمضان, شوال, ذو القعدة, ذو الحجة).
  - `_includes/ar-date.html`: Enhance the Liquid date formatter to accept a `calendar` parameter:
    - `gregorian` (default): Gregorian date with Arabic month names.
    - `hijri`: Display localized Hijri date.
    - `dual`: Format combined date (e.g., `شعبان ١٤٤٥ هـ / مارس ٢٠٢٤ م`).
  - `_config.yml` and `docs/_data/_config.sample.yml`: Add `arabic_date_calendar: "gregorian" | "hijri" | "dual"`.
  - `docs/CONFIG_GUIDE.md` and `docs/INCLUDES_GUIDE.md`: Document configuration options and date format conventions.
- **Architecture & Edge Cases**:
  - Support explicit static YAML overrides (`hijri_date: "١٤٤٥/٠٨"`) in entry data to allow precise dates without algorithmic variance.
  - Support Arabic-Indic numerals (`٠١٢٣٤٥٦٧٨٩`) via Liquid text replacement filters.

---

## Feature Proposal 8: Print-Optimized Layout Engine with Dynamic Multi-Page Pagination Control

### Description
Elevate the theme's printing and PDF export capabilities by introducing an intelligent CSS print pagination engine with granular page-break controls (`break-inside: avoid;`, `page-break-inside: avoid;`, orphan/widow guards). Users can configure automatic multi-page budgets, enforce clean page boundaries between sections, or enable a high-density "single-page resume" layout mode.

### Motivation & User Benefit
One of the most frustrating aspects of web resumes is awkward page breaks where a job title appears at the bottom of page one and its bullet points spill over to page two. Granular print engine controls guarantee clean, professional PDF and physical printouts.

### Technical Implementation Notes
- **Files to Add/Modify**:
  - `_sass/_print.scss`: Refactor print styling rules to use modern CSS Paged Media standards (`@page { margin: 1.5cm; }`), orphan/widow limits (`orphans: 3; widows: 3;`), and strict `break-inside: avoid` on `.resume-item`, `.section-header`, and `.experience-role`.
  - `_sass/_resume.scss` and `_sass/_resume-rtl.scss`: Add utility classes `.page-break-before`, `.page-break-after`, and `.page-break-inside-avoid`.
  - `_config.yml` and `docs/_data/_config.sample.yml`: Add optional print tuning parameters:
    ```yaml
    print_settings:
      compact_mode: false       # Reduces margin/font size for tight single-page layouts
      show_page_numbers: true   # Renders bottom running page counter
      preserve_links: true      # Echoes full URL text alongside hyperlink anchors
    ```
  - `docs/SASS_GUIDE.md` and `docs/CONFIG_GUIDE.md`: Document print customization classes and configuration options.
- **Architecture & Edge Cases**:
  - Test print layout across Chromium (Blink), Safari (WebKit), and Firefox (Gecko) to account for subtle differences in CSS fragmentation and print rendering engines.
  - Ensure RTL margins (`@page :left`, `@page :right`) are mirrored accurately for Arabic printouts.

---

## Contribution & Design Principles

When implementing features from this roadmap, contributors must adhere to the following core guidelines:

1. **Bilingual Parity**: Any feature introduced to the English layout (`resume-en.html`) MUST have an equivalent, culturally adapted implementation in the Arabic layout (`resume-ar.html`).
2. **Backward Compatibility**: New features must default to non-breaking or opt-in states so existing resume deployments do not experience unexpected visual changes upon updating the gem.
3. **Accessibility First**: All new interactive components must conform to WCAG 2.1 AA standards, including keyboard focus states, screen reader ARIA landmarks, and high-contrast color tokens.
4. **Performance & Zero FOUC**: Client-side logic must remain lightweight with zero dependencies on large external libraries, avoiding Flash of Unstyled Content (FOUC) across light and dark modes.
5. **Print Integrity**: Print stylesheets must always take precedence during printing, suppressing interactive UI controls and producing crisp, ink-efficient documents.
