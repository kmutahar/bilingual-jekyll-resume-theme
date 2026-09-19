# CLAUDE.md

> **Notice**: The authoritative master guidance and architecture manual for this repository is maintained in **[`AGENTS.md`](AGENTS.md)**.
> To eliminate duplicate maintenance and documentation drift, all instructions, architecture specifications, data schemas, and agent operating rules reside exclusively in `AGENTS.md`.

@AGENTS.md

---

## Quick Reference for Claude Code

### Primary Instructions
When working in this repository with Claude Code, adhere strictly to **[`AGENTS.md`](AGENTS.md)**:

1. **Bilingual Parity**: Any change to resume sections or layouts must be mirrored in both English (LTR) and Arabic (RTL) templates (`resume-section-en.html` and `resume-section-ar.html`).
2. **Feature Roadmap**: Consult [`FEATURE_ROADMAP.md`](FEATURE_ROADMAP.md) before implementing features. All 19 open features have full technical blueprints and mapped GitHub issues.
3. **Issue Auto-Closing**: All commits and pull requests must use Conventional Commits and explicit issue closure syntax:
   `feat(<scope>): <description> (Closes #<issue_id>)`
4. **Historical Remediation Awareness**: Review [`docs/COMPLETED_AUDIT.md`](docs/COMPLETED_AUDIT.md) before touching security or structural areas to avoid duplicating or reverting completed work.
5. **Arabic (RTL) Mechanics**: Respect `dir="rtl"`, mirrored layouts, and date localization via `_data/ar/months.yml` and `_includes/ar-date.html`.

### Essential Commands
```bash
# Install dependencies
bundle install

# Start local server in theme repository
bundle exec jekyll serve --config docs/_data/_config.sample.yml

# Static site build in theme repository
bundle exec jekyll build --config docs/_data/_config.sample.yml

# Build Ruby gem locally
gem build bilingual-jekyll-resume-theme.gemspec
```

> **Maintenance Rule**: Do not add standalone architecture or rule updates to this file. Always update **[`AGENTS.md`](AGENTS.md)** directly.

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
