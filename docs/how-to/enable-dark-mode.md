# Enable dark mode

*Audience: site owners and theme developers*

Show the dark mode toggle site-wide or on individual pages. For why the design works this way, see [dark mode approach](../explanation/dark-mode-approach.md); for the `dark_mode` option values, see the [config reference](../reference/config.md).

1. Make sure your layout includes the toggle (the theme layouts already do):
   ```liquid
   {% include dark-mode-toggle.html %}
   ```
2. **Site level:** in `_config.yml`, `dark_mode: auto` (default) uses system-preference CSS with no toggle. The shared stored-preference script is still present. Set `dark_mode: enabled` or `true` to render the toggle.
3. **Page level:** set `dark_mode: false` or `true` in a page's front matter to control the toggle for that page. It does not force the page's palette.
4. **Anti-FOUC:** nothing to configure. The inline script in [`shared-head.html`](../../_includes/shared-head.html) applies a stored preference before stylesheets load.
