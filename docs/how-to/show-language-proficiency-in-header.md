# Show language proficiency in the header

*Audience: site owners*

Show a one-line summary of the languages you speak in the resume header, instead of a full Languages section.

1. In `_config.yml`, set `resume_section.lang_header: true` and `display_header_contact_info: true`. The line sits inside the header contact block, so it does not appear without the second setting.
2. In each language's `languages.yml`, give every language you want shown `active: true` and a `descrp_short` value (for example `descrp_short: "Native"`).
3. Rebuild. The header shows `Language (descrp_short)` entries joined by the locale's list separator, and the standalone Languages section is hidden.

To show a full Languages section instead, set `resume_section.lang_header: false` and `resume_section.languages: true`.

The fields of `languages.yml` are in the [data schemas reference](../reference/data-schemas.md).
