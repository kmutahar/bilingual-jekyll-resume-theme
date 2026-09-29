# Accessibility Guide

This guide describes the theme's accessibility features and the checks needed for a consuming site. It is not a certification of complete WCAG conformance. Content, custom colors, third-party integrations, and browser behavior affect the result.

## Semantic Structure and Keyboard Navigation

- Resume, default, and profile layouts have a skip link to `<main id="main-content" role="main" tabindex="-1">`. Error pages inherit the default layout.
- Headers and footers use semantic HTML; the resume also supplies explicit banner/contentinfo roles. The profile header sits outside its main content, so its skip link bypasses the name and bio.
- `_sass/_base.scss` owns `.sr-only`, skip-link styles, and `:focus-visible` outlines. The skip link becomes visible on focus.
- `_includes/language-switcher.html` uses native `<details>`/`<summary>` and a labelled `<nav>`. Enter/Space toggles the disclosure. Escape and outside clicks do not automatically close it.
- The language switcher is fixed top-left, and the optional theme toggle top-right, in every language. Both are hidden for print. Small-screen overlap and focus visibility still need browser testing.

## Labels and Locale Support

- Every social icon link has an accessible name (`aria-label`, `title`, hidden text) in the page's language, from `ui.social_labels`. The profile page's extra email icon is labelled the same way. The avatar uses locale-specific alt text from configuration. These are checked in [`../test/test_rendered_site.rb`](../test/test_rendered_site.rb).
- Direction and UI strings come from six shipped locales. Arabic uses Cairo; Urdu uses Noto Nastaliq Urdu. The resume templates isolate Latin contact details and URLs with `dir="ltr"`.
- Error pages initially render the default language. Their script can change the error block and Home button based on a leading URL language prefix. The outer page and switcher remain in the server-rendered language; see [LAYOUTS_GUIDE.md](LAYOUTS_GUIDE.md#4-errorhtml-multilingual-http-error-suite).

## Color Contrast

The following ratios are calculated from the current colors in `_sass/_dark-mode.scss`, rounded to two decimals. They describe these specific pairs, not all rendered states.

| Foreground / background | Approximate ratio | Implication |
|---|---:|---|
| `#333333` / `#ffffff` | 12.63:1 | Main light-mode text has strong contrast. |
| `#e0e0e0` / `#121212` | 14.19:1 | Main dark-mode text has strong contrast. |
| `#999999` / `#ffffff` | 2.85:1 | Current light-mode muted/footer text is below the normal-text AA threshold. |
| `#888888` / `#121212` | 5.28:1 | Current dark-mode muted text clears the normal-text AA threshold. |

Check hover, focus, disabled, print, and customized colors separately. Focus outlines do not establish that pointer targets meet target-size requirements. Hiding the theme toggle does not force a light palette; system and stored preferences still apply.

## Verification

From the theme repository:

```bash
git submodule update --init --recursive
bundle exec jekyll build --source demo --destination _site
bundle exec rake
bundle exec rake "proof[_site,demo/_config.yml]"
```

The automated checks cover data, selected template/control behavior, Ruby quality, and internal HTML links/assets. They do not perform a full accessibility audit.

Before claiming conformance for a deployed site:

1. Check keyboard access, skip-link focus, focus visibility, and disclosure/toggle operation on profile, CV, and error pages.
2. Inspect accessible names and reading order with a screen reader, including the extra profile email link.
3. Test every configured locale, including Arabic and Urdu, in both light and dark modes at narrow widths and increased zoom.
4. Measure contrast in actual rendered states and test print output for clipping and reading order.
5. Run an accessibility scanner and manually review its results; record browser, assistive technology, date, and remaining failures.
