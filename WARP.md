# WARP.md

> **Notice**: The authoritative master guidance and architecture manual for this repository is maintained in **[`AGENTS.md`](AGENTS.md)**.
> All instructions, architecture specifications, data schemas, and operating rules reside exclusively in `AGENTS.md`.

## Quick Reference for Warp

### Living Docs Governance Signposts
- **Constitution**: [`AGENTS.md`](AGENTS.md) — Authoritative agent operating rules & parity constraints.
- **Map**: [`docs/PROJECT_OVERVIEW.md`](docs/PROJECT_OVERVIEW.md) — Architecture, file maps, and component guide.
- **Status**: [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md) — Current release (v0.8.0), 20 active features, and the Delete-Zone.
- **History**: [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md) & [`CHANGELOG.md`](CHANGELOG.md) — Historical audits & release history.

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
