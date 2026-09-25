# AGENTS.md: Master AI Agent Operating Manual

> **Authoritative Single Source of Truth**: This document is the master instruction manual for all AI coding assistants, autonomous agents, and pair programmers (Google Antigravity, Cursor, Warp, Copilot, Claude Code, Codex, etc.) working in this repository.
>
> *Note for Claude Code / Warp users*: [`CLAUDE.md`](CLAUDE.md) and [`WARP.md`](WARP.md) reference this master document. Do not create separate diverging guides; maintain all guidance in this file.

---

## Table of Contents

1. [Project Overview & Key Links](#1-project-overview--key-links)
2. [Agent Golden Rules & Operating Protocol](#2-agent-golden-rules--operating-protocol)
3. [Roadmap, GitHub Issues & Git Workflow](#3-roadmap-github-issues--git-workflow)
4. [Common Developer Commands](#4-common-developer-commands)
5. [High-Level Architecture](#5-high-level-architecture)
6. [Modern Systems Architecture](#6-modern-systems-architecture)
7. [Repository File Map](#7-repository-file-map)
8. [Data Structure & Schemas](#8-data-structure--schemas)
9. [Configuration Reference (`_config.yml`)](#9-configuration-reference-_configyml)
10. [RTL & Internationalization Mechanics](#10-rtl--internationalization-mechanics)
11. [Testing in a Consuming Site](#11-testing-in-a-consuming-site)
12. [Troubleshooting & Debugging Guide](#12-troubleshooting--debugging-guide)
13. [Documentation Master Index & Living Docs Governance](#13-documentation-master-index--living-docs-governance)

---

## 1. Project Overview & Key Links

**bilingual-jekyll-resume-theme** is a Ruby gem / Jekyll theme for data-driven, multilingual resume and CV websites. One locale-agnostic layout renders every language, LTR or RTL, from per-language YAML data and locale files. Six locales ship with the theme: English (`en`), Arabic (`ar`), Spanish (`es`), French (`fr`), German (`de`), and Urdu (`ur`). The current version is `spec.version` in [`bilingual-jekyll-resume-theme.gemspec`](bilingual-jekyll-resume-theme.gemspec); v1.0.0 (the multilingual release) is the hard break described in [`docs/MULTILINGUAL_GUIDE.md`](docs/MULTILINGUAL_GUIDE.md#breaking-changes--migration-v090-to-v100).

- **Author & Maintainer**: Khaldoon Mutahar (`contact@mutahar.me`)
- **License**: MIT License ([LICENSE.txt](LICENSE.txt))
- **Requirements**: Ruby 3.3+, Jekyll 4.4+
- **RubyGems**: https://rubygems.org/gems/bilingual-jekyll-resume-theme
- **GitHub Repository**: https://github.com/kmutahar/bilingual-jekyll-resume-theme
- **Bug Tracker**: https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues
- **Demo / Homepage**: https://www.mutahr.me/bilingual-jekyll-resume-theme
- **Changelog**: [CHANGELOG.md](CHANGELOG.md)

---

## 2. Agent Golden Rules & Operating Protocol

Whenever an AI agent operates in this codebase, the following rules are non-negotiable:

### Rule 1: All-Locale Parity
Every language renders through the same files: `_layouts/resume.html`, `_includes/resume-section.html`, `_includes/date-formatter.html`, and the direction-based stylesheets (`assets/css/cv-ltr.scss`, `assets/css/cv-rtl.scss` with `_sass/_resume-rtl.scss` layered last). Language differences live only in data:

- **Visible text** belongs in `_data/locales/<lang>.yml`. When you add or rename a key, make the same change in all six locale files (`en`, `ar`, `es`, `fr`, `de`, `ur`) so their key sets stay identical; the validator warns on any gap.
- **Templates** read the active locale (`locale.ui.*`, `locale.direction`) and never branch on a specific language code (`== 'ar'`, `resume-ar`, `site.*_ar`).
- **Demo data** under `demo/_data/<lang>/` keeps the same files and entries in the same order in all six languages, each natively translated.
- **RTL** changes go in `_sass/_resume-rtl.scss` as language-neutral overrides under `html[dir="rtl"]`; fonts and line heights stay in the locale files.

Verify a template or locale change by building the demo (Rule 5) and checking both an LTR page (`_site/en/cv/`) and both RTL pages (`_site/ar/cv/`, `_site/ur/cv/`).

### Rule 2: Single Source of Truth for Agent Guidance
`AGENTS.md` is the only file holding project context and operational instructions for AI tools. Any companion pointer files ([`CLAUDE.md`](CLAUDE.md), [`WARP.md`](WARP.md)) must merely point here. Never duplicate documentation across multiple agent files.

### Rule 3: Roadmap-Driven Implementation
All upcoming feature work is planned and blueprinted in [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md). Before starting a feature:
1. Consult its turnkey blueprint in `FEATURE_ROADMAP.md` for target files, YAML schemas, Liquid architecture, and test criteria.
2. Follow the issue-closing git workflow specified in the roadmap.

### Rule 4: Historical Audit Awareness
Before addressing bugs, security findings, or refactors, consult [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md). It records the 18 foundation remediations (P0.1 to P0.16, P1.4, P2.4), later completed features, the four features delivered in v1.0.0 (1.7, 2.8, 4.1, 4.6), and the two features delivered in v1.0.1 (2.11, 2.12). Never re-implement or revert an established remediation, and check the roadmap's Status Delete-Zone before recreating any file or key.

### Rule 5: Build & Packaging Verification
Never declare a task finished without running:
```bash
# Demo build: demo consuming site source
bundle exec jekyll build --source demo --destination _site

# Validator, RuboCop, and tests
bundle exec rake

# Package verification (remove the .gem afterwards)
gem build bilingual-jekyll-resume-theme.gemspec
rm -f bilingual-jekyll-resume-theme-*.gem
```
Done means: the build prints no Liquid errors, `bundle exec rake` reports 0 failures and 0 offenses, and the gem builds.

### Rule 6: Never Commit Without Direct Approval
AI agents must **NEVER** execute `git commit` or finalize a commit autonomously without the user's explicit, direct approval or command in the conversation. Agents may stage changes (`git add`) for review, run verifications, and present proposed commit messages, but the actual commit step must always be gated on direct user confirmation.

---

## 3. Roadmap, GitHub Issues & Git Workflow

### Active Roadmap Reference (Canonical Status Document)
The authoritative master roadmap is maintained exclusively in [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md). In accordance with Living Docs Governance, `FEATURE_ROADMAP.md` is the single canonical owner of all active features, engineering blueprints, issue mappings, and the intentional-removal Delete-Zone:
- **Canonical Master Matrix**: Consult [`FEATURE_ROADMAP.md#1-active-features-master-matrix`](FEATURE_ROADMAP.md#1-active-features-master-matrix) for the active features, exact issue IDs, auto-closing references, and target files before beginning any feature branch.
- **Status Delete-Zone**: Consult [`FEATURE_ROADMAP.md#status-delete-zone`](FEATURE_ROADMAP.md#status-delete-zone) to verify intentionally removed or deprecated components before adding files.

### Living Docs Navigation Hierarchy
When operating in this codebase, agents must follow this reading sequence:
1. **Constitution** ([`AGENTS.md`](AGENTS.md)): Mandatory operating rules, all-locale parity, git workflow.
2. **Map** ([`docs/PROJECT_OVERVIEW.md`](docs/PROJECT_OVERVIEW.md)): Repository structure, file map, architecture jump table.
3. **Status** ([`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md)): Active features, blueprints, blockers, and delete-zone.
4. **History** ([`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md) & [`CHANGELOG.md`](CHANGELOG.md)): Completed remediations and features, and the release log.

### Automatic Issue Closing Protocol
Every feature in `FEATURE_ROADMAP.md` is mapped to an open GitHub issue. To automatically close the GitHub issue upon PR merge:
- **Branch Naming**: `feature/<feature-name>` (e.g. `feature/color-themes`)
- **Conventional Commit Format**:
  ```text
  feat(<scope>): <short description> (Closes #<issue_id>)

  <detailed explanation of changes, data schema additions, and tests>

  Closes #<issue_id>
  ```
- **Pull Request Title**: `feat(<scope>): <description> (Closes #<issue_id>)`

---

## 4. Common Developer Commands

The theme repository contains the theme engine, while the full demo site lives in the `demo/` git submodule (which builds as a complete consuming Jekyll site).

### Environment Setup & Local Server
```bash
# Install dependencies (Bundler 2+)
bundle install

# Serve the demo at http://localhost:4000 (resume pages at /en/cv/, /ar/cv/, /es/cv/, /fr/cv/, /de/cv/, /ur/cv/)
bundle exec jekyll serve --source demo --destination _site

# Live reload and incremental builds
bundle exec jekyll serve --source demo --destination _site --livereload --incremental

# Build static output to _site/
bundle exec jekyll build --source demo --destination _site

# Clean cached Jekyll build artifacts
bundle exec jekyll clean
```

### Gem Packaging & Verification
```bash
# Build the Ruby gem locally
gem build bilingual-jekyll-resume-theme.gemspec

# List packaged files (must include _data/locales/*.yml and bin/validate-resume; must exclude test/, Rakefile, bin/release)
gem spec bilingual-jekyll-resume-theme-*.gem files

# Remove local gem file after testing
rm -f bilingual-jekyll-resume-theme-*.gem
```

### Verification Tooling (details: [`docs/VALIDATION_GUIDE.md`](docs/VALIDATION_GUIDE.md))
```bash
bundle exec rake                                           # validate + rubocop + test
bundle exec rake test                                      # Unit tests (validator + language switcher)
bundle exec rake rubocop                                   # Static analysis; must report 0 offenses
bundle exec rake proof                                     # Proof _site/ (build first); or proof[../site/_site]
./bin/validate-resume demo/_data --all-locales --fail-on-warnings   # Multi-language data schema + parity
```

### Dependency Audit
```bash
# Check for outdated gems
bundle outdated

# Update gems within Gemfile version constraints
bundle update
```

### Automated Version Release
```bash
# Release a specific version (updates gemspec, changelog, commits, tags, and pushes to origin):
./bin/release <version>

# Auto-detect next version via git-cliff:
./bin/release --bump
```
*Note: Pushing the git tag automatically triggers `.github/workflows/publish.yml`, which publishes the gem to RubyGems.org, creates the GitHub Release with notes extracted from `CHANGELOG.md`, and attaches the `.gem` file. `bin/release` regenerates `CHANGELOG.md` with `git-cliff -o`, which overwrites hand-written sections; carry any hand-written release notes (such as the v1.0.0 Breaking Changes table) into the regenerated file before tagging.*

---

## 5. High-Level Architecture

### Layouts

| Layout File | Role | Language & Direction |
|---|---|---|
| `_layouts/resume.html` | Resume for every language | `page.lang`; `dir` from `locale.direction` |
| `_layouts/default.html` | Base shell for markdown and error pages | Same resolution |
| `_layouts/profile.html` | Standalone landing page | Same resolution |
| `_layouts/error.html` | HTTP error suite (404, 403, 500, 503) | One block per `site.languages` entry |

### Language Resolution
Every layout and include resolves the language the same way:
```liquid
{% assign lang = page.lang | default: site.default_lang | default: 'en' %}
{% assign locale = site.data.locales[lang] | default: site.data.locales[site.default_lang] %}
{% assign lang_cfg = site.languages[lang] %}
```
`locale` is the merged locale file (theme `_data/locales/<lang>.yml` with any site override deep-merged on top). `lang_cfg` is the `languages.<lang>` config block.

### Dynamic Section Rendering Engine
Sections are **never hardcoded** in layout files. `resume.html` loops through `site.resume_section_order`:
```liquid
{%- for section_name in site.resume_section_order -%}
  {% include resume-section.html section_name=section_name lang=lang %}
{%- endfor -%}
```
Inside `_includes/resume-section.html`, an `{% if / elsif %}` dispatcher renders the matching section when `site.resume_section.<name>` is truthy, with headings from `locale.ui.section_titles`.

**12 Standard Sections**: `experience`, `education`, `certifications`, `courses`, `volunteering`, `projects`, `skills`, `recognitions`, `associations`, `interests`, `languages`, `links`.

### Dynamic Data Path Resolution
`resume.html` calls `{% include data-loader.html path=lang_cfg.data_path %}`. The include splits the path on `.` and walks `site.data` with bracket access, so `data_path: "2025-06.20250621-PM"` binds `resume_data` to `site.data["2025-06"]["20250621-PM"]` and `""` binds it to `site.data` itself.

---

## 6. Modern Systems Architecture

### 1. Locale System
- `_data/locales/<lang>.yml` holds `direction`, `font_family`, `font_url`, `line_height`, `ui.*` strings, `error_pages`, `present_values`, and `months`. All six files share one key set.
- `resume.html` loads `font_url`, emits `--font-locale` and `--line-height-locale`, and links `assets/css/cv-<direction>.css`.
- Consuming sites override single keys through their own `_data/locales/<lang>.yml` (Jekyll deep-merges hashes; arrays are replaced whole) or add languages with a complete file. See [`docs/MULTILINGUAL_GUIDE.md`](docs/MULTILINGUAL_GUIDE.md).

### 2. Site-Wide Dark Mode & Theme Variables
- Managed via `_sass/_dark-mode.scss` and centralized CSS custom variables (`--bg-color`, `--text-color`, `--card-bg`, etc.).
- Respects `prefers-color-scheme: dark` with client toggle persistence (`localStorage`) when `dark_mode: enabled`.

### 3. Configurable Avatar Include
- Component: `_includes/avatar.html`, rendered by `resume.html` when `site.resume_avatar == true`.
- Source: `site.avatar_url | default: '/assets/images/Profile-min.jpg'`; external URLs (containing `://`) pass through unchanged, local paths through `relative_url`.
- Alt text: `languages.<lang>.avatar_alt`, then `languages.<lang>.name`, then `locale.ui.photo_alt`. Link wrapping via `site.avatar_link` / `site.avatar_link_target`.

### 4. HTTP Error Suite Layout & Generator
- Layout: `_layouts/error.html`, used by `404.html`, `403.html`, `500.html`.
- Generator Plugin: `_plugins/error_pages_generator.rb` synthesizes those pages when a consuming site omits them.
- Renders one localized block per `site.languages` entry from `locale.error_pages`, a search box, and per-language return links to `languages.<lang>.url` (falling back to the page with `layout: resume` and that `lang`).

### 5. Resume Data Validator
- Engine: `lib/bilingual-jekyll-resume-theme/resume_validator.rb`. Entry points: `bin/validate-resume` (gem executable), `rake validate`, and `_plugins/resume_validator.rb` (runs on every build unless `validate_resume: false`; `validate_resume_strict: true` fails the build on errors).
- Reads languages from `languages:` in the config, builds each effective locale (theme file plus site override), and checks schemas, dates, URLs, file parity, and locale key parity. See [`docs/VALIDATION_GUIDE.md`](docs/VALIDATION_GUIDE.md).

### 6. WCAG 2.2 Accessibility
- `.sr-only` screen-reader helper classes in `_sass/_base.scss`.
- Minimum 4.5:1 color contrast across light and dark modes.
- `aria-label` attributes on icon-only links; localized skip links and toggle labels from `locale.ui`.

---

## 7. Repository File Map

```text
bilingual-jekyll-resume-theme/
├── 403.html / 404.html / 500.html  # Root HTTP error pages (layout: error)
├── _config.sample.yml        # Master annotated sample configuration for consuming sites
├── demo/                     # Git submodule: full live Sherlock Holmes demo consuming site
│   ├── _config.yml
│   ├── index.html            # Profile landing page
│   ├── _pages/               # Resume pages for 6 languages
│   └── _data/                # 6 languages YAML data
│
├── _layouts/
│   ├── default.html              # Base HTML shell
│   ├── resume.html               # Resume layout for every language (LTR and RTL)
│   ├── profile.html              # Standalone landing / profile page
│   └── error.html                # HTTP error suite (404/403/500/503)
│
├── _includes/
│   ├── resume-section.html       # Section dispatcher (12 sections, every language)
│   ├── date-formatter.html       # Locale-driven dates and "Present"
│   ├── data-loader.html          # Dot-path data resolution into resume_data
│   ├── shared-head.html          # Meta, anti-FOUC script, favicons
│   ├── main-head.html            # Default/error page stylesheet (main.css)
│   ├── profile-head.html         # Profile page stylesheet (profile.css)
│   ├── avatar.html               # Configurable, accessible profile picture
│   ├── dark-mode-toggle.html     # Floating dark mode toggle
│   ├── language-switcher.html    # Floating links to every other configured language
│   ├── social-links.html         # Social icons (email + 14 platforms)
│   ├── print-social-links.html   # Print-only social links text list
│   ├── hreflang.html             # Alternate-language SEO links
│   ├── analytics-head.html       # GTM / GA4 head loader
│   ├── analytics-body.html       # GTM noscript body loader
│   └── vendors/                  # Bundled Lineicons SVGs (v4.0 & v5.0)
│
├── _sass/
│   ├── _variables.scss           # Widths, gutters, font stacks
│   ├── _dark-mode.scss           # Dark theme CSS variables & overrides
│   ├── _base.scss                # Reset, .sr-only, base typography
│   ├── _layout.scss              # Containers and grid
│   ├── _resume-ltr.scss          # Main resume styles + LTR positioning (reads locale CSS variables)
│   ├── _resume-rtl.scss          # Language-neutral RTL overrides, loaded last
│   ├── _profile-page.scss        # Landing page styles
│   ├── _all-pages.scss           # Universal styles across all layouts
│   ├── _mixins.scss              # Breakpoint and responsive mixins
│   └── _normalize.scss           # Normalize.css reset
│
├── assets/
│   ├── css/
│   │   ├── cv-ltr.scss           # Resume stylesheet for LTR locales
│   │   ├── cv-rtl.scss           # Resume stylesheet for RTL locales
│   │   ├── profile.scss          # Profile page stylesheet
│   │   └── main.scss             # Default/error pages stylesheet
│   └── favicon/resume/           # Favicon suite
│
├── _data/
│   └── locales/                  # en, ar, es, fr, de, ur locale dictionaries
│
├── _plugins/
│   ├── error_pages_generator.rb  # Synthesizes missing HTTP error pages
│   └── resume_validator.rb       # Build-time resume validation (on by default)
│
├── lib/
│   ├── bilingual-jekyll-resume-theme.rb             # Gem entrypoint
│   └── bilingual-jekyll-resume-theme/resume_validator.rb  # Validator engine
│
├── bin/
│   ├── validate-resume           # Validator CLI (gem executable)
│   └── release                   # Automated release script (not packaged)
│
├── test/                         # Minitest suite: validator + language switcher
├── Rakefile                      # validate, test, rubocop, proof, default
├── .rubocop.yml                  # RuboCop configuration
│
├── docs/
│   ├── ACCESSIBILITY_GUIDE.md    # WCAG 2.2 AA accessibility guide
│   ├── COMPLETED_AUDIT.md        # Record of completed remediations and features
│   ├── CONFIG_GUIDE.md           # _config.yml reference
│   ├── DATA_GUIDE.md             # Resume data schemas
│   ├── INCLUDES_GUIDE.md         # Include mechanics
│   ├── LAYOUTS_GUIDE.md          # Layout rendering and data flow
│   ├── MULTILINGUAL_GUIDE.md     # Locales, adding languages, v1.0.0 migration table
│   ├── SASS_GUIDE.md             # Styling system, RTL overrides, dark mode tokens
│   ├── VALIDATION_GUIDE.md       # Validator, CLI, CI, proofing
│   └── PROJECT_OVERVIEW.md       # High-level architecture summary
│
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                # Multi-Ruby CI: gem build, strict Jekyll build, proof, RuboCop, validator, tests
│   │   ├── lint.yml              # Data validator and RuboCop jobs
│   │   └── publish.yml           # Publishes the gem on tag push
│   └── dependabot.yml            # Automated dependency updates
│
├── FEATURE_ROADMAP.md            # Active master roadmap
├── AGENTS.md                     # Master AI instruction manual (THIS FILE)
├── CLAUDE.md                     # Claude Code pointer (@AGENTS.md)
├── WARP.md                       # Warp terminal pointer
├── bilingual-jekyll-resume-theme.gemspec # Gem manifest and file packager
├── Gemfile                       # Bundler dependencies
├── CHANGELOG.md                  # Release history
├── README.md                     # User-facing introduction
├── SECURITY.md                   # Security vulnerability reporting policy
├── LICENSE.txt                   # MIT License terms
└── cliff.toml                    # git-cliff changelog configuration
```

---

## 8. Data Structure & Schemas

In consuming sites, resume data lives in one folder per language, named by `languages.<lang>.data_path`:

```
_data/
├── en/
│   ├── header.yml          # Intro paragraph
│   ├── experience.yml      # Work history
│   ├── education.yml       # Degrees
│   ├── ...                 # 13 files in total, one per section plus header.yml
├── ar/                     # Same file names
├── ...                     # One folder per configured language
└── locales/                # Optional site overrides of theme locale files
```

Full schemas: [`docs/DATA_GUIDE.md`](docs/DATA_GUIDE.md).

### Common Schema Conventions
- **`active: true/false`**: Every list item except in `interests.yml` carries the flag; only `active: true` renders.
- **Dates**: ISO `YYYY-MM-DD`, `YYYY-MM`, or `YYYY` in `startdate` / `enddate`. A blank `enddate` or a value from the locale's `present_values` means ongoing.
- **Localized Strings**: Templates never hardcode visible text. UI strings live in `_data/locales/<lang>.yml` under `ui.*`; resume content lives in the data folders.

---

## 9. Configuration Reference (`_config.yml`)

Key configuration flags in consuming sites (full reference: [`docs/CONFIG_GUIDE.md`](docs/CONFIG_GUIDE.md)):

| Setting | Type | Purpose | Example |
|---|---|---|---|
| `theme` | String | Activates gem theme | `theme: bilingual-jekyll-resume-theme` |
| `languages.<lang>.data_path` | String | Data folder (dot paths allowed) | `"en"` or `"2025-06.v1"` |
| `languages.<lang>.url` | String | Resume URL (error page return links, language switcher fallback) | `"/en/cv/"` |
| `languages.<lang>.header_intro` | Boolean | Render `header.yml` intro | `true` |
| `languages.<lang>.name` / `resume_title` / `address` / `avatar_alt` | String | Per-language header text | `"Jane Doe"` |
| `default_lang` | String | Fallback language and hreflang `x-default` | `en` |
| `resume_section_order` | Array | Rendering sequence | `["experience", "education", "skills"]` |
| `resume_section.<name>` | Boolean | Render a section (must be `true`) | `resume_section.projects: true` |
| `display_header_contact_info` | Boolean | Show contact row in header | `true` |
| `resume_avatar` | Boolean | Show avatar in resume header | `true` |
| `validate_resume` | Boolean | `false` disables build-time validation (on by default) | `false` |
| `validate_resume_strict` | Boolean | Fail the build on validation errors | `true` |

---

## 10. RTL & Internationalization Mechanics

1. **Direction comes from the locale**: `resume.html`, `default.html`, and `profile.html` set `<html lang="{{ lang }}" dir="{{ locale.direction }}">`. Config never sets direction.
2. **Typography**: each locale's `font_family`, `font_url`, and `line_height` feed `--font-locale` / `--line-height-locale`. Arabic uses Cairo at `1.6` (diacritics); Urdu uses Noto Nastaliq Urdu at `2.0` (tall Nastaliq glyphs).
3. **Date Localization**: `_includes/date-formatter.html` maps the month number to `locale.months` and renders `locale.ui.present` for any value in `locale.present_values`.
4. **Mirrored Layout**: `assets/css/cv-rtl.scss` loads `_sass/_resume-ltr.scss` and then `_sass/_resume-rtl.scss`, whose rules under `html[dir="rtl"]` mirror floats, margins, timeline bullets, and header icons for every RTL locale. Prefer CSS logical properties (`margin-inline-start`) in new rules.
5. **LTR Runs in RTL Text**: phone numbers, emails, URLs, and credential IDs are wrapped in `dir="ltr"` when `locale.direction == 'rtl'` to prevent bidirectional punctuation distortion.

---

## 11. Testing in a Consuming Site

To verify changes in an actual Jekyll site without publishing a gem:
1. In the consuming site's `Gemfile` (the `:jekyll_plugins` group is required for the error page generator and validator to load):
   ```ruby
   group :jekyll_plugins do
     gem "bilingual-jekyll-resume-theme", path: "../bilingual-jekyll-resume-theme"
   end
   ```
2. In the consuming site's `_config.yml`:
   ```yaml
   theme: bilingual-jekyll-resume-theme
   ```
3. Run `bundle install && bundle exec jekyll serve`.

---

## 12. Troubleshooting & Debugging Guide

- **Section Not Appearing**: The name must be in `site.resume_section_order`, `site.resume_section.<name>` must be `true`, the language's data folder must contain `<name>.yml`, and items must have `active: true`.
- **Page Renders Without Name or Data**: The page's `lang` has no `languages.<lang>` entry, or its `data_path` folder is missing. Run `./bin/validate-resume <data_dir>`.
- **Dates or "Present" Not Localized**: The page's `lang` has no locale file, so the `default_lang` locale is used; or the `enddate` word is not in that locale's `present_values`.
- **Wrong Font in One Language**: Check that locale's `font_family` / `font_url`, and that `disable_google_fonts` is not `true`.
- **Styles Broken After Edit**: Check for SASS syntax errors; run the demo build with `--trace`. Clear `.jekyll-cache` with `bundle exec jekyll clean`.
- **Files Missing from Built Gem**: Check the `spec.files` filter in `bilingual-jekyll-resume-theme.gemspec`. Only tracked git files matching it (plus `_plugins/`, `lib/`, `bin/validate-resume`) are packaged.

---

<a id="13-documentation-master-index"></a>
## 13. Documentation Master Index & Living Docs Governance

Under Living Docs Governance, the repository documentation surface assigns four primary roles:
- **Constitution**: Core rules and operational contracts (`AGENTS.md`, `CLAUDE.md`, `WARP.md`)
- **Map**: Architecture guides and navigation maps (`docs/PROJECT_OVERVIEW.md`, `README.md`)
- **Status**: Active feature roadmaps and blueprints (`FEATURE_ROADMAP.md`)
- **History**: Permanent remediation logs and releases (`docs/COMPLETED_AUDIT.md`, `CHANGELOG.md`)

| Document | Path | Living Docs Role | Scope / Purpose |
|---|---|---|---|
| **Master AI Manual** | [`AGENTS.md`](AGENTS.md) | **Constitution** | **Authoritative single source of truth for all AI agents** |
| **Project Overview** | [`docs/PROJECT_OVERVIEW.md`](docs/PROJECT_OVERVIEW.md) | **Map** | High-level summary of architecture and vision |
| **README** | [`README.md`](README.md) | **Map** | User-facing entry point, quick start, and installation guide |
| **Feature Roadmap** | [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md) | **Status** | Blueprints for active features & status delete-zone |
| **Completed Audit** | [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md) | **History** | Record of completed remediations, features, and closed issues |
| **Changelog** | [`CHANGELOG.md`](CHANGELOG.md) | **History** | Version history following Keep a Changelog |
| **Multilingual Guide** | [`docs/MULTILINGUAL_GUIDE.md`](docs/MULTILINGUAL_GUIDE.md) | Reference | Locale files, adding languages, overrides, RTL typography, v1.0.0 migration table |
| **Accessibility Guide** | [`docs/ACCESSIBILITY_GUIDE.md`](docs/ACCESSIBILITY_GUIDE.md) | Reference | WCAG 2.1/2.2 AA compliance, keyboard navigation, landmarks, and contrast |
| **Config Guide** | [`docs/CONFIG_GUIDE.md`](docs/CONFIG_GUIDE.md) | Reference | Every `_config.yml` option |
| **Data Guide** | [`docs/DATA_GUIDE.md`](docs/DATA_GUIDE.md) | Reference | YAML data schemas for all 12 resume sections |
| **Layouts Guide** | [`docs/LAYOUTS_GUIDE.md`](docs/LAYOUTS_GUIDE.md) | Reference | Locale-agnostic layout architecture and data flow |
| **Includes Guide** | [`docs/INCLUDES_GUIDE.md`](docs/INCLUDES_GUIDE.md) | Reference | Component architecture and guide to creating new sections |
| **SASS Guide** | [`docs/SASS_GUIDE.md`](docs/SASS_GUIDE.md) | Reference | Styling system, RTL overrides, and dark mode tokens |
| **Validation Guide** | [`docs/VALIDATION_GUIDE.md`](docs/VALIDATION_GUIDE.md) | Reference | Validator rules, CLI, build-time checks, and CI workflow |
| **Claude Pointer** | [`CLAUDE.md`](CLAUDE.md) | Constitution Pointer | Lightweight delegation pointer for Anthropic Claude Code |
| **Warp Pointer** | [`WARP.md`](WARP.md) | Constitution Pointer | Lightweight delegation pointer for Warp terminal |
| **Security Policy** | [`SECURITY.md`](SECURITY.md) | Policy | Vulnerability reporting channels and supported release branches |
