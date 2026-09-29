# Publish the JSON Resume export

*Audience: site owners*

Serve the localized JSON Resume documents the theme generates, and make sure hosts and CV pages expose them correctly. Field mappings are in the [JSON Resume fields reference](../reference/json-resume-fields.md).

The routes the theme generates (`/<lang>/resume.json` for every language, plus `/resume.json` from the default language) are described in the [JSON Resume export reference](../reference/json-resume-fields.md).

## 1. Check the discovery links on CV pages

Build the site and open `/en/resume.json` (for example `http://localhost:4000/en/resume.json` while serving locally). Which contact details appear depends on what the CV shows: see [Visibility and privacy](../reference/json-resume-fields.md#visibility-and-privacy).

CV pages advertise only successfully generated localized exports:

```html
<link rel="alternate" type="application/json" href="/en/resume.json" hreflang="en">
```

The exporter records successful routes for the shared head include. Profile and error pages do not advertise exports.

## 2. Serve the files as JSON

Jekyll emits `.json` files; the web host must serve them with `Content-Type: application/json`. This plugin cannot set HTTP headers on a static host.

## 3. Optionally enrich skills

Add `level_label` and `keywords` to a `skills.yml` entry:

```yaml
# A skills.yml entry; translate content in each language's data folder.
- skill: Web development
  active: true
  level: 4
  level_label: Advanced
  keywords:
    - Ruby
    - Jekyll
```
