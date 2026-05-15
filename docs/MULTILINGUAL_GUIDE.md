# Multilingual Guide
This guide explains how to use the language-agnostic architecture with `resume-multi` so you can support any language, including multiple RTL languages.

## 1) Register languages in `_config.yml`
Use `languages` as the source of truth:

```yaml
languages:
  en:
    dir: ltr
    data_path: en
  ar:
    dir: rtl
    data_path: ar
  es:
    dir: ltr
    data_path: es
```

- `dir` controls document direction (`ltr` / `rtl`)
- `data_path` points to the resume data subtree under `_data/`
- If `data_path` is omitted, the layout falls back to the language key

## 2) Create translation dictionaries
Add one file per language under `_data/languages/`:

- `_data/languages/en.yml`
- `_data/languages/ar.yml`
- `_data/languages/es.yml`

Each dictionary should include:

- `ui` labels (section titles, button labels, footer text, etc.)
- `present_values` aliases for detecting current-role values
- `months` array for localized month names

Example:

```yaml
ui:
  present: "Present"
  contact_me: "Contact me"
  section_titles:
    experience: "Experience"
    education: "Education"
present_values:
  - "present"
  - "current"
months:
  - "January"
  - "February"
  - "March"
```

## 3) Structure language data folders
Store section content in language-specific data folders matching each `data_path`, for example:

- `_data/en/experience.yml`
- `_data/ar/experience.yml`
- `_data/es/experience.yml`

## 4) Use `resume-multi` in page front matter
Create language pages with one layout and one `lang` value:

```yaml
---
layout: resume-multi
permalink: /resume/es/
lang: es
t_id: resume
---
```

`resume-multi` resolves the HTML `lang`, `dir`, translation dictionary, and resume data path dynamically.
