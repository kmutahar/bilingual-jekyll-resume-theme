# Add a social platform

*Audience: theme developers*

Add a new social network icon and label to the theme.

## Steps

1. Place an optimized SVG in `_includes/vendors/svg-icons/newplatform.svg`, and add it to that folder's `ATTRIBUTION.md` if it comes from a licensed icon set.
2. Add an entry to [`_data/social_networks.yml`](../../_data/social_networks.yml), the single list both `social-links.html` and `print-social-links.html` loop over:
   ```yaml
   - key: newplatform
     icon: newplatform
     itemprop: sameAs # or "url" for a non-profile link
     label: New Platform
   ```
   `key` is the name a site uses under `social_links:` in `_config.yml`.
3. Add a `ui.social_labels.newplatform` key to every locale file (the icon's accessible name and the print-only label; the print list has no fallback). Once the entry from step 2 exists, `test/test_packaging.rb` fails until its SVG and all six labels exist.
4. To include the platform in the JSON Resume export, add its `key` to `JsonResumeExporter::NETWORKS` in [`lib/bilingual-jekyll-resume-theme/json_resume_exporter.rb`](../../lib/bilingual-jekyll-resume-theme/json_resume_exporter.rb). That list is hard-coded, so a platform missing from it is never exported.
