# Create a custom layout

*Audience: theme developers*

Add a new page design (for example `_layouts/academic-cv.html`) that still renders in every language. A new language never needs a new layout; see [Add a language](add-a-language.md).

1. Start from `default.html`, or copy `resume.html` for a resume variant.
2. Resolve `lang`, `locale`, and `lang_cfg` with the three lines shown under Language Resolution in the [layouts reference](../reference/layouts.md), and read every visible string from `locale.ui` so the layout works in every language.
3. Load data with `{% include data-loader.html path=lang_cfg.data_path %}`.
4. Reuse the shared includes ([`shared-head.html`](../../_includes/shared-head.html), [`avatar.html`](../../_includes/avatar.html), [`dark-mode-toggle.html`](../../_includes/dark-mode-toggle.html), [`resume-section.html`](../../_includes/resume-section.html)).
5. Reference it from a page:
   ```yaml
   ---
   layout: academic-cv
   lang: en
   ---
   ```
