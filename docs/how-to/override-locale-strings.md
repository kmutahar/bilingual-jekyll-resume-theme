# Override locale strings

*Audience: site owners*

Change UI text, fonts, error-page copy, or accepted "present" words for a language from your consuming site, without forking the theme. The six locale files ship inside the theme gem. Jekyll reads theme data first and then deep-merges the site's `_data/` over it; the site wins. For design background, see [multilingual and RTL design](../explanation/multilingual-and-rtl-design.md).

## Change a few strings

1. Create `_data/locales/<lang>.yml` in your site containing only the keys to change. Nested keys merge one by one, so this file changes one heading and leaves every other Spanish string intact:
   ```yaml
   # consuming site: _data/locales/es.yml
   ui:
     section_titles:
       experience: "Trayectoria"
   ```

## Replace a whole locale

1. Copy the theme file into your site's `_data/locales/` and edit it. No fork or gem release is needed.

## Add a new language

1. Create a complete `_data/locales/<lang>.yml`. There is no theme file to merge with, so every key must be present.

The validator checks the merged result: see [Overriding theme locales](../reference/locale-keys.md#overriding-theme-locales).

Arrays are replaced whole, never merged. Overriding `months` or `present_values` requires the complete list; a one-item `months` array leaves the other eleven months blank.

## Change a language's font

Fonts are locale data, not config, so no SCSS edit is needed for the CV pages. The profile page uses its own font stack, set in `_sass/_profile-page.scss`; see [Override Sass partials](override-sass-partials.md).

1. Override `font_family` and `font_url` in your site's `_data/locales/<lang>.yml`:
   ```yaml
   # consuming site: _data/locales/ar.yml
   font_family: "'Tajawal', sans-serif"
   font_url: "https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700&display=swap"
   ```

## Change error-page copy

1. Override `error_pages` in your site's `_data/locales/<lang>.yml`. The structure is in the [data schemas reference](../reference/data-schemas.md).

## Accept more "present" words

1. Override `present_values` in the site's `_data/locales/<lang>.yml`. Arrays are replaced whole, so list every word you want, including the theme's:
   ```yaml
   # consuming site: _data/locales/es.yml
   present_values: ["present", "actualidad", "actualmente", "presente", "hoy"]
   ```
2. If you change `ui.present`, also keep that label in `present_values`; see [Present values](../reference/locale-keys.md#present-values) for why.
