# AGENTS.md: Master AI Agent Operating Manual (Constitution)

> **Authoritative Single Source of Truth**: This document is the master instruction manual for all AI coding assistants, autonomous agents, and pair programmers (Google Antigravity, Cursor, Warp, Copilot, Claude Code, Codex, etc.) working in this repository.
> 
> *Note for Claude Code / Warp users*: [`CLAUDE.md`](CLAUDE.md) and [`WARP.md`](WARP.md) reference this master document. Do not create separate diverging guides; maintain all guidance in this file.

**bilingual-jekyll-resume-theme** is a Ruby gem / Jekyll theme for data-driven, multilingual resume and CV websites. One locale-agnostic layout renders every language, LTR or RTL, from per-language YAML data and locale files. Six locales ship with the theme: English (`en`), Arabic (`ar`), Spanish (`es`), French (`fr`), German (`de`), and Urdu (`ur`). 
- **RubyGems**: https://rubygems.org/gems/bilingual-jekyll-resume-theme
- **Demo / Homepage**: https://www.mutahr.me/bilingual-jekyll-resume-theme

## 1. Agent Golden Rules & Operating Protocol

Whenever an AI agent operates in this codebase, the following rules are non-negotiable:

### Rule 1: All-Locale Parity
Language differences live only in data. Every language renders through the same layout (`_layouts/resume.html`) and direction-based stylesheets.
- **Visible text** belongs in `_data/locales/<lang>.yml`. When adding or renaming a key, update all six locale files (`en`, `ar`, `es`, `fr`, `de`, `ur`) to maintain identical key sets.
- **Templates** must read the active locale (`locale.ui.*`, `locale.direction`) and never branch on a specific language code.
- **RTL** changes go in `_sass/_resume-rtl.scss` as language-neutral overrides under `html[dir="rtl"]`.

### Rule 2: Single Source of Truth for Agent Guidance
Keep all project context and operational instructions in `AGENTS.md`. Maintain references in other companion pointer files ([`CLAUDE.md`](CLAUDE.md), [`WARP.md`](WARP.md)) but do not duplicate documentation.

### Rule 3: Roadmap-Driven Implementation
All feature work is planned in [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md). Before starting, consult the implementation brief in the roadmap for target files, schemas, and test criteria.

### Rule 4: Historical Audit Awareness
Before addressing bugs, security findings, or refactoring, consult [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md) for prior fixes. Check the roadmap’s [Status Delete-Zone](FEATURE_ROADMAP.md#status-delete-zone) before recreating removed files or keys.

### Rule 5: Build & Packaging Verification
Never declare a task complete without running the verification suite:
```bash
# 1. Demo build
bundle exec jekyll build --source demo --destination _site
# 2. Test suite, linting, and data validation
bundle exec rake
# 3. Package verification
gem build bilingual-jekyll-resume-theme.gemspec
rm -f bilingual-jekyll-resume-theme-*.gem
```
*Done* means 0 Liquid errors, 0 test failures, 0 RuboCop offenses, and a successful gem build.

### Rule 6: Gated Commit Approval
Stage changes (`git add`), run verification commands, and propose commit messages for the user's review. Execute `git commit` only when explicitly commanded by the user.

### Rule 7: Task Decomposition
Decompose complex, multi-faceted tasks into focused sub-tasks. If your platform supports subagents or multiple models, match the model tier to the task's complexity (e.g., fast models for file scanning, reasoning models for architectural refactoring) to optimize execution speed.

### Rule 8: Clean Workspace & Artifact Hygiene
Always leave the git working directory clean. Remove temporary test outputs, scratch files, and build caches (`.jekyll-cache`) before declaring a task complete or presenting commit proposals. Keep the `demo/` submodule pointer clean unless updating the demo site is an explicit requirement.

## 2. Context Pointers & Master Index

Use the following index to find specific architecture details, schemas, and configurations. Do not guess schemas or layout mechanics; load the relevant file.

| Need / Task | Go To | Role |
|---|---|---|
| **Architecture Map & File Tree** | [`docs/PROJECT_OVERVIEW.md`](docs/PROJECT_OVERVIEW.md) | Map |
| **Site Config & `_config.yml`** | [`docs/CONFIG_GUIDE.md`](docs/CONFIG_GUIDE.md) | Reference |
| **Data Schemas & 12 Resume Sections**: Dynamic YAML rendering | [`docs/DATA_GUIDE.md`](docs/DATA_GUIDE.md) | Reference |
| **Locale Files & RTL Setup** | [`docs/MULTILINGUAL_GUIDE.md`](docs/MULTILINGUAL_GUIDE.md) | Reference |
| **HTML Layouts & Data Flow**: Dynamic data path resolution | [`docs/LAYOUTS_GUIDE.md`](docs/LAYOUTS_GUIDE.md) | Reference |
| **Components & Include Files** | [`docs/INCLUDES_GUIDE.md`](docs/INCLUDES_GUIDE.md) | Reference |
| **SCSS Architecture & Dark Mode** | [`docs/SASS_GUIDE.md`](docs/SASS_GUIDE.md) | Reference |
| **Tests, Suites & Coverage** | [`docs/TESTING_GUIDE.md`](docs/TESTING_GUIDE.md) | Reference |
| **Validator CLI & Build Checks** | [`docs/VALIDATION_GUIDE.md`](docs/VALIDATION_GUIDE.md) | Reference |
| **Accessibility Verification** | [`docs/ACCESSIBILITY_GUIDE.md`](docs/ACCESSIBILITY_GUIDE.md) | Reference |
| **JSON Resume Export** | [`docs/JSON_RESUME_EXPORT.md`](docs/JSON_RESUME_EXPORT.md) | Reference |
| **Active Feature Blueprints** | [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md) | Status |
| **Historical Fixes & Remediations** | [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md) | History |

## 3. Common Developer Commands

```bash
# Initialize demo submodule and install dependencies
git submodule update --init --recursive
bundle install

# Serve the demo with live reload
bundle exec jekyll serve --source demo --destination _site --livereload --incremental

# Run the complete test and validation suite
bundle exec rake

# Multi-language data schema and parity validation
./bin/validate-resume demo/_data --all-locales --fail-on-warnings

# Test the theme in a consuming Jekyll site (local test)
# In consuming site Gemfile: gem "bilingual-jekyll-resume-theme", path: "../bilingual-jekyll-resume-theme"
```

## 4. Troubleshooting & Debugging

- **Section Not Appearing**: Check that the section name is in `site.resume_section_order`, `site.resume_section.<name>` is `true`, and the data items have `active: true`.
- **Page Renders Without Data**: The page's `lang` has no `languages.<lang>` entry, or its `data_path` folder is missing. Run `./bin/validate-resume <data_dir>`.
- **Dates Not Localized**: Check that the `enddate` string matches a value in the locale's `present_values`.
- **Files Missing from Built Gem**: Ensure the files match the `spec.files` filter in `bilingual-jekyll-resume-theme.gemspec`.

## 5. GitHub Issues & Git Workflow

Automatically close issues by referencing them in branches and commits:
- **Branch Naming**: `feature/<feature-name>` (e.g. `feature/color-themes`)
- **Conventional Commit**: `feat(<scope>): <description> (Closes #<issue_id>)`
- **Pull Request Title**: `feat(<scope>): <description> (Closes #<issue_id>)`
