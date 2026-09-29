# Testing Guide

How the theme is tested, what each suite proves, and how to add a test. Validator rules themselves are in [VALIDATION_GUIDE.md](VALIDATION_GUIDE.md); agent verification rules are in [AGENTS.md](../AGENTS.md#rule-5-build--packaging-verification).

## Run the tests

```bash
git submodule update --init --recursive      # demo/ data is used by several suites
bundle exec rake                             # validate + check_data_keys + rubocop + every test/test_*.rb
bundle exec rake test                        # tests only
bundle exec ruby test/test_rendered_site.rb  # one suite
bundle exec ruby test/test_rendered_site.rb -n /date/   # tests whose name matches
```

The `test` task runs every `test/test_*.rb` file, so a new suite needs no Rakefile edit. Two error-page tests run the page's real JavaScript in Node and are skipped when `node` is not installed.

## What each suite covers

Every test goes through a public interface: the HTML a visitor receives, a Ruby class's public methods, a CLI's exit code and output, or the gem's file list. No test calls a private method.

| Suite | Interface under test | Covers |
|---|---|---|
| [`test_rendered_site.rb`](../test/test_rendered_site.rb) | Generated HTML of a fixture site built from the theme's real `_layouts`, `_includes`, `_sass`, `_data`, `assets` | Each of the 12 sections (fields, separators, inactive entries, grouping, RTL `dir="ltr"` isolation); date formats; header, contact bar, avatar, microdata; social and print links; hreflang; profile, default and error layouts (including the URL-language script and `baseurl`); config switches such as `enable_live`, `lang_header`, `baseurl`, analytics, dark mode |
| [`test_language_switcher.rb`](../test/test_language_switcher.rb) | Generated HTML, six languages | Switcher links, labels, direction, page/site opt-out, error layout |
| [`test_resume_validator.rb`](../test/test_resume_validator.rb) | `ResumeValidator#validate`, `bin/validate-resume`, build plugin | Every schema rule per section, dates, "Present" values, URLs, alias keys, locale merge and parity, config resolution, strict mode, CLI flags |
| [`test_template_key_checker.rb`](../test/test_template_key_checker.rb) | `TemplateKeyChecker#check`, `bin/check-data-keys` | Liquid binding resolution, include boundaries, advisory exit codes |
| [`test_error_pages_generator.rb`](../test/test_error_pages_generator.rb) | Site build | Generated 404/403/500 pages, site overrides, generator registration |
| [`test_resume_pages_generator.rb`](../test/test_resume_pages_generator.rb) | Site build | Generated CV/profile pages, collisions, per-language and global toggles |
| [`test_json_resume_exporter.rb`](../test/test_json_resume_exporter.rb) | `JsonResumeExporter.export`, site build | JSON Resume mapping, privacy, visibility, schema validation, routes; see [JSON_RESUME_EXPORT.md](JSON_RESUME_EXPORT.md) |
| [`test_packaging.rb`](../test/test_packaging.rb) | Gemspec, shipped `_data` | Gem file list, six-locale key parity, unused locale keys, social icons and labels, demo data parity |

## The rendered-site fixture

`RenderedSiteTest` writes fixture data for `en` (LTR) and `ar` (RTL) into a temporary site. Each section has an entry for every rendering rule, an entry with optional fields missing, and an `active: false` entry whose text starts with `hidden-`. Entries are tagged `EN`/`AR` so a test can tell which language's data rendered.

Config variants reuse the same fixture. Pass overrides and the site is built once per distinct override set:

```ruby
cv("en", "enable_live" => true)          # _site/en/cv/ built with enable_live on
html("404.html", "baseurl" => "/cv")     # any output path
section("Experience")                    # the <section> whose heading matches, default config
```

## Adding a test

1. Pick the interface a user or consuming site touches: rendered HTML for templates, `validate` for data rules, a site build for generators.
2. Write the failing test first and run it to see the failure message.
3. Make the smallest change that passes it, then run `bundle exec rake`.

Common cases:

- **New section field:** add it to `resume_data` in `test_rendered_site.rb` and assert on the rendered text; add a validator rule test if the field is validated.
- **New locale key:** add it to all six `_data/locales/*.yml` files. `test_packaging.rb` fails if the key sets differ or no template reads the key.
- **New social platform:** follow [INCLUDES_GUIDE.md](INCLUDES_GUIDE.md#add-a-new-social-network); `test_packaging.rb` checks the SVG and labels.
- **New generator:** require it from `lib/bilingual-jekyll-resume-theme.rb` and add its class to the registration test in `test_error_pages_generator.rb`.

## Liquid pitfalls the tests guard

- `x != blank` is always true in this theme (plain strings and `nil` have no `blank?`). Use `x.size > 0` for text and `x` for dates.
- Liquid's `date` filter reads a bare year such as `2018` as a Unix timestamp; `date-formatter.html` parses ISO parts itself.
- Includes share the caller's variables. Prefix loop and helper variables (`switch_`, `social_`) so they cannot overwrite `lang`, `locale`, or `lang_cfg` in the layout.
