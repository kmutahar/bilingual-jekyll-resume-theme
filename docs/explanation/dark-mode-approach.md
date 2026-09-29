# Dark mode approach

*Audience: site owners and theme developers*

This page explains why dark mode is built the way it is: every color is a token, activation has two tiers, and a small inline script prevents a flash. For the token values see [SASS tokens](../reference/sass-tokens.md); to turn the toggle on, see [enable dark mode](../how-to/enable-dark-mode.md).

## One place for every color

[`_sass/_dark-mode.scss`](../../_sass/_dark-mode.scss) holds every color token on `:root`. Keeping the palette in tokens means a dark palette is a matter of redefining variables rather than restyling components.

## Two tiers of activation

Activation has two tiers. The first is automatic: the stylesheet uses `prefers-color-scheme: dark`, applied to `:root` unless it is explicitly pinned to light through `data-color-scheme="light"` or `data-theme="light"`. So `dark_mode: auto` adapts to the visitor's system with no JavaScript. The second is an explicit pin: `:root[data-color-scheme="dark"]` or `:root[data-theme="dark"]` sets the dark palette regardless of the system. `dark_mode: enabled` adds a toggle that uses `localStorage` to persist the visitor's choice. The `:not(...)` guard on the first tier is what lets an explicit light pin win over a dark system preference. The first tier is a no-JavaScript baseline that respects the operating system; the second exists so a visitor can override it.

## Avoiding a flash of the wrong theme

A stored preference lives in `localStorage`, which only script can read, and stylesheets would otherwise paint first. To prevent theme flashing (FOUC), an inline `<head>` script in [`_includes/shared-head.html`](../../_includes/shared-head.html) applies the stored preference before stylesheets load.

## What the settings do not do

Page front matter `dark_mode: false` or `true` controls the toggle on one page. These settings do not disable the system-preference CSS or the stored-preference script; `false` hides the button rather than forcing a light palette. Hiding the control and removing the behavior are different things: a visitor whose system is dark, or who stored a preference earlier, still gets that palette. See [config](../reference/config.md) for the setting itself.

## Print

Dark mode does not apply to print or PDF. `@media print` in `_sass/_dark-mode.scss` forces black text on white, and the toggle carries `.no-print`, so the control does not appear on paper either.
