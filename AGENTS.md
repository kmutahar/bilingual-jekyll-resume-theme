# AGENTS.md — Master AI Agent Operating Manual

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
10. [Arabic (RTL) Layout & Internationalization Mechanics](#10-arabic-rtl-layout--internationalization-mechanics)
11. [Testing in a Consuming Site](#11-testing-in-a-consuming-site)
12. [Troubleshooting & Debugging Guide](#12-troubleshooting--debugging-guide)
13. [Documentation Master Index & Living Docs Governance](#13-documentation-master-index--living-docs-governance)

---

## 1. Project Overview & Key Links

**bilingual-jekyll-resume-theme** is a production Ruby gem / Jekyll theme (v0.8.0) for building data-driven, bilingual (English & Arabic) resume and CV websites. It offers high-fidelity visual parity between Left-to-Right (LTR) and Right-to-Left (RTL) layouts with dynamic data resolution and dark mode support.

- **Author & Maintainer**: Khaldoon Mutahar (`contact@mutahar.me`)
- **License**: MIT License ([LICENSE.txt](LICENSE.txt))
- **Jekyll Requirement**: 4.4+
- **RubyGems**: https://rubygems.org/gems/bilingual-jekyll-resume-theme
- **GitHub Repository**: https://github.com/kmutahar/bilingual-jekyll-resume-theme
- **Bug Tracker**: https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues
- **Demo / Homepage**: https://www.mutahr.me/bilingual-jekyll-resume-theme
- **Changelog**: [CHANGELOG.md](CHANGELOG.md)

---

## 2. Agent Golden Rules & Operating Protocol

Whenever an AI agent operates in this codebase, the following rules are non-negotiable:

### Rule 1: Strict Bilingual Parity (EN & AR)
Every resume section, UI layout, or visual component exists in dual form:
- English (LTR): `_layouts/resume-en.html`, `_includes/resume-section-en.html`, `assets/css/cv.scss`
- Arabic (RTL): `_layouts/resume-ar.html`, `_includes/resume-section-ar.html`, `assets/css/cv-ar.scss` (with `_sass/_resume-rtl.scss`)

**Never modify an English layout, include, or schema without making the corresponding, mirrored modification to its Arabic counterpart.**

### Rule 2: Single Source of Truth for Agent Guidance
`AGENTS.md` is the only file holding project context and operational instructions for AI tools. Any companion pointer files ([`CLAUDE.md`](CLAUDE.md), [`WARP.md`](WARP.md)) must merely point here. Never duplicate documentation across multiple agent files.

### Rule 3: Roadmap-Driven Implementation
All upcoming feature work is planned and blueprinted in [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md). Before starting a feature:
1. Consult its turnkey blueprint in `FEATURE_ROADMAP.md` for target files, YAML schemas, Liquid architecture, and test criteria.
2. Follow the issue-closing git workflow specified in the roadmap.

### Rule 4: Historical Audit Awareness
Before addressing bugs, security findings, or refactors, consult [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md). All 18 historical remediations (P0.1–P0.16, P1.4, P2.4) and resolved issues are documented there. Never re-implement or revert established security and architecture remediations.

### Rule 5: Build & Packaging Verification
Never declare a task finished without running:
```bash
# In this theme repository (uses sample config to activate plugins):
bundle exec jekyll build --config docs/_data/_config.sample.yml

# Package verification:
gem build bilingual-jekyll-resume-theme.gemspec
```
Ensure that the static site compiles cleanly without Liquid errors and the gemspec packages properly (and remove the temporary `.gem` artifact after testing).

---

## 3. Roadmap, GitHub Issues & Git Workflow

### Active Roadmap Reference (Canonical Status Document)
The authoritative master roadmap is maintained exclusively in [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md). In accordance with Living Docs Governance, `FEATURE_ROADMAP.md` is the single canonical owner of all active features, engineering blueprints, issue mappings, and the intentional-removal Delete-Zone:
- **Phase Breakdown**: 20 active features across Priority 1 (Quick Wins), Priority 2 (Core Functional), Priority 3 (Tooling & CI/CD), and Priority 4 (Ecosystem Expansion).
- **Canonical Master Matrix**: Consult [`FEATURE_ROADMAP.md#1-active-features-master-matrix`](FEATURE_ROADMAP.md#1-active-features-master-matrix) for exact issue IDs, auto-closing references, and target files before beginning any feature branch.
- **Status Delete-Zone**: Consult [`FEATURE_ROADMAP.md#status-delete-zone`](FEATURE_ROADMAP.md#status-delete-zone) to verify intentionally removed or deprecated components before adding files.

### Living Docs Navigation Hierarchy
When operating in this codebase, agents must follow this reading sequence:
1. **Constitution** ([`AGENTS.md`](AGENTS.md)): Mandatory operating rules, bilingual parity, git workflow.
2. **Map** ([`docs/PROJECT_OVERVIEW.md`](docs/PROJECT_OVERVIEW.md)): Repository structure, file map, architecture jump table.
3. **Status** ([`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md)): Active features, blueprints, blockers, and delete-zone.
4. **History** ([`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md) & [`CHANGELOG.md`](CHANGELOG.md)): Permanent audit of 18 completed remediations and release log.

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

### Environment Setup & Local Server
```bash
# Install dependencies (Bundler 2+)
bundle install

# Start local Jekyll development server in this repo (http://localhost:4000)
bundle exec jekyll serve --config docs/_data/_config.sample.yml

# Run server with live reloading and incremental builds
bundle exec jekyll serve --config docs/_data/_config.sample.yml --livereload --incremental

# Build static output to _site/ (in this theme repository)
bundle exec jekyll build --config docs/_data/_config.sample.yml

# Clean cached Jekyll build artifacts
bundle exec jekyll clean
```

### Gem Packaging & Verification
```bash
# Build the Ruby gem locally
gem build bilingual-jekyll-resume-theme.gemspec

# Test local gem installation
gem install bilingual-jekyll-resume-theme-0.8.0.gem

# Verify all files packaged in the gem match gemspec patterns
git ls-files -z | tr '\0' '\n' | grep -E '^(assets|_data|_layouts|_includes|_sass|LICENSE|README|CHANGELOG|CODE_OF_CONDUCT|docs|404|403|500)'

# Remove local gem file after testing
rm -f bilingual-jekyll-resume-theme-*.gem
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
./bin/release 0.8.0

# Auto-detect next version via git-cliff:
./bin/release --bump
```
*Note: Pushing the git tag automatically triggers `.github/workflows/publish.yml`, which publishes the gem to RubyGems.org, creates the GitHub Release with notes extracted from `CHANGELOG.md`, and attaches the `.gem` file.*


---

## 5. High-Level Architecture

### Dual-Language Layout System

| Layout File | Language | Direction | Primary Data Source |
|---|---|---|---|
| `_layouts/resume-en.html` | English | LTR (`dir="ltr"`) | `site.active_resume_path_en` (default: `en`) |
| `_layouts/resume-ar.html` | Arabic | RTL (`dir="rtl"`) | `site.active_resume_path_ar` (default: `ar`) |
| `_layouts/default.html` | Base | Dynamic | Extends base HTML skeleton |
| `_layouts/profile.html` | Base | Dynamic | Landing page / portfolio homepage |
| `_layouts/error.html` | Shared | Dynamic | HTTP status code error suite (404, 403, 500) |

### Dynamic Section Rendering Engine
Sections are **never hardcoded** in layout files. The template loops through the array defined in `site.resume_section_order` (`_config.yml`):
```liquid
{% for section in site.resume_section_order %}
  {% include resume-section-en.html section_name=section %}
{% endfor %}
```
Inside `_includes/resume-section-en.html` and `_includes/resume-section-ar.html`, an `{% if / elsif %}` dispatcher renders the matching component.

**12 Standard Sections**:
1. `experience`
2. `education`
3. `certifications`
4. `courses`
5. `volunteering`
6. `projects`
7. `skills`
8. `recognitions`
9. `associations`
10. `interests`
11. `languages`
12. `links`

### Dynamic Data Path Resolution
To support versioned or date-stamped resumes (e.g. `2025-06.20250621-PM`), the layouts utilize a Liquid loop resolving dot-separated paths:
1. Reads `site.active_resume_path_en` from `_config.yml`.
2. Splits the string by `.` (e.g. `["2025-06", "20250621-PM"]`).
3. Recursively accesses `site.data` objects: `site.data["2025-06"]["20250621-PM"]`.
4. Binds the resulting hash to `resume_data`.

---

## 6. Modern Systems Architecture

Key architectural systems established in the theme:

### 1. Site-Wide Dark Mode & Theme Variables
- Managed via `_sass/_dark-mode.scss` and centralized CSS custom variables (`--bg-color`, `--text-color`, `--card-bg`, etc.).
- Respects `prefers-color-scheme: dark` with client toggle persistence (`localStorage`).

### 2. Configurable Avatar Include
- Component: `_includes/avatar.html`
- Controlled by boolean `site.resume_avatar: true/false` in resume layouts (`resume-en.html`, `resume-ar.html`).
- Resolves image source via `site.avatar_url | default: site.avatar | default: '/assets/images/Profile-min.jpg'`. Supports local relative paths or external URLs with subpath-safe `relative_url` filtering.
- Provides localized alt text (`site.avatar_alt_en`, `site.avatar_alt_ar`, or name fallbacks) and configurable link wrapping (`site.avatar_link`, `site.avatar_link_target`).

### 3. HTTP Error Suite Layout & Generator
- Layout: `_layouts/error.html`
- Consumed by root error pages: `404.html`, `403.html`, `500.html`.
- Generator Plugin: `_plugins/error_pages_generator.rb` automatically synthesizes error pages if omitted by consuming site.
- Bilingual friendly with search box, dynamic return links (`site.resume_en_url`, `site.resume_ar_url`), and clear error diagnostics.

### 4. WCAG 2.2 Accessibility
- Added `.sr-only` screen-reader helper classes in `_sass/_base.scss`.
- Enforces minimum 4.5:1 color contrast ratios across light and dark modes.
- Added explicit `aria-label` attributes on icon-only interactive links.

---

## 7. Repository File Map

```text
bilingual-jekyll-resume-theme/
├── 403.html                      # Root HTTP 403 Access Forbidden page
├── 404.html                      # Root HTTP 404 Page Not Found page
├── 500.html                      # Root HTTP 500 Internal Server Error page
│
├── _layouts/
│   ├── default.html              # Base HTML shell
│   ├── resume-en.html            # English resume layout (LTR)
│   ├── resume-ar.html            # Arabic resume layout (RTL)
│   ├── profile.html              # Standalone landing / profile page
│   └── error.html                # HTTP error suite (404/403/500)
│
├── _includes/
│   ├── resume-section-en.html    # English section dispatcher (12 sections)
│   ├── resume-section-ar.html    # Arabic section dispatcher (12 sections)
│   ├── resume-head-en.html       # English metadata and Google font links
│   ├── resume-head-ar.html       # Arabic metadata and Cairo font links
│   ├── shared-head.html          # Shared SEO, icons, and theme colors
│   ├── main-head.html            # Default and error page header metadata
│   ├── profile-head.html         # Profile landing page header metadata and stylesheet
│   ├── avatar.html               # Configurable, accessible profile picture
│   ├── dark-mode-toggle.html     # Floating dark mode interactive toggle button
│   ├── ar-date.html              # Arabic date translation engine
│   ├── social-links.html         # Interactive SVG social media links
│   ├── print-social-links.html   # Plaintext printable contact details
│   ├── hreflang.html             # Multilingual SEO alternate links
│   ├── analytics-head.html       # Google Analytics / GTM head loader
│   ├── analytics-body.html       # GTM noscript body loader
│   └── vendors/                  # Bundled Lineicons SVGs (v4.0 & v5.0)
│
├── _sass/
│   ├── _variables.scss           # Typography, spacing, breakpoints, light tokens
│   ├── _dark-mode.scss           # Dark theme CSS variables & overrides
│   ├── _base.scss                # Reset, .sr-only, base typography
│   ├── _layout.scss              # Responsive containers and grid layout
│   ├── _resume.scss              # Core resume section component styles
│   ├── _resume-rtl.scss          # Mirrored RTL positioning and font styles
│   ├── _profile-page.scss        # Portfolio landing page styles
│   ├── _profile.scss             # Profile styles forwarder
│   ├── _all-pages.scss           # Universal styles across all layouts
│   ├── _mixins.scss              # Breakpoint and responsive mixins
│   └── _normalize.scss           # Normalize.css reset
│
├── assets/
│   ├── css/
│   │   ├── cv.scss               # Main English resume stylesheet
│   │   ├── cv-ar.scss            # Main Arabic resume stylesheet
│   │   ├── profile.scss          # Dedicated profile page stylesheet
│   │   └── main.scss             # Default/error pages stylesheet
│   └── favicon/resume/           # High-resolution favicon suite
│
├── _plugins/
│   └── error_pages_generator.rb  # Automatically synthesizes missing HTTP error pages
│
├── lib/
│   └── bilingual-jekyll-resume-theme.rb # Ruby gem entrypoint and runtime extensions
│
├── _data/
│   ├── ar/
│   │   └── months.yml            # Arabic month names dictionary
│   └── error_pages.yml           # Centralized bilingual error copy
│
├── docs/
│   ├── COMPLETED_AUDIT.md        # Permanent historical record of remediations
│   ├── CONFIG_GUIDE.md           # Exhaustive _config.yml settings manual
│   ├── DATA_GUIDE.md             # Complete data schema guide with examples
│   ├── INCLUDES_GUIDE.md         # Component include mechanics
│   ├── LAYOUTS_GUIDE.md          # Layout rendering and data flow
│   ├── SASS_GUIDE.md             # Styling system, RTL overrides, and dark mode tokens
│   ├── PROJECT_OVERVIEW.md       # High-level architecture summary
│   └── _data/                    # Starter template data (en/ar) for users
│
├── .github/
│   ├── workflows/
│   │   └── publish.yml           # Auto-publishes gem upon release creation
│   └── dependabot.yml            # Automated dependency updates
│
├── FEATURE_ROADMAP.md            # Active master roadmap for 20 open features
├── AGENTS.md                     # Master AI instruction manual (THIS FILE)
├── CLAUDE.md                     # Claude Code lightweight pointer (@AGENTS.md)
├── WARP.md                       # Warp terminal lightweight pointer (@AGENTS.md)
├── bilingual-jekyll-resume-theme.gemspec # Gem manifest and file packager
├── Gemfile                       # Bundler dependencies
├── CHANGELOG.md                  # Release history
├── README.md                     # User-facing theme introduction
├── SECURITY.md                   # Security vulnerability reporting policy
├── LICENSE.txt                   # MIT License terms
├── bin/release                   # Automated release script
└── cliff.toml                    # Git-cliff changelog generator configuration
```

---

## 8. Data Structure & Schemas

In consuming sites, resume data is organized by language in `_data/en/` and `_data/ar/`:

```
_data/
├── en/
│   ├── header.yml          # Headline, bio summary, contact highlights
│   ├── experience.yml      # Professional work history
│   ├── education.yml       # Degrees and academic achievements
│   ├── skills.yml          # Technical competencies and toolsets
│   ├── certifications.yml  # Certifications and credentials
│   ├── projects.yml        # Featured open-source or commercial projects
│   └── ...                 # Other section data files
└── ar/
    ├── header.yml
    ├── experience.yml
    └── ...
```

### Common Schema Conventions
- **`active: true/false`**: Every item in every list can be toggled without deleting the entry.
- **Date Ranges**: Expressed as `start_date` and `end_date` (or `present: true` for current roles).
- **Bilingual Strings**: Never hardcode English strings into templates; ensure UI strings (e.g. "Present" -> `"حتى الآن"`) are localized or loaded from data.

---

## 9. Configuration Reference (`_config.yml`)

Key configuration flags in consuming sites:

| Setting | Type | Purpose | Example |
|---|---|---|---|
| `theme` | String | Activates gem theme | `theme: bilingual-jekyll-resume-theme` |
| `active_resume_path_en` | String | Data subpath for English | `"en"` or `"2025-06.v1"` |
| `active_resume_path_ar` | String | Data subpath for Arabic | `"ar"` or `"2025-06.v1-ar"` |
| `resume_section_order` | Array | Custom rendering sequence | `["experience", "education", "skills"]` |
| `resume_section.<name>` | Boolean | Toggle specific section | `resume_section.projects: true` |
| `display_header_contact_info` | Boolean | Show contact info in header | `true` |
| `resume_avatar` | Boolean | Toggle avatar display in resume header | `true` |
| `resume_en_url` | String | Custom URL path for English resume (used by error pages) | `"/en/cv/"` |
| `resume_ar_url` | String | Custom URL path for Arabic resume (used by error pages) | `"/ar/cv/"` |

---

## 10. Arabic (RTL) Layout & Internationalization Mechanics

Working with the Arabic layout requires strict attention to RTL conventions:

1. **Root Direction**: `_layouts/resume-ar.html` sets `<html dir="rtl" lang="ar">`.
2. **Typography**: Arabic uses specialized web fonts (Cairo by default, or configurable via `site.font_ar_url`) with adjusted line-heights (`line-height: 1.6` minimum) to prevent diacritic clipping.
3. **Date Localization**: The `_includes/ar-date.html` helper takes an ISO date and translates month numbers to Arabic names using `_data/ar/months.yml`.
4. **Mirrored Layout**: Margins, paddings, timeline bullets, and header icons mirror horizontally:
   - Use CSS logical properties where appropriate (`margin-inline-start`, `padding-inline-end`).
   - For legacy CSS, define standard rules in `_resume.scss` and mirrored overrides in `_resume-rtl.scss`.
5. **LTR Code & Numbers**: Phone numbers, URLs, and code snippets within Arabic text must be wrapped with `<span dir="ltr">` to prevent bidirectional punctuation distortion.

---

## 11. Testing in a Consuming Site

To verify changes in an actual Jekyll site without publishing a gem:
1. In the consuming site's `Gemfile`:
   ```ruby
   gem "bilingual-jekyll-resume-theme", path: "../bilingual-jekyll-resume-theme"
   ```
2. In the consuming site's `_config.yml`:
   ```yaml
   theme: bilingual-jekyll-resume-theme
   ```
3. Run `bundle install && bundle exec jekyll serve`.

---

## 12. Troubleshooting & Debugging Guide

- **Section Not Appearing**: Check that the section name is included in `site.resume_section_order` AND `site.resume_section.<name>` is not set to `false`. Ensure both `resume-section-en.html` and `resume-section-ar.html` contain the branch.
- **Arabic Dates Showing in English**: Verify `_data/ar/months.yml` exists and `_includes/ar-date.html` is being passed a valid date string (`YYYY-MM-DD`).
- **Styles Broken After Edit**: Check for SASS syntax errors; run `bundle exec jekyll build --trace`. Clear `.jekyll-cache` with `bundle exec jekyll clean`.
- **Files Missing from Built Gem**: Check `spec.files` regex in `bilingual-jekyll-resume-theme.gemspec`. Only tracked git files matching the regex are packaged.

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
| **Feature Roadmap** | [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md) | **Status** | Turnkey blueprints for 20 active features & status delete-zone |
| **Completed Audit** | [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md) | **History** | Historical record of 18 completed remediations & closed issues |
| **Changelog** | [`CHANGELOG.md`](CHANGELOG.md) | **History** | Chronological version history following Keep a Changelog |
| **Config Guide** | [`docs/CONFIG_GUIDE.md`](docs/CONFIG_GUIDE.md) | Reference | Comprehensive reference for all `_config.yml` options |
| **Data Guide** | [`docs/DATA_GUIDE.md`](docs/DATA_GUIDE.md) | Reference | YAML data schemas for all 12 resume sections |
| **Layouts Guide** | [`docs/LAYOUTS_GUIDE.md`](docs/LAYOUTS_GUIDE.md) | Reference | Dual-language layout architecture and data flow |
| **Includes Guide** | [`docs/INCLUDES_GUIDE.md`](docs/INCLUDES_GUIDE.md) | Reference | Component architecture and guide to creating new sections |
| **SASS Guide** | [`docs/SASS_GUIDE.md`](docs/SASS_GUIDE.md) | Reference | Styling system, RTL overrides, and dark mode tokens |
| **Claude Pointer** | [`CLAUDE.md`](CLAUDE.md) | Constitution Pointer | Lightweight delegation pointer for Anthropic Claude Code |
| **Warp Pointer** | [`WARP.md`](WARP.md) | Constitution Pointer | Lightweight delegation pointer for Warp terminal |
| **Security Policy** | [`SECURITY.md`](SECURITY.md) | Policy | Vulnerability reporting channels and supported release branches |
