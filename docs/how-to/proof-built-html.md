# Proof the built HTML and lint the Ruby

*Audience: theme developers*

Check a built site for dead links and missing assets, and run Ruby static analysis. To validate resume data instead, see [Validate resume data in CI](validate-in-ci.md).

Two development-only Rake tasks complement the data validator. Their gems are development dependencies and are never installed for theme consumers, so run these commands from a clone of the theme repository. To proof a consuming site, build the site first, then run the task from the theme clone and point it at the site's `_site` folder.

```bash
# Dead internal links, broken #anchors, missing images/favicons, hreflang/canonical targets.
bundle exec jekyll build --source demo --destination _site
bundle exec rake proof                                   # proofs ./_site

# Proof a consuming site (config auto-detected next to its _site/, or passed explicitly):
bundle exec rake "proof[../my-site/_site]"
bundle exec rake "proof[../my-site/_site,../my-site/_config.yml]"

# Ruby static analysis (lib/, _plugins/, bin/validate-resume, bin/check-data-keys, test/, Rakefile):
bundle exec rake rubocop
```

What the proofer checks and its exemptions are described in [Testing suites](../reference/testing-suites.md#built-html-proofing-semantics).
