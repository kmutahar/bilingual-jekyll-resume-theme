# Verify accessibility

*Audience: site owners and theme developers*

Run the automated checks, then complete the manual checks before claiming conformance. Coverage details are in the [accessibility coverage reference](../reference/accessibility-coverage.md).

## Run the automated checks

From a clone of the theme repository (these are development tasks, not part of the installed gem):

```bash
git submodule update --init --recursive
bundle exec jekyll build --source demo --destination _site
bundle exec rake
bundle exec rake "proof[_site,demo/_config.yml]"
```

What the automated checks cover and exclude: [accessibility coverage](../reference/accessibility-coverage.md).

## Complete the manual checklist

Before claiming conformance for a deployed site:

1. Check keyboard access, skip-link focus, focus visibility, and disclosure/toggle operation on profile, CV, and error pages.
2. Inspect accessible names and reading order with a screen reader, including the extra profile email link.
3. Test every configured locale, including Arabic and Urdu, in both light and dark modes at narrow widths and increased zoom.
4. Measure contrast in actual rendered states and test print output for clipping and reading order.
5. Run an accessibility scanner and manually review its results; record browser, assistive technology, date, and remaining failures.
