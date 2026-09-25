# Resume Data Validation Guide

The theme ships two verification engines. `lib/bilingual-jekyll-resume-theme/resume_validator.rb` checks resume YAML data — reached three ways: the `validate-resume` CLI, the `rake validate` task, and a Jekyll generator that runs during every consuming site's build. `lib/bilingual-jekyll-resume-theme/template_key_checker.rb` checks the theme's own `_layouts`/`_includes` Liquid templates for references to data keys that don't exist — reached via the `check-data-keys` CLI and the `rake check_data_keys` task ([section 11](#11-template-key-checker-check-data-keys)); unlike the resume validator, it runs only in this repository's own development workflow and CI, never on a consuming site's build. This guide describes what each checks and how their entry points behave.

---

## Table of Contents

1. [What Gets Checked](#1-what-gets-checked)
2. [How Languages and Locales Are Resolved](#2-how-languages-and-locales-are-resolved)
3. [CLI Validator (`validate-resume`)](#3-cli-validator-validate-resume)
4. [Rake Task (`rake validate`)](#4-rake-task-rake-validate)
5. [Jekyll Build-Time Validation](#5-jekyll-build-time-validation)
6. [Validation Rules Catalog by Section](#6-validation-rules-catalog-by-section)
7. ["Present" Dates](#7-present-dates)
8. [Troubleshooting](#8-troubleshooting)
9. [Continuous Integration](#9-continuous-integration)
10. [Built-HTML Proofing & Static Analysis](#10-built-html-proofing--static-analysis)
11. [Template Key Checker (`check-data-keys`)](#11-template-key-checker-check-data-keys)

---

## 1. What Gets Checked

Findings are **errors** or **warnings**. Errors make the CLI exit 1; warnings do too only with `--fail-on-warnings`.

| Check | Severity |
|---|---|
| YAML syntax in every data, locale, and config file | Error |
| A configured language has no locale file (neither theme nor site) | Error |
| A configured language has no data folder | Error |
| A `languages.<lang>` entry has no `data_path` | Error |
| An explicit `--config` file does not exist | Error |
| Required fields per section, date formats, inverted date ranges, unparseable URLs | Error (see [catalog](#6-validation-rules-catalog-by-section)) |
| A section file exists in one language folder and not another (file parity) | Warning |
| A language's effective locale is missing keys the reference locale has (locale parity) | Warning |
| Missing or non-boolean `active` flag, URLs without `http(s)://`, brief or missing header intro, skill `level` outside 1 to 5 | Warning |

Entries with `active: false` skip schema checks after the `active` flag check.

---

## 2. How Languages and Locales Are Resolved

**Config.** The validator reads the site's Jekyll config to learn which languages exist. It uses the first file found: the `--config` path, then `<data_dir>/_config.yml`, `<data_dir>/_config.sample.yml`, `<data_dir>/../_config.yml`, `<data_dir>/../_config.sample.yml`. The Jekyll plugin passes the already-loaded site config instead.

**Languages.** The set of languages to validate is, in order of precedence:

1. `--languages` on the CLI, if given.
2. Every key under `languages:` in the config. Each language's folder is `<data_dir>/<data_path>`, with dot paths split into folders (`2025-06.v1` resolves to `<data_dir>/2025-06/v1`).
3. With no config, a directory scan of `<data_dir>` for folders named like language codes (`en`, `pt-BR`, `zh_CN`) that contain YAML files. Folders named `locales`, `sample`, `archive`, `assets`, and similar are skipped.

`--all-locales` adds the directory scan on top of 1 or 2.

**Locales.** Each language's effective locale is the theme gem's `_data/locales/<lang>.yml` with the site's `<data_dir>/locales/<lang>.yml` deep-merged over it: nested hashes merge key by key, arrays (`months`, `present_values`) are replaced whole. This mirrors how Jekyll layers theme and site data (see [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md#overriding-theme-locales)). Locale parity is checked on the merged result, so a one-line site override warns on nothing, while a site-only locale for a language the theme does not ship must be complete.

**Reference language.** Parity checks compare every language against one reference: `--primary` (default `en`) if it has a locale, else `default_lang`, else the first language.

---

## 3. CLI Validator (`validate-resume`)

The gem installs `validate-resume` as an executable. In a consuming site run it through Bundler; in this repository run `./bin/validate-resume`.

```bash
bundle exec validate-resume                       # auto-detects the data directory
bundle exec validate-resume _data                 # explicit data directory
bundle exec validate-resume _data -c _config.yml  # explicit config
./bin/validate-resume demo/_data                  # this repository's six-language demo
```

With no `DATA_DIR`, the CLI uses the first of `_data` and `demo/_data` that contains at least one language folder, else `_data`. A positional `DATA_DIR` wins over `-d`.

| Flag | Long flag | Description | Default |
|---|---|---|---|
| `-d DIR` | `--dir DIR` | Data directory | `_data` or `demo/_data` |
| `-c FILE` | `--config FILE` | Jekyll config that declares `languages:` | First config found next to the data directory ([section 2](#2-how-languages-and-locales-are-resolved)) |
| `-l LANGS` | `--languages LANGS` | Comma-separated languages to validate; overrides the config | The config's `languages:` |
| `-a` | `--all-locales` | Also validate every language folder found by directory scan | off |
| `-p LOCALE` | `--primary LOCALE` | Reference language for parity checks | `en` |
| `-w` | `--fail-on-warnings` | Exit 1 on warnings as well as errors | off |
| `-v` | `--verbose` | Verbose output | off |
| `-q` | `--quiet` | Print only when there are findings | off |
| `-h` | `--help` | Show usage | |

Exit codes: `0` when there are no errors (and no warnings under `-w`), `1` otherwise.

---

## 4. Rake Task (`rake validate`)

```bash
bundle exec rake validate               # _data if _data/en exists, else demo/_data
bundle exec rake "validate[path/to/_data]"
```

The task takes no config argument; it finds the config next to the data directory as described in [section 2](#2-how-languages-and-locales-are-resolved). `bundle exec rake` (the default task) runs `validate`, `rubocop`, and `test`.

---

## 5. Jekyll Build-Time Validation

When the gem is loaded as a plugin (declared inside `group :jekyll_plugins` in the site's `Gemfile`), `_plugins/resume_validator.rb` validates the site's `data_dir` on every `jekyll build` and `jekyll serve`. It is **on by default**; findings are logged and the build continues.

```yaml
# _config.yml
validate_resume: false                    # opt out entirely
validate_resume_strict: true              # abort the build when there are errors
validate_resume_fail_on_warnings: true    # with strict: also abort on warnings
```

| Key | Default | Effect |
|---|---|---|
| `validate_resume` | on (unset) | Only the literal value `false` disables validation. |
| `validate_resume_strict` | `false` | `true` raises `Jekyll::Errors::FatalException` when there are errors. |
| `validate_resume_fail_on_warnings` | `false` | With `validate_resume_strict: true`, warnings also abort the build. Has no effect without strict mode. |

If the configured `data_dir` does not exist, the plugin logs a warning and skips validation.

---

## 6. Validation Rules Catalog by Section

The rules are identical for every language. Field aliases in parentheses are accepted in place of the canonical name.

| Section file | Required fields | Checked when present |
|---|---|---|
| `header.yml` | Must be a Hash | `intro` (or `about`): warning if missing or under 20 characters |
| `experience.yml` | `company` (`organization`), `position` (`role`) | `startdate`, `enddate` (date or "present"), date order, each `durations[].duration` non-empty; warning if neither `startdate` nor `durations` |
| `education.yml` | `uni` (`institution`, `school`), `degree` | `startdate`, `enddate` (date or "present"), date order |
| `certifications.yml` | `name` (`title`) | `issue_date`, `expiration`, `expiration >= issue_date`, `credential_url` |
| `courses.yml` | `name` (`title`, `course`) | `startdate`, `enddate`, date order, `credential_url` |
| `volunteering.yml` | `company` (`organization`), `position` (`role`) | `startdate`, `enddate` (date or "present"), date order |
| `projects.yml` | `project` (`title`, `name`) | `url` |
| `skills.yml` | `skill` (`category`, `name`) | `level` is an integer 1 to 5 (warning) |
| `recognitions.yml` | `award` (`title`, `recognition`) | |
| `associations.yml` | `organization` (`company`, `name`) | `url` |
| `languages.yml` | `language` (`name`) | |
| `links.yml` | `description` (`name`, `title`), `url` | `url` |
| `interests.yml` | none; missing `description` (`interest`, `name`) is a warning | No `active` flag check |

Every file except `header.yml` must be a list of Hashes. Every list entry except in `interests.yml` should carry `active: true` or `active: false`.

Dates must be ISO: `YYYY-MM-DD`, `YYYY-MM`, or `YYYY`. Ranges compare at the precision given, with partial end dates extended to the end of their period, so `2024-05-15` to `2024-05` is valid and `2025-01` to `2024-05` is an error.

URLs must parse; a URL that parses but does not start with `http://` or `https://` is a warning.

---

## 7. "Present" Dates

An `enddate` may be a word meaning "ongoing" instead of a date. For a given language the accepted words are that language's effective locale `present_values` plus its `ui.present` label, compared case-insensitively. A language with no locale falls back to the `default_lang` locale. The shipped values:

| Language | `present_values` | `ui.present` |
|---|---|---|
| `en` | `present`, `current` | `Present` |
| `ar` | `present`, `حتى الآن`, `حاليًا` | `حتى الآن` |

Read the other four in [`../_data/locales/`](../_data/locales/). To accept more words, override `present_values` in the site's `_data/locales/<lang>.yml`. Arrays are replaced whole, so list every word you want, including the theme's:

```yaml
# consuming site: _data/locales/es.yml
present_values: ["present", "actualidad", "actualmente", "presente", "hoy"]
```

The template side ([`../_includes/date-formatter.html`](../_includes/date-formatter.html)) matches the same `present_values` list, so what validates also renders as the locale's "Present" label.

---

## 8. Troubleshooting

**`Missing <language> counterpart: _data/ar/xyz.yml (exists in _data/en/)`**
A section file exists in the reference language and not in another (or the reverse). The message names the language by its locale `ui.language_name`. Create the missing file, or delete the extra one.

**`Locale es: Missing key(s) vs. 'en' locale: ...`**
The merged `es` locale lacks keys the reference has. For a shipped language this means a site override replaced a parent hash with a non-hash value; for a site-only language, add the listed keys.

**`No locale found for 'it'` / `Data directory '_data/it' for language 'it' does not exist.`**
A language is declared in `languages:` (or `--languages`) but has no locale file or data folder. Add both, or remove the entry.

**`languages.it has no 'data_path'`**
Every `languages.<lang>` entry needs `data_path`. Use `""` to point at the data root.

**`Date range error: end date (2022-01-31) is before start date (2023-01-01).`**
Swap or correct the dates.

**`url '...' should begin with http:// or https://`**
Add the scheme, for example `https://github.com/user`.

---

## 9. Continuous Integration

This repository runs the validator (and the template key checker, [section 11](#11-template-key-checker-check-data-keys)) in two workflows:

- [`.github/workflows/lint.yml`](../.github/workflows/lint.yml): `./bin/validate-resume demo/_data --fail-on-warnings`, `rake validate[demo/_data]`, `./bin/check-data-keys demo/_data`, `rake check_data_keys[demo/_data]`, a gemspec executable check, and RuboCop.
- [`.github/workflows/ci.yml`](../.github/workflows/ci.yml): gem packaging, a strict Jekyll build, built-HTML proofing, both checkers, and the unit tests across Ruby 3.3, 3.4, and 4.0.

A consuming site can run the same check on every push:

```yaml
# .github/workflows/validate.yml
name: Validate Resume Data
on: [push, pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.4'
          bundler-cache: true
      - run: bundle exec validate-resume _data --fail-on-warnings
```

---

## 10. Built-HTML Proofing & Static Analysis

Two development-only Rake tasks complement the data validator. Their gems are development dependencies and are never installed for theme consumers.

```bash
# Dead internal links, broken #anchors, missing images/favicons, hreflang/canonical targets.
bundle exec jekyll build --source demo --destination _site
bundle exec rake proof                                   # proofs ./_site

# Proof a consuming site (config auto-detected next to its _site/, or passed explicitly):
bundle exec rake "proof[../my-site/_site]"
bundle exec rake "proof[../my-site/_site,../my-site/_config.yml]"

# Ruby static analysis (lib/, _plugins/, bin/validate-resume, test/, Rakefile):
bundle exec rake rubocop
```

- External URLs are not fetched, so results are offline and deterministic.
- Absolute URLs built from `site.url` (hreflang, canonical) are mapped onto local files so they are checked too.
- When `_site/index.html` does not exist, `/`, `/en/cv/`, and `/ar/cv/` are exempted as link targets (the task reads the retired `resume_en_url` / `resume_ar_url` keys for these two paths, so they fall back to the defaults). A real site with a homepage gets no exemption.

---

## 11. Template Key Checker (`check-data-keys`)

`check-data-keys` catches a different class of bug than the resume validator: not bad *data*, but a Liquid template in `_layouts` or `_includes` referencing a field that doesn't exist anywhere in the checked sample data (e.g. `item.discription` instead of `item.description`), which renders silently blank rather than raising an error. It traces `resume_data.<section>` bindings through `for`/`assign`/include-parameter chains — including the `grouped-item-list.html` include boundary and the `group_by` filter's synthetic `{name, items}` wrapper — since the theme's templates never write literal `site.data.foo.bar`.

Because "known keys" are derived from whatever the checked sample data actually contains, a field a template correctly references but that no language in the checked data happens to exercise (an optional field, e.g. `education.yml`'s `awards` list) will warn even though nothing is wrong. For this reason `check-data-keys` **never defaults to `--fail-on-warnings` in this repository's Rake task or CI steps**, unlike `validate-resume`. Warnings are printed and worth reading, but a warning alone does not mean the template is broken — cross-check against the field before "fixing" it.

```bash
./bin/check-data-keys demo/_data                  # this repository's six-language demo (the default target)
./bin/check-data-keys demo/_data --fail-on-warnings  # opt into strict mode yourself, once you trust your data's coverage
bundle exec rake check_data_keys                     # demo/_data by default
bundle exec rake "check_data_keys[path/to/_data]"
```

| Flag | Long flag | Description | Default |
|---|---|---|---|
| `-d DIR` | `--dir DIR` | Data directory | `_data` or `demo/_data` |
| `-c FILE` | `--config FILE` | Jekyll config that declares `languages:` | First config found next to the data directory ([section 2](#2-how-languages-and-locales-are-resolved)) |
| `-w` | `--fail-on-warnings` | Exit 1 on warnings | off |
| `-v` | `--verbose` | Verbose output | off |
| `-q` | `--quiet` | Print only when there are findings | off |
| `-h` | `--help` | Show usage | |

Scans only `_layouts/*.html` and `_includes/**/*.html` — this repository's own shipped templates, never a consuming site's `_pages/` or `_layouts/`/`_includes` overrides. Runs in `bundle exec rake` (the default task) and in both CI workflows ([section 9](#9-continuous-integration)), always without `--fail-on-warnings`.
