# Troubleshoot builds

*Audience: site owners and theme developers*

Find the symptom you see, then work through its checks.

## A section is not rendering on my resume

1. `resume_section.<name>: true` is set.
2. The name is listed in `resume_section_order`.
3. The language's data folder (`_data/<data_path>/`) contains `<name>.yml` and its items have `active: true`.
4. For recognitions, use the plural key `recognitions`.
5. For the languages section, `lang_header` must not be `true`.

## `Missing <language> counterpart: _data/ar/xyz.yml (exists in _data/en/)`

A section file exists in the reference language and not in another (or the reverse). The message names the language by its locale `ui.language_name`. Create the missing file, or delete the extra one.

## `Locale es: Missing key(s) vs. 'en' locale: ...`

The merged `es` locale lacks keys the reference has. For a shipped language this means a site override replaced a parent hash with a non-hash value; for a site-only language, add the listed keys.

## `No locale found for 'it'` / `Data directory '_data/it' for language 'it' does not exist.`

A language is declared in `languages:` (or `--languages`) but has no locale file or data folder. Add both, or remove the entry.

## `languages.it has no 'data_path'`

Every `languages.<lang>` entry needs `data_path`. Use `""` to point at the data root.

## `Date range error: end date (2022-01-31) is before start date (2023-01-01).`

Swap or correct the dates.

## `url '...' must begin with http:// or https://`

An error, not a warning. Add the scheme, for example `https://github.com/user`.

See the [validator CLI reference](../reference/validator-cli.md) for all checks and options.
