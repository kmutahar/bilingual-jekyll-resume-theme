# WARP.md

> **Notice**: The authoritative master guidance and architecture manual for this repository is maintained in **[`AGENTS.md`](AGENTS.md)**.
> All instructions, architecture specifications, data schemas, and operating rules reside exclusively in `AGENTS.md`.

## Quick Reference for Warp

When working in this repository with Warp terminal, refer directly to **[`AGENTS.md`](AGENTS.md)**.

### Common Commands
```bash
# Install dependencies
bundle install

# Run local development server in theme repository
bundle exec jekyll serve --config docs/_data/_config.sample.yml

# Static site build in theme repository
bundle exec jekyll build --config docs/_data/_config.sample.yml

# Build gem package locally
gem build bilingual-jekyll-resume-theme.gemspec
```

> **Maintenance Rule**: Do not add standalone architecture or rule updates to this file. Always update **[`AGENTS.md`](AGENTS.md)** directly.
