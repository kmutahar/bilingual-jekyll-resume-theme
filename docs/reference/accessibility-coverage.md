# Accessibility coverage

*Audience: site owners and theme developers*

Reference for the accessibility features the theme implements and what its automated checks cover. The reasoning and limits are in [accessibility decisions](../explanation/accessibility-decisions.md); the verification steps are in [verify accessibility](../how-to/verify-accessibility.md).

## Semantic Structure and Keyboard Navigation

- Resume, default, and profile layouts have a skip link to `<main id="main-content" role="main" tabindex="-1">`. Error pages inherit the default layout.
- `_sass/_base.scss` owns `.sr-only`, skip-link styles, and `:focus-visible` outlines. The skip link becomes visible on focus.
- The focus-ring and `.sr-only` rules are in [WCAG 2.2 Accessibility & High-Contrast Standards](sass-tokens.md#wcag-22-accessibility--high-contrast-standards).
- `_includes/language-switcher.html` uses native `<details>`/`<summary>` and a labelled `<nav>`. Enter/Space toggles the disclosure.

Known limits of the header, switcher and toggle behavior are in [accessibility decisions](../explanation/accessibility-decisions.md#structure-and-keyboard-navigation).

## Labels and Locale Support

- Every social icon link has an accessible name (`aria-label`, `title`, hidden text) in the page's language, from `ui.social_labels`. The profile page's extra email icon is labelled the same way. The avatar uses locale-specific alt text from configuration. These are checked in [`test/test_rendered_site.rb`](../../test/test_rendered_site.rb).
- Direction and UI strings come from six shipped locales; fonts per locale are listed in [locale keys](locale-keys.md), and the `dir="ltr"` isolation of Latin contact details is described in [multilingual and RTL design](../explanation/multilingual-and-rtl-design.md).
- Error pages initially render the default language. Their script can change the error block and Home button based on a leading URL language prefix. The outer page and switcher remain in the server-rendered language; see [layouts.md](layouts.md#4-errorhtml-multilingual-http-error-suite).

## Color Contrast

The following ratios are calculated from the current colors in `_sass/_dark-mode.scss`, rounded to two decimals. They describe these specific pairs, not all rendered states.

| Foreground / background | Approximate ratio | Implication |
|---|---:|---|
| `#333333` / `#ffffff` | 12.63:1 | Main light-mode text has strong contrast. |
| `#e0e0e0` / `#121212` | 14.19:1 | Main dark-mode text has strong contrast. |
| `#999999` / `#ffffff` | 2.85:1 | Current light-mode muted/footer text is below the normal-text AA threshold. |
| `#888888` / `#121212` | 5.28:1 | Current dark-mode muted text clears the normal-text AA threshold. |

Caveats for states not in this table are in [accessibility decisions](../explanation/accessibility-decisions.md#color-contrast).

## Verification

Commands to run the checks and the manual pre-conformance checklist are in [verify accessibility](../how-to/verify-accessibility.md).

The automated checks cover data, selected template/control behavior, Ruby quality, and internal HTML links/assets. They do not perform a full accessibility audit.
