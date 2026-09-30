# Enable dark mode

*Audience: site owners and theme developers*

Show the dark mode toggle site-wide or on individual pages. For why the design works this way, see [dark mode approach](../explanation/dark-mode-approach.md); for the `dark_mode` option values, see the [config reference](../reference/config.md).

## Show the toggle on every page

1. In `_config.yml`, set:
   ```yaml
   dark_mode: enabled      # or true
   ```
2. Restart `bundle exec jekyll serve`; changes to `_config.yml` are not picked up while it runs.
3. Open any page. A round button appears fixed in the top-right corner of the window.

The default, `dark_mode: auto`, shows no toggle: the page follows the visitor's system setting. Any value other than `enabled` or `true` also means no toggle.

## Show or hide the toggle on one page

Set `dark_mode` in the page's front matter. It overrides the site setting for that page:

```yaml
---
layout: default
dark_mode: true     # show the toggle on this page; false hides it on this page
---
```

## Add the toggle to a custom layout

The theme's own layouts already include the toggle. In a layout of your own, add `{% include dark-mode-toggle.html %}` inside `<body>`, and make sure `<head>` contains `{% include shared-head.html %}`. That include holds the script that applies a saved choice before the page paints, so visitors do not see a flash of the wrong theme.

## Check that it works

1. Click the button. The page switches to the opposite of your system's current setting: dark if your system is light, light if your system is dark.
2. Reload the page. The choice is kept. The browser stores it in `localStorage` under the key `color-scheme`, with the value `dark` or `light`.
3. Click the button again. The saved choice is cleared and the page follows your system setting again.
4. To clear a saved choice by hand, delete the `color-scheme` entry in your browser's developer tools (the storage or application tab).
5. Print the page, or open the print preview. The toggle is hidden and the page prints black on white.

## Limits

Hiding the toggle does not force a light palette. A visitor whose system prefers dark still gets the dark palette, and a choice saved earlier still applies. The reasons are in [Dark mode approach](../explanation/dark-mode-approach.md).
