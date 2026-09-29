# The data-driven model

*Audience: site owners and theme developers*

This page explains why resume content lives in per-language YAML data, how the theme finds and reads it, and the limits of the JSON export. For schemas see [data schemas](../reference/data-schemas.md), and for the lookup mechanics see [layouts](../reference/layouts.md).

## Content as data, one folder per language

Resume content lives in YAML files, one folder per language. Keeping one folder per language (`_data/en/`, `_data/ar/`, `_data/es/`, and so on), each holding the same file names, means every language renders through the same layout and only the data differs. Complete starter data for six languages (a Sherlock Holmes demo persona) is in [`demo/_data/`](../../demo/_data/): `en`, `ar`, `es`, `fr`, `de`, `ur`.

Each language's folder is set by `languages.<lang>.data_path` in `_config.yml`. Dot paths such as `"2025-06.v1"` select nested, versioned datasets, so several versions of a resume can live side by side and a language can point at whichever one it needs. See [config](../reference/config.md) for the setting.

## Why lookups are written the way they are

Sections render in the order of `site.resume_section_order` through one dispatcher, [`_includes/resume-section.html`](../../_includes/resume-section.html), plus the `header.yml` intro. Order is therefore configuration, not template code; the list of sections is in [data schemas](../reference/data-schemas.md).

Two Liquid details shape how data is read. Presence checks use `field.size > 0` for text or a plain truthiness test for dates, never `!= blank`; the reason is in [Liquid pitfalls](architecture.md#liquid-pitfalls).

Bracket access (`resume_data[part]`) is what makes folder names like `2025-06` or `20250621-PM` work; Liquid dot notation (`site.data.2025-06`) fails on leading digits and hyphens. Using brackets is what allows dated, versioned folder names.

## Privacy and the limits of the JSON export

The JSON export is built from the same data, but it is a supported subset of the CV, not a lossless representation of every website field. Documented optional enrichment fields can appear in JSON even if HTML does not display those fields.

`json_resume.privacy.export_contact_info: false` omits the structured contact fields; the exact list is in [Visibility and privacy](../reference/json-resume-fields.md#visibility-and-privacy). The setting has limits: it does not redact free-form narrative text, usernames, or arbitrary URLs, and it does not change the HTML site's contact visibility. Treat it as a switch for the structured contact fields, not as a general privacy filter. Field details are in [JSON Resume fields](../reference/json-resume-fields.md).
