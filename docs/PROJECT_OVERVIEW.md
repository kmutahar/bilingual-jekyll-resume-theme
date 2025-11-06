## Project overview

**bilingual-jekyll-resume-theme** is a Jekyll theme for creating bilingual (English & Arabic) resumes. Created by Khaldoon Mutahar.

## Features

1. Bilingual support
   - Separate layouts for English (`_layouts/resume-en.html`) and Arabic (`_layouts/resume-ar.html`)
   - RTL support for Arabic (SCSS in `_sass/_resume-rtl.scss`)
   - Arabic date formatting via `_includes/ar-date.html` (uses `_data/ar/months.yml`)
   - Separate name fields objects: `site.name.{first,middle,last}` and `site.name_ar.{first,middle,last}`
   - Optional language chips in header via `resume_section.lang_header`

2. Data-driven architecture
   - Resume content in YAML files in `_data/`
   - Supports nested data folders (e.g., `_data/en/`, `_data/ar/`, or versioned/custom paths)
   - Dynamic data loader (in both layouts) resolves dot-separated paths using bracket notation, e.g., `"2025-06.20250621-PM"`
   - Configurable data paths via `_config.yml` keys `active_resume_path_en` and `active_resume_path_ar`

3. Resume sections (13 types)
   - Experience, Education, Certifications, Courses, Volunteering, Projects, Skills, Recognition, Associations, Languages, Links, Interests, Header (Executive Summary)
   - Ordering via `resume_section_order` and toggles via `resume_section.*` in `_config.yml`
   - Active/inactive flags per entry across all sections

4. Design and UX
   - Print-friendly styling (print-only/no-print classes); optional print-only social links block
   - Social links integration via `_includes/social-links.html` (GitHub, LinkedIn, X, YouTube, etc.)
   - SVG icon set via Lineicons (bundled in `_includes/vendors/lineicons-*`)
   - Profile avatar support
   - Header contact info toggle (`display_header_contact_info`)
   - Live vs print contact info (`enable_live`) for phone/email variants
   - "Looking for work" contact button
   - Languages can appear in header or separate section

5. Technical features
   - Jekyll 4.4+ compatibility
   - SEO via `jekyll-seo-tag`; alternate language links via `_includes/hreflang.html`
   - Analytics hooks in head/body includes (Google Tag Manager/GA4 supported)
   - Sitemap and feed generation (`jekyll-sitemap`, `jekyll-feed`), redirects via `jekyll-redirect-from`
   - Schema.org markup for `Person` and various sections

## Project structure

- `_layouts/`: HTML templates (`default.html`, `resume-en.html`, `resume-ar.html`, `profile.html`)
- `_includes/`: Reusable components (sections, headers, social links, analytics, `hreflang.html`, SVG vendors)
- `_sass/`: SCSS stylesheets (base, layout, resume, RTL, print)
- `_data/`: Theme data files (Arabic month names in `ar/months.yml`)
- `assets/`: CSS, images, favicons
- `docs/`: Documentation (config, data, includes, layouts, SASS guides) and sample `_data/` content

## Notable implementation details

1. Dynamic data loading: In both `resume-en.html` and `resume-ar.html`, Liquid bracket notation iterates over a dot-separated path to resolve nested data objects (handles numeric or hyphenated keys like `"2025-06"`).
2. Conditional rendering: Sections render from `resume_section_order` and respect per-section toggles and data availability; optional header intro blocks (`resume_header_intro_en`/`_ar`).
3. Date formatting: Arabic dates via `_includes/ar-date.html` with month name lookup from `_data/ar/months.yml`.
4. Print behavior: Print-only URL echoes for links and optional print-only social links block.

## Documentation

Includes guides for:
- Configuration (`docs/CONFIG_GUIDE.md`)
- Data structure (`docs/DATA_GUIDE.md`)
- Includes (`docs/INCLUDES_GUIDE.md`)
- Layouts (`docs/LAYOUTS_GUIDE.md`)
- SASS (`docs/SASS_GUIDE.md`)

Sample data is provided under `docs/_data/en/` and `docs/_data/ar/` and a sample `_config` at `docs/_data/_config.sample.yml`.

The theme is production-ready and well-documented for creating bilingual resumes with Jekyll.