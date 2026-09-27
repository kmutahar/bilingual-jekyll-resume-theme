# Feature Roadmap

**Status:** This is the canonical list of planned work. Feature IDs and issue mappings are retained from the previous roadmap; hosted issue status was not rechecked in this local documentation audit. Proposed settings below are not supported until implemented. Implementation briefs replace pre-v1.0 copy-and-paste snippets that referenced removed files.

## 1. Active Features Master Matrix

| Phase | ID | Planned feature | Issue |
|---|---|---|---|
| P1 | 1.1 | Predefined Color Themes Palette Engine (5 Palettes) | [#7](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/7) |
| P1 | 1.3 | Expanded Modern Social Media Platforms (9 Platforms) | [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) |
| P1 | 1.5 | Dynamic Contact / Resume QR Code Component | [#14](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/14) |
| P1 | 1.6 | Achievement Badges & Credential Icons | [#19](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/19) |
| P2 | 2.1 | Comprehensive JSON-LD Structured Data | [#9](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/9) |
| P2 | 2.2 | Skills Level Indicators & Visual Progress Bars | [#10](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/10) |
| P2 | 2.3 | Professional Print Pagination & Spacing Engine | [#12](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/12) |
| P2 | 2.5 | Skills Taxonomy & Categorized Tagging System | [#18](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/18) |
| P2 | 2.6 | Social Media Cards (Open Graph & Twitter) | [#22](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/22) |
| P2 | 2.9 | Dual Gregorian / Hijri (Islamic) Calendar Localization | [#218](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/218) |
| P3 | 3.1 | Standard JSON Resume Exporter | [#6](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/6) |
| P4 | 4.2 | Interactive Career Timeline Visualization | [#16](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/16) |
| P4 | 4.3 | Contact Form Integration (Formspree / Netlify) | [#20](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/20) |
| P4 | 4.4 | Privacy-First Resume Engagement Analytics | [#17](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/17) |
| P4 | 4.5 | Resume Comparison View | [#23](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/23) |
| P4 | 4.7 | Dynamic Custom Resume Sections Engine | [#219](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/219) |
| P4 | 4.8 | Client-Side Site Search Index | [#225](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/225) |

## 2. Completed Work and Current Architecture

- **2.10, SCSS deduplication (#224):** completed.
- **4.9, automatic CV/profile pages (#226):** completed.
- **Stylesheet includes:** inlined single-caller stylesheet includes.
- Completed work is recorded in [docs/COMPLETED_AUDIT.md](docs/COMPLETED_AUDIT.md); release boundaries are in [CHANGELOG.md](CHANGELOG.md).

Current implementation anchors:

- Every language uses `_layouts/resume.html`, `_includes/resume-section.html`, and `_includes/date-formatter.html`. Experience and Volunteering share `_includes/grouped-item-list.html`.
- Resume data resolves from `languages.<lang>.data_path`; UI copy and direction come from `_data/locales/<lang>.yml`. Keep key parity across the six shipped locales.
- Resume styles enter through `assets/css/cv-ltr.scss` or `assets/css/cv-rtl.scss`; default/profile layouts directly link their own compiled stylesheets.
- Starter data lives in the `demo/` submodule; annotated configuration is `_config.sample.yml` at the repository root.
- New Ruby generators must be required by `lib/bilingual-jekyll-resume-theme.rb`; copying a plugin into a gem is not sufficient registration.

<a id="status-delete-zone"></a>
## Status Delete-Zone (Intentional Removals & Deprecations)

In accordance with Living Docs Governance, this Delete-Zone catalogs files, patterns, features, and configurations that have been intentionally removed, prohibited, or deprecated. **AI agents and developers MUST NOT recreate or re-introduce these elements.**

| # | Path / Pattern / Concept | Lifecycle Status | Why Removed / Forbidden | Canonical Replacement | Revisit Condition |
|---|---|---|---|---|---|
| 1 | Static return URLs (`/resume/en/`, `/resume/ar/` in `_layouts/error.html`) | **Removed in v0.8.0 (Issue #216)** | Hardcoded paths broke return navigation for sites using custom resume paths (e.g. `/en/cv/`, `/ar/cv/`). | Current Home link: language profile page, then `languages.<lang>.url`, then `/`. | Never revert to hardcoded static URLs. The v1.0.0 locale extension (Feature 4.1, delivered — see `docs/COMPLETED_AUDIT.md`) already follows dynamic resolution; any future locale work must too. |
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

| 13 | `_includes/main-head.html`, `_includes/profile-head.html` | **Removed in `4513f29`** | Each wrapped one stylesheet link for a single caller. | Inline stylesheet links in `_layouts/default.html` and `_layouts/profile.html`. | Add a shared abstraction only when multiple callers actually need it. |


## 3. Planned Implementation Briefs

### Feature 1.1: Predefined Color Themes Palette Engine (5 Palettes)

**Issue:** [#7](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/7) · **Branch:** `feature/color-themes` · **Closure:** `Closes #7`

Add the planned default, modern-blue, emerald-green, corporate-navy, and warm-burgundy palettes. The existing resume_theme setting currently supplies a body class; the palette engine is not implemented.

**Files:** Create `_sass/_themes.scss`; update `_sass/_dark-mode.scss`, the four `assets/css/*.scss` entrypoints, and shared layouts as needed. Document in `_config.sample.yml` and a new `docs/THEMES_GUIDE.md`.

**Implementation contract:** Keep `resume_theme` as the selector. Put colors in CSS custom properties; preserve the current system/pinned dark-mode cascade and print reset. Use the shared `resume.html`, never language-specific layouts.

**Acceptance criteria:**

- [ ] Each named palette changes intended accents in every configured locale.
- [ ] Light, system-dark, pinned-dark, and print states retain readable colors.
- [ ] Omitting the setting preserves the existing appearance.

### Feature 1.3: Expanded Modern Social Media Platforms (9 Platforms)

**Issue:** [#204](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/204) · **Branch:** `feature/expanded-social-icons` · **Closure:** `Closes #204`

Add icon and print-list support for Mastodon, Discord, Bluesky, Threads, Substack, GitLab, Google Scholar, ORCID, and Behance. Mastodon already has rel="me" head metadata in default/profile layouts; icon and print support remains planned.

**Files:** Update `_includes/social-links.html`, `_includes/print-social-links.html`, `_includes/vendors/lineicons-v5.0/`, all `_data/locales/*.yml`, `_config.sample.yml`, and `docs/CONFIG_GUIDE.md`.

**Implementation contract:** Extend `social_links` with `mastodon`, `discord`, `bluesky`, `threads`, `substack`, `gitlab`, `google_scholar`, `orcid`, and `behance`. Keep accessible names, hidden decorative SVGs, and safe external links. Use locale labels and bidi isolation for printed URLs.

**Acceptance criteria:**

- [ ] Only configured platforms render, without blank placeholders.
- [ ] All nine have accessible names and printable URLs in LTR/RTL.
- [ ] Mastodon identity links preserve rel="me".

### Feature 1.5: Dynamic Contact / Resume QR Code Component

**Issue:** [#14](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/14) · **Branch:** `feature/qr-code` · **Closure:** `Closes #14`

Add an optional QR code linking a printed or digital resume to its canonical online page.

**Files:** Create `_includes/qr-code.html`; update `_layouts/resume.html`, shared/print SCSS, `_config.sample.yml`, and locale UI strings.

**Implementation contract:** Proposed settings: `resume_show_qr_code` (false), `resume_qr_code_print_only` (true), and `resume_qr_code_size` (96). Encode `page.url | absolute_url`. Choose and document an actual local generation mechanism before implementation; the previous blueprint relied on an unprovided qr_code filter. Do not send resume/contact data to an external image service.

**Acceptance criteria:**

- [ ] A scanner opens the correct canonical URL, including baseurl.
- [ ] Print-only mode is hidden on screen and readable on paper.
- [ ] Caption and positioning work for every locale; disabling the feature adds no broken asset.

### Feature 1.6: Achievement Badges & Credential Icons

**Issue:** [#19](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/19) · **Branch:** `feature/achievement-badges` · **Closure:** `Closes #19`

Add optional badge images to certifications and recognitions while retaining the current text-only presentation when absent.

**Files:** Create `_includes/badge-display.html`; update `_includes/resume-section.html`, resume SCSS, validator rules, and `docs/DATA_GUIDE.md`.

**Implementation contract:** Proposed per-item field: `badge_url`. Reuse existing `credential_url` for optional verification links. Resolve local images with relative_url, define appropriate alt text, and keep dimensions predictable.

**Acceptance criteria:**

- [ ] Entries with badges align with their headings in LTR and RTL.
- [ ] Missing badges leave no gaps or empty image elements.
- [ ] Verification links and printed text remain usable without images.

### Feature 2.1: Comprehensive JSON-LD Structured Data

**Issue:** [#9](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/9) · **Branch:** `feature/json-ld-structured-data` · **Closure:** `Closes #9`

Extend machine-readable resume data beyond current Person/Organization microdata and jekyll-seo-tag output. JSON-LD alone does not guarantee ATS acceptance or search rich results.

**Files:** Create `_includes/json-ld-resume.html`; integrate with `_layouts/resume.html`, its resolved `resume_data`/`lang_cfg`, and a new `docs/SEO_GUIDE.md`.

**Implementation contract:** Serialize safely with jsonify, filter inactive entries, use the active language’s data, and respect existing contact substitutions. Reconcile with jekyll-seo-tag’s JSON-LD rather than emitting contradictory identities or duplicate canonical tags. Verify Schema.org vocabulary when implementing.

**Acceptance criteria:**

- [ ] Each CV emits parseable JSON-LD with the correct person, locale, and URLs.
- [ ] Quotes, HTML-containing summaries, and non-Latin text serialize correctly.
- [ ] Inactive entries stay out; structured contact values agree with visible content.

### Feature 2.2: Skills Level Indicators & Visual Progress Bars

**Issue:** [#10](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/10) · **Branch:** `feature/skills-visualization` · **Closure:** `Closes #10`

Add optional visual skill proficiency indicators alongside skill names and descriptions.

**Files:** Create `_includes/skill-level-bar.html`; update the skills branch in `_includes/resume-section.html`, resume SCSS, all locales, `_config.sample.yml`, and the data/config guides.

**Implementation contract:** Proposed toggle: `resume_skills_visualization` (false). Use existing validator-compatible integer `level` values from 1 to 5 and optional localized `level_label`. The previous 1–100 alternative conflicted with validation and is not part of the current data contract. Use appropriate accessible value semantics for a static proficiency measure.

**Acceptance criteria:**

- [ ] No meter renders if visualization is disabled or level is missing.
- [ ] Labels and numeric values are available without relying on color.
- [ ] RTL fill direction, dark mode, and print remain readable.

### Feature 2.3: Professional Print Pagination & Spacing Engine

**Issue:** [#12](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/12) · **Branch:** `feature/print-pagination-engine` · **Closure:** `Closes #12`

Improve the existing print styles with explicit page-break and typography controls.

**Files:** Create `_sass/_print-optimization.scss` if a separate module is useful; update `assets/css/cv-ltr.scss`, `assets/css/cv-rtl.scss`, `_sass/_resume-ltr.scss`, `_sass/_resume-rtl.scss`, and a new `docs/PRINT_GUIDE.md`.

**Implementation contract:** Keep headings with following content, use break-inside/break-after deliberately, and avoid forcing oversized groups onto one page. Preserve locale typography, especially Arabic and Urdu; do not reuse the old fixed .7em line-height example.

**Acceptance criteria:**

- [ ] Check multi-page A4 and Letter output for all six locales.
- [ ] No clipped text or stranded headings; long entries can still paginate.
- [ ] Controls remain hidden and printed links remain directionally correct.

### Feature 2.5: Skills Taxonomy & Categorized Tagging System

**Issue:** [#18](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/18) · **Branch:** `feature/skills-taxonomy` · **Closure:** `Closes #18`

Group skills by optional categories and display optional tags while keeping the current flat list available.

**Files:** Update `_includes/resume-section.html`, shared resume SCSS, validator rules, `_config.sample.yml`, `docs/DATA_GUIDE.md`, and `docs/CONFIG_GUIDE.md`.

**Implementation contract:** Proposed toggle: `resume_skills_categorized` (false). Add `category` and `tags` to entries that retain the canonical `skill` field. Filter active entries before grouping; define handling for uncategorized skills. Category names and tags are localized resume content.

**Acceptance criteria:**

- [ ] Flat mode preserves current output.
- [ ] Grouped mode renders each active skill once, including uncategorized entries.
- [ ] Category headings and tags work in RTL and print.

### Feature 2.6: Social Media Cards (Open Graph & Twitter)

**Issue:** [#22](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/22) · **Branch:** `feature/social-media-cards` · **Closure:** `Closes #22`

Improve per-language sharing images and summaries. Basic Open Graph metadata already exists through jekyll-seo-tag; this feature adds richer configuration and fallbacks.

**Files:** Update shared layout/head integration and `_config.sample.yml`; document in `docs/CONFIG_GUIDE.md` and a new `docs/SEO_GUIDE.md`. Add image assets only as required.

**Implementation contract:** The previous draft proposed `og_image` and per-language image/title overrides. Finalize their mapping onto jekyll-seo-tag’s supported inputs before implementation; do not duplicate tags already emitted by {% seo %}. Use languages.<lang> or page data for localized values, not language-suffixed global keys.

**Acceptance criteria:**

- [ ] Each page has a single consistent title, description, image, and card type.
- [ ] Image URLs are absolute and respect subpath hosting.
- [ ] Fallback imagery works when a language has no dedicated image.

### Feature 2.9: Dual Gregorian / Hijri (Islamic) Calendar Localization

**Issue:** [#218](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/218) · **Branch:** `feature/hijri-calendar-support` · **Closure:** `Closes #218`

Offer Gregorian, Hijri, or dual display and optional numeral styling without changing source ISO dates.

**Files:** Extend `_includes/date-formatter.html` and its callers, especially `_includes/grouped-item-list.html`; update locale files, validator rules, `_config.sample.yml`, and date documentation.

**Implementation contract:** Keep the implementation locale-driven. The old arabic_date_calendar/arabic_numerals and language-specific month-file draft must be redesigned into the current locale/config model before coding. Proposed optional `hijri_startdate` values can provide authored display text; do not imply calendar conversion exists merely from replacing month names. If conversion is added, specify and test its calendar convention.

**Acceptance criteria:**

- [ ] Gregorian remains the default and fallback when Hijri text is absent.
- [ ] Present markers retain their locale labels in every calendar mode.
- [ ] Dual dates and numeral choices work in Arabic and Urdu without language-specific templates.

### Feature 3.1: Standard JSON Resume Exporter

**Issue:** [#6](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/6) · **Branch:** `feature/json-resume-export` · **Closure:** `Closes #6`

Export localized YAML resume data in the JSON Resume format.

**Files:** Create a generator under `_plugins/` and register it in `lib/bilingual-jekyll-resume-theme.rb`; document mappings in a new `docs/JSON_RESUME_EXPORT.md` and add export tests.

**Implementation contract:** The previous `json_resume_export_language: en/ar/dual` proposal only covered two languages. Define configurable export languages and collision-safe per-language routes using `site.languages` before implementation. Map header/contact to basics, experience to work, volunteering to volunteer, education to education, certifications to certificates, recognitions to awards, and supported skills/languages/interests/projects/links to their schema equivalents. Document unsupported fields instead of silently claiming lossless export. Pin and validate against the chosen JSON Resume schema; parsing JSON alone is not schema validation.

**Acceptance criteria:**

- [ ] Every configured export is valid against the chosen schema, not just parseable JSON.
- [ ] Exports use the same resolved data path and contact policy as the CV.
- [ ] Inactive entries are excluded and optional/missing fields do not corrupt output.
- [ ] Non-Latin data and multiple export languages work without EN/AR-specific code.

### Feature 4.2: Interactive Career Timeline Visualization

**Issue:** [#16](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/16) · **Branch:** `feature/career-timeline` · **Closure:** `Closes #16`

Add a timeline presentation for career milestones, reusing current multilingual resume data.

**Files:** Create `_layouts/resume-timeline.html` and `_sass/_timeline.scss`; reuse shared head/data/date components and document the layout in a new `docs/TIMELINE_GUIDE.md`.

**Implementation contract:** Use a semantic chronological structure with optional progressive enhancement. Explicitly provide the new layout on hand-authored pages; the existing generator only creates resume/profile layouts. Keep plain-text reading and print order coherent.

**Acceptance criteria:**

- [ ] Career entries render in a defined chronological order.
- [ ] The visual timeline mirrors appropriately in RTL.
- [ ] Keyboard access and a readable print/text fallback work without interaction.

### Feature 4.3: Contact Form Integration (Formspree / Netlify)

**Issue:** [#20](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/20) · **Branch:** `feature/contact-form` · **Closure:** `Closes #20`

Add an optional contact form with inline or modal presentation and a configured submission backend.

**Files:** Create `_includes/contact-form.html`; integrate into shared layouts, locale strings, styles, `_config.sample.yml`, and a new `docs/CONTACT_FORM_GUIDE.md`.

**Implementation contract:** Proposed settings: `resume_contact_form` (false) and `contact_form` with `provider`, `display_mode`, provider ID or `endpoint`. Earlier provider candidates include Formspree, Formcarry, Netlify, and Getform; verify each provider’s current integration contract during implementation. A honeypot may reduce spam but is not a guarantee. Keep secrets out of static output and define success/error states.

**Acceptance criteria:**

- [ ] Submission reaches the configured provider and reports success/failure accessibly.
- [ ] Modal mode supports keyboard focus, Escape, close control, and focus restoration.
- [ ] All labels/states are localized; the form is excluded from print.

### Feature 4.4: Privacy-First Resume Engagement Analytics

**Issue:** [#17](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/17) · **Branch:** `feature/privacy-analytics` · **Closure:** `Closes #17`

Add opt-in print and outbound-link events on top of the existing analytics integration.

**Files:** Create `assets/js/resume-analytics.js`; wire it through shared layout/analytics includes, `_config.sample.yml`, and a new `docs/ANALYTICS_GUIDE.md`.

**Implementation contract:** Proposed toggle: `resume_engagement_analytics` (false). Define event payloads and enabled-provider behavior. Avoid sending contact details or sensitive URL parameters. The dispatcher can avoid writing cookies/storage, but that does not establish that a configured third-party provider is cookie-free or privacy-preserving.

**Acceptance criteria:**

- [ ] Disabled mode emits no engagement events.
- [ ] Enabled print/link events fire once and degrade safely without a provider.
- [ ] Payloads omit personal data and the dispatcher does not add cookies/storage.

### Feature 4.5: Resume Comparison View

**Issue:** [#23](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/23) · **Branch:** `feature/resume-comparison` · **Closure:** `Closes #23`

Provide a side-by-side manual comparison of two existing resume pages or translations. The current proposal is a comparison UI, not a traffic-randomization or statistical A/B testing engine.

**Files:** Create `_layouts/resume-comparison.html`, optional `_includes/version-switcher.html`, `_sass/_comparison.scss`, and a new `docs/VERSIONING_GUIDE.md`.

**Implementation contract:** Accept page-level `v1_url`, `v2_url`, and localized pane labels; resolve local paths through relative_url. Label embedded panes and provide direct links. Existing data_path selection supports separate datasets; automatic role-specific tailoring is not part of this feature.

**Acceptance criteria:**

- [ ] Both chosen pages are visible with distinct accessible labels.
- [ ] The view stacks on narrow screens and supports LTR/RTL content.
- [ ] Missing/invalid targets have a documented fallback rather than blank unlabeled panes.

### Feature 4.7: Dynamic Custom Resume Sections Engine

**Issue:** [#219](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/219) · **Branch:** `feature/custom-sections-engine` · **Closure:** `Closes #219`

Allow additional sections such as patents or speaking without manually extending the standard dispatcher for each one.

**Files:** Create `_includes/resume-custom-section.html`; extend `_includes/resume-section.html`, data validation, locale overrides, and config/data guides.

**Implementation contract:** Keep `resume_section_order` and section toggles. Proposed generic items contain `title`, `subtitle`, `date`, `url`, `description`, and `active`. Put custom headings under `locale.ui.section_titles` through site locale overrides, matching the current localization contract. The previous custom_section_titles global map would duplicate that source of truth. Define custom validation behavior alongside rendering.

**Acceptance criteria:**

- [ ] A configured custom section renders its localized heading and active items.
- [ ] Existing twelve section schemas and rendering remain compatible.
- [ ] Unknown/missing data behaves predictably, and links/dates work in RTL and print.

### Feature 4.8: Client-Side Site Search Index

**Issue:** [#225](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/225) · **Branch:** `feature/site-search` · **Closure:** `Closes #225`

Add localized resume search and an error-page search interface. The current error layout has no search form; both the index and interface remain future work.

**Files:** Create a generated `search.json` and `assets/js/site-search.js`; add a labelled form/results region to `_layouts/error.html` or a reusable include, plus locale strings and styles.

**Implementation contract:** Index resolved data for every configured language. Include active standard-section items, interests (which have no active flag), and deliberate summary text. Define stable result anchors before linking to sections/items. Use relative_url for index loading, exclude private/inactive data, and announce result updates accessibly.

**Acceptance criteria:**

- [ ] Queries return usable links for the selected language without a full navigation.
- [ ] Empty, no-match, index-load-error, and JavaScript-disabled states are defined.
- [ ] All twelve standard sections are represented with the correct visibility rules.
- [ ] Keyboard navigation, RTL, and baseurl hosting work.

## 4. Verification and Delivery

Follow [AGENTS.md](AGENTS.md) for the commit-approval and delivery rules. A documentation blueprint is not proof that a feature exists. Update current guides and `_config.sample.yml` only when implementation lands; move completed features to the audit history and the appropriate changelog boundary.

From the theme repository, with the demo submodule initialized:

```bash
git submodule update --init --recursive
bundle exec jekyll build --source demo --destination _site --strict_front_matter --trace
bundle exec rake
bundle exec rake "proof[_site,demo/_config.yml]"
./bin/validate-resume demo/_data --all-locales --fail-on-warnings
gem build bilingual-jekyll-resume-theme.gemspec
rm -f bilingual-jekyll-resume-theme-*.gem
```

For UI changes, inspect all configured locales, both direction stylesheets, light/dark states, keyboard operation, and print output. Add feature-specific verification that tests the behavior rather than only looking for a string in generated HTML. The default Rake task includes data validation, template-key warnings, RuboCop, and four test suites; HTML proofing is separate. See [docs/VALIDATION_GUIDE.md](docs/VALIDATION_GUIDE.md).
