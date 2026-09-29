# Glossary

*Audience: site owners and theme developers*

Definitions of terms used across the documentation, each linking to the page that owns the full detail.

**active flag**: The boolean `active:` key on list items. `active: true` renders the item, `active: false` keeps it in the YAML but omits it from the HTML; interests are the exception and have no flag. See [data schemas](data-schemas.md).

**canonical key vs alias**: The canonical key is the field name the templates actually render (for example `company`); an alias is another name the templates never read (for example `organization`). An entry that sets only an alias fails validation, and the error names the alias found. See [validator CLI](validator-cli.md).

**data-loader**: The include [`data-loader.html`](../../_includes/data-loader.html), which binds `resume_data` by walking `site.data` along a dot-separated data path. See [includes](includes.md).

**data path**: The value of `languages.<lang>.data_path`, a dot-separated path to the folder under `_data/` holding that language's resume YAML files (for example `en` for `_data/en/`). See [config](config.md).

**default language**: The `default_lang` setting (default `en`): the language used when a page has no `lang`, for the hreflang `x-default` link, and for error page button labels. See [config](config.md).

**effective locale**: The locale a language actually uses after merging: the theme's `_data/locales/<lang>.yml` with the site's own `_data/locales/<lang>.yml` deep-merged over it. See [locale keys](locale-keys.md#overriding-theme-locales).

**FOUC**: Flash of unstyled or wrong-theme content, the brief moment a page paints in the wrong color scheme before the stored preference is applied. An inline script in `shared-head.html` prevents it. See [dark mode approach](../explanation/dark-mode-approach.md#avoiding-a-flash-of-the-wrong-theme).

**locale**: The per-language file `_data/locales/<lang>.yml` holding text direction, font, UI strings, month names, "present" words, and error page copy. See [locale keys](locale-keys.md).

**parity**: The requirement that every language has the same key set in its locale and the same section files in its data folder; the validator compares each language against the reference language. See [validator CLI](validator-cli.md).

**pinned**: Explicitly set to a color scheme, as opposed to following the system preference: `data-color-scheme` or `data-theme` on `:root` overrides the automatic dark mode. See [dark mode approach](../explanation/dark-mode-approach.md).

**"Present" value**: A word in an `enddate` field that means "ongoing" and renders as the locale's `ui.present` label instead of a date. See [locale keys](locale-keys.md#present-values).

**profile page**: The standalone landing page rendered with `layout: profile`. See [layouts](layouts.md).

**reference (primary) language**: The language every other language is compared against for parity checks: `--primary` (default `en`) if it has a locale, else `default_lang`, else the first language. See [validator CLI](validator-cli.md).

**resume page (CV)**: A page rendered with `layout: resume` plus `lang: <code>`; one layout serves every language. See [layouts](layouts.md).

**section**: One resume block (such as experience or education), rendered by `resume-section.html` in the order of `resume_section_order` when its `resume_section.<name>` flag is truthy. See [config](config.md) and [includes](includes.md).

**strict mode**: `validate_resume_strict: true`: build-time validation raises a fatal error when there are validation errors (and, with `validate_resume_fail_on_warnings: true`, on warnings too). See [validator and build checks](validator-cli.md#5-jekyll-build-time-validation).

**`t_id`**: A front-matter key shared by translations of the same page; it drives hreflang alternates and lets the language switcher find the exact counterpart page. Generated pages use `t_id: resume` or `t_id: profile`. See [includes](includes.md).
