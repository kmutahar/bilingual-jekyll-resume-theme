# Create a custom layout

*Audience: theme developers*

Add a new page design (for example `_layouts/academic-cv.html`) that still renders in every language. A new language never needs a new layout; see [Add a language](add-a-language.md).

## Steps

1. Create `_layouts/academic-cv.html` in your site. Start from the skeleton below, or copy the theme's `resume.html` for a full resume variant.
2. Resolve `lang`, `locale`, and `lang_cfg` with the three lines shown under Language Resolution in the [layouts reference](../reference/layouts.md), and read every visible string from `locale.ui` so the layout works in every language.
3. Load data with `{% include data-loader.html path=lang_cfg.data_path %}`.
4. Reuse the shared includes ([`shared-head.html`](../../_includes/shared-head.html), [`avatar.html`](../../_includes/avatar.html), [`dark-mode-toggle.html`](../../_includes/dark-mode-toggle.html), [`resume-section.html`](../../_includes/resume-section.html)).
5. Reference the layout from a page:
   ```yaml
   ---
   layout: academic-cv
   lang: en
   ---
   ```

## A working skeleton

This layout renders the resume sections in any configured language:

```liquid
{%- assign lang = page.lang | default: site.default_lang | default: 'en' -%}
{%- assign locale = site.data.locales[lang] | default: site.data.locales[site.default_lang] -%}
{%- assign lang_cfg = site.languages[lang] -%}
{% include data-loader.html path=lang_cfg.data_path %}
<!DOCTYPE html>
<html lang="{{ lang }}" dir="{{ locale.direction }}">
  <head>
    {% include shared-head.html %}
    <link rel="stylesheet" href="{{ 'assets/css/cv-' | append: locale.direction | append: '.css' | relative_url }}">
    {% seo %}
  </head>
  <body>
    <a href="#main-content" class="skip-link no-print">{{ locale.ui.skip_to_content }}</a>
    {% include dark-mode-toggle.html %}
    {% include language-switcher.html %}
    <main id="main-content" role="main" tabindex="-1">
      <h1>{{ lang_cfg.name }}</h1>
      {%- for section_name in site.resume_section_order -%}
        {% include resume-section.html section_name=section_name lang=lang %}
      {%- endfor -%}
    </main>
  </body>
</html>
```

What each part does:

- The first four lines resolve the language and load that language's data into `resume_data`.
- `dir="{{ locale.direction }}"` and the stylesheet name come from the locale, so one layout serves left-to-right and right-to-left languages: the page links `cv-ltr.css` or `cv-rtl.css`.
- `shared-head.html` adds the charset, viewport, favicons, and the script that applies a saved dark-mode choice before the page paints.
- The loop renders each section listed in `resume_section_order` that is switched on under `resume_section:` in `_config.yml`.

## Check it

1. Create one page per language, for example `academic.md` (`layout: academic-cv`, `lang: en`, `permalink: /academic/`) and `academic-ar.md` (`lang: ar`, `permalink: /ar/academic/`).
2. Build the site with `bundle exec jekyll build`.
3. Open `_site/academic/index.html` and `_site/ar/academic/index.html`. The English page starts with `<html lang="en" dir="ltr">` and links `cv-ltr.css`. The Arabic page starts with `<html lang="ar" dir="rtl">`, links `cv-rtl.css`, and its section headings are in Arabic.

A page that sets no `lang` uses `default_lang`. Keep every visible string in `locale.ui` so nothing in the layout stays in one language.
