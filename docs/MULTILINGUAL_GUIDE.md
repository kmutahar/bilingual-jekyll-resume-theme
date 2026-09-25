# Multilingual Guide

Since v1.0.0 the theme renders every language through one layout, `_layouts/resume.html`. A language is three things:

1. A **locale file**, `_data/locales/<lang>.yml`: text direction, font, line height, UI strings, month names, "present" words, and error page copy.
2. A **data folder**, `_data/<data_path>/`: the resume content (`experience.yml`, `education.yml`, and so on). Schemas are in [`DATA_GUIDE.md`](DATA_GUIDE.md).
3. A **config entry**, `languages.<lang>` in `_config.yml`: data path, URL, name, title, address, avatar alt text, and the header intro toggle.

The theme ships six locales: English (`en`, LTR), Arabic (`ar`, RTL), Spanish (`es`, LTR), French (`fr`, LTR), German (`de`, LTR), and Urdu (`ur`, RTL). Any other language is added by the site alone, with no Ruby, HTML, or SCSS changes.

---

## Table of Contents

- [Resume Pages](#resume-pages)
- [Adding a Language](#adding-a-language)
- [Locale File Reference](#locale-file-reference)
- [Overriding Theme Locales](#overriding-theme-locales)
- [Typography & RTL](#typography--rtl)
- [Writing Content](#writing-content)
- [Breaking Changes & Migration (v0.9.0 to v1.0.0)](#breaking-changes--migration-v090-to-v100)

---

## Resume Pages

Each language needs one page that uses `layout: resume` and sets `lang`:

```markdown
---
layout: resume
lang: es
permalink: /es/cv/
t_id: resume        # optional: links translations for hreflang and the language switcher
---
```

The layout resolves the active language from `page.lang`, falling back to `site.default_lang`, then `en`. It reads `site.data.locales[lang]` for direction and UI copy and `site.languages[lang]` for the per-language config. The repository's own demo pages are in [`demo/`](demo/).

---

## Adding a Language

This walkthrough adds Italian (`it`). The theme has no `it.yml`, so the site supplies a complete locale file.

1. **Create the locale file.** Copy the theme's [`../_data/locales/en.yml`](../_data/locales/en.yml) to your site as `_data/locales/it.yml`, keep every key, and translate the values. Set `direction`, `font_family`, `font_url`, and `line_height` for the script (see [Typography & RTL](#typography--rtl)). Replace `months` with the 12 Italian month names and `present_values` with the words your data uses for ongoing roles (for example `["present", "presente", "attuale"]`).
2. **Create the data folder.** Copy an existing language folder (for example `_data/en/`) to `_data/it/` and translate every file. Keep the same file names and the same entries in the same order; the validator reports files that exist in one language and not the other.
3. **Register the language** in `_config.yml`:
   ```yaml
   languages:
     it:
       data_path: it             # folder under _data/; dot paths like "2025-06.it" also work
       url: /it/cv/              # used by error pages, hreflang, and the language switcher
       header_intro: true        # render _data/it/header.yml intro under the header
       name: "Nome Cognome"
       resume_title: "Titolo professionale"
       address: "Città, Paese"
       avatar_alt: "Foto di Nome Cognome"
   ```
4. **Create the page** `it/cv.md` (or any path) with `layout: resume`, `lang: it`, and a `permalink` matching `languages.it.url`.
5. **Validate and build:**
   ```bash
   bundle exec validate-resume _data
   bundle exec jekyll build
   ```
   Done when the validator reports no errors for `it` and `_site/it/cv/index.html` renders with Italian section titles and month names.

The error pages and the language switcher pick up the new language automatically because they loop over `site.languages`. hreflang tags pick it up when the new page shares a `t_id` with its translations.

---

## Locale File Reference

Every locale file has the same key set. The validator warns when a language's effective locale is missing a key that the reference locale (`en` by default) has.

| Key | Purpose |
|---|---|
| `direction` | `ltr` or `rtl`. Sets `<html dir>` and selects `assets/css/cv-ltr.css` or `cv-rtl.css`. |
| `font_family` | CSS font stack emitted as `--font-locale`. Empty string keeps the theme's default stacks (Lora and Open Sans). |
| `font_url` | Stylesheet URL for the font (usually Google Fonts). Empty string loads the default Lora and Open Sans stylesheet. |
| `line_height` | Emitted as `--line-height-locale` for resume body text. |
| `ui.*` | Every UI string the templates render: skip link, "Present", contact button, dark mode toggle label, language switcher label, `language_name` (the language's own name, shown in the switcher and on error page return links), `list_separator`, and more. |
| `ui.section_titles.*` | One heading per resume section (`experience`, `education`, ... `links`). |
| `ui.social_labels.*` | Labels for the print-only contact list. |
| `error_pages."404"` / `"403"` / `"500"` / `"503"` | `title` and `message` for each HTTP error page. |
| `error_pages.return_link` | Text of the "return to resume" link on error pages. |
| `present_values` | Case-insensitive words that mean "ongoing" in `enddate` fields. A match renders `ui.present` instead of a date. |
| `months` | The 12 month names, January first. Dates render as `<month> <year>`. |

Read the shipped files in [`../_data/locales/`](../_data/locales/) for the full key list and current values.

---

## Overriding Theme Locales

The six locale files ship inside the theme gem, so consuming sites get them with no setup. Jekyll reads theme data first and then deep-merges the site's `_data/` over it; the site wins.

- **Change a few strings:** create `_data/locales/<lang>.yml` in your site containing only the keys to change. Nested keys merge one by one, so this file changes one heading and leaves every other Spanish string intact:
  ```yaml
  # consuming site: _data/locales/es.yml
  ui:
    section_titles:
      experience: "Trayectoria"
  ```
- **Replace a whole locale:** copy the theme file into your site's `_data/locales/` and edit it. No fork or gem release is needed.
- **Arrays are replaced whole, never merged.** Overriding `months` or `present_values` requires the complete list; a one-item `months` array leaves the other eleven months blank.
- **Add a new language:** create a complete `_data/locales/<lang>.yml`. There is no theme file to merge with, so every key must be present.

The validator builds each locale the same way (theme file, then site file deep-merged over it) and checks key parity on the merged result. A one-line override produces no warnings; an incomplete site-only locale does.

---

## Typography & RTL

- **Fonts and line height come only from the locale file.** `_layouts/resume.html` loads `font_url` and emits `--font-locale` and `--line-height-locale` in an inline `:root` style. `_sass/_resume-ltr.scss` reads those variables with the theme's default stacks as fallbacks. Shipped values: Arabic uses Cairo at `1.6` (room for diacritics); Urdu uses Noto Nastaliq Urdu at `2.0` (Nastaliq glyphs are tall); the LTR locales use the default stacks at `1.5`.
- **`disable_google_fonts: true`** (or `resume_theme: no-custom-fonts`) stops the layout from loading any `font_url`. Supply the font yourself, or set `font_family` to a system font in a site locale override.
- **RTL is language-neutral.** Every RTL locale compiles through `assets/css/cv-rtl.scss`, which loads `_sass/_resume-ltr.scss` and then `_sass/_resume-rtl.scss`. The RTL partial only mirrors positioning (floats, margins, timeline bullets, contact icons) under `html[dir="rtl"]` and resets `letter-spacing` so cursive scripts keep their ligatures. It sets no fonts, so Arabic, Urdu, and any future RTL language each keep their own typeface.
- **Bidi isolation.** In RTL locales, templates wrap phone numbers, email addresses, URLs, and credential IDs in `dir="ltr"` so Latin punctuation is not reordered.

---

## Writing Content

- Translate every data file natively; copying English into another language's folder produces a resume that looks localized in the headings and English in the body.
- Keep proper nouns consistent: transliterate them in non-Latin scripts and keep them as-is in Latin-script languages.
- Write dates as ISO (`YYYY-MM-DD`, `YYYY-MM`, or `YYYY`). Month names come from the locale file, so the data stays language-neutral.
- For ongoing roles, leave `enddate` blank or use any value from that locale's `present_values`.
- The Sherlock Holmes demo in [`demo/_data/`](../demo/_data/) (`en`, `ar`, `es`, `fr`, `de`, `ur`) is a complete, parity-clean reference. Build it from the repository root with:
  ```bash
  bundle exec jekyll build --source demo --destination _site
  ```

---

## Breaking Changes & Migration (v0.9.0 to v1.0.0)

v1.0.0 is a hard break: no aliases, shims, or fallback keys remain for the names below. Replace each one in your site.

| Removed (v0.9.0) | Replacement (v1.0.0) |
|---|---|
| `layout: resume-en` / `layout: resume-ar` | `layout: resume` + `lang: <code>` |
| `_includes/resume-section-en.html` / `-ar.html` | `_includes/resume-section.html` |
| `_includes/resume-head-en.html` / `-ar.html` | Head logic inside `_layouts/resume.html` |
| `_includes/ar-date.html` | `_includes/date-formatter.html` |
| `_data/ar/months.yml` | `months:` in `_data/locales/ar.yml` |
| `_data/error_pages.yml` | `error_pages:` in each `_data/locales/<lang>.yml` |
| `assets/css/cv.css` / `cv-ar.css` | `assets/css/cv-ltr.css` / `cv-rtl.css` |
| `active_resume_path_en` / `_ar` | `languages.<lang>.data_path` |
| `resume_en_url` / `resume_ar_url` | `languages.<lang>.url` |
| `resume_header_intro_en` / `_ar` | `languages.<lang>.header_intro` |
| `name` / `name_ar` | `languages.<lang>.name` |
| `resume_title` / `resume_title_ar` | `languages.<lang>.resume_title` |
| `contact_info.address` / `address_ar` | `languages.<lang>.address` |
| `avatar_alt_en` / `avatar_alt_ar` / `avatar_alt` | `languages.<lang>.avatar_alt` |
| `site.avatar` | `site.avatar_url` |
| `analytics.ga` | `analytics.gtag` or `analytics.gtm` |
| `resume_section.recognition` (singular) | `resume_section.recognitions` |
| `required_ruby_version >= 3.0.0` | `>= 3.3.0` |
| `gem "bilingual-jekyll-resume-theme"` (plain Gemfile line) | Same line inside `group :jekyll_plugins do ... end`; required for the error page generator and build-time validation to load |

Also note:

- `languages.<lang>.name` is a plain string (`"Jane Doe"`), not the old `first` / `middle` / `last` hash.
- The site-level `lang` and `dir` keys no longer affect any layout; direction comes from the locale file and language from `page.lang` or `default_lang`.
- `font_ar_url` is gone. Override `font_url` in your site's `_data/locales/ar.yml` instead.
- Error page front matter overrides (`title_en`, `desc_en`, `title_ar`, `desc_ar`) are gone. Override `error_pages` in a site locale file instead.
- Build-time validation is now on by default. Set `validate_resume: false` to opt out (see [`VALIDATION_GUIDE.md`](VALIDATION_GUIDE.md)).

After migrating, run `bundle exec validate-resume _data` and `bundle exec jekyll build`. Watch for two silent failures: a leftover `layout: resume-en` page only logs a Jekyll "layout does not exist" warning and renders unstyled, and a page whose `lang` has no `languages:` entry renders without a name, title, or resume data.
