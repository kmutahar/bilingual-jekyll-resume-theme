# Validate resume data in CI

*Audience: site owners and theme developers*

Gate builds on resume data validation and run the checks in GitHub Actions. To proof the built HTML instead, see [Proof the built HTML](proof-built-html.md). Options are listed in the [validator CLI reference](../reference/validator-cli.md).

## Configure build-time validation

How build-time validation behaves is described in [Jekyll Build-Time Validation](../reference/validator-cli.md#5-jekyll-build-time-validation). To opt out or gate the build on findings, set these options in `_config.yml`:

```yaml
# _config.yml
validate_resume: false                    # opt out entirely
validate_resume_strict: true              # abort the build when there are errors
validate_resume_fail_on_warnings: true    # with strict: also abort on warnings
```

## Run the validator in GitHub Actions

How this repository's own workflows run the validator and the template key checker: [Continuous integration](../reference/testing-suites.md#continuous-integration).

A consuming site can run the same check on every push:

```yaml
# .github/workflows/validate.yml
name: Validate Resume Data
on: [push, pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.4'
          bundler-cache: true
      - run: bundle exec validate-resume _data --fail-on-warnings
```
