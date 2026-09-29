# Accessibility decisions

*Audience: site owners and theme developers*

This page explains the accessibility choices the theme makes, and the limits that come with them. For what is covered and how to check it, see [accessibility coverage](../reference/accessibility-coverage.md) and [verify accessibility](../how-to/verify-accessibility.md).

## What the theme claims, and what it does not

The theme describes its accessibility features and the checks a consuming site needs; it is not a certification of complete WCAG conformance. That is deliberate. Content, custom colors, third-party integrations, and browser behavior all affect the result, and none of them are under the theme's control. A theme can supply sound building blocks, but only the finished site can be judged.

## Structure and keyboard navigation

Headers and footers use semantic HTML, and the resume also supplies explicit banner and contentinfo roles. The profile header sits outside its main content, so its skip link bypasses the name and bio. That is a trade-off of the layout: a keyboard user jumps past the header block, including the name and bio, to reach the content.

`_sass/_base.scss` owns `.sr-only`, the skip-link styles, and the `:focus-visible` outlines, and the skip link becomes visible on focus. The language switcher (`_includes/language-switcher.html`) uses native `<details>`/`<summary>` and a labelled `<nav>`. Enter and Space toggle the disclosure. The cost of choosing the native element is that Escape and outside clicks do not automatically close it, because the theme adds no script to imitate that behavior.

The language switcher is fixed top-left, and the optional theme toggle top-right, in every language, and both are hidden for print. Fixed positioning keeps them in the same place across languages, but small-screen overlap and focus visibility still need browser testing.

## Color contrast

Contrast is a property of a foreground/background pair, not of a token in isolation, so the theme's tokens have to be judged in the pairs they are used in. For example, the muted text token on a white background falls short of the AA contrast ratio for normal-size text; the measured ratios are in [accessibility coverage](../reference/accessibility-coverage.md#color-contrast). The token values are listed in [SASS tokens](../reference/sass-tokens.md).

Hover, focus, disabled, print, and customized colors each need to be checked separately from the default state. Focus outlines do not establish that pointer targets meet target-size requirements. Hiding the theme toggle does not force a light palette: system and stored preferences still apply (see [the dark mode approach](dark-mode-approach.md)).

## Summary

The theme ships `.sr-only` utilities, visible `:focus-visible` outlines, landmarks, and localized skip links. Known limits are the ones above; coverage and verification steps are in the reference and how-to pages linked at the top.
