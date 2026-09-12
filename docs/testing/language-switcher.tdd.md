# TDD Evidence Report: Feature 1.2 — Interactive Bilingual Language Switcher (EN ⇋ AR)

- **Feature Roadmap ID**: Phase 1 ID 1.2
- **Issue Reference**: [#11](https://github.com/kmutahar/bilingual-jekyll-resume-theme/issues/11)
- **Branch**: `feature/language-switcher`
- **RED Checkpoint Commit**: `2ecdcd2` (`test: add reproducer for language switcher (RED gate)`)
- **GREEN Checkpoint Commit**: `6f9b7bf` (`feat(i18n): implement interactive bilingual language switcher (Closes #11)`)

---

## 1. User Journeys & Requirements

1. **English Reader Journey**:
   - *As an English visitor to the resume*, I want to see a floating switcher displaying "عربي" at the top-left, so that I can immediately switch to the Arabic layout.
2. **Arabic Reader Journey**:
   - *As an Arabic visitor to the resume*, I want to see a floating switcher displaying "EN" at the top-right, so that I can immediately switch to the English layout.
3. **Screen-Reader / Accessibility Journey**:
   - *As a visually impaired user navigating via screen reader*, I want descriptive localized `aria-label` tags and landmarks (`role="navigation"`), so that I understand where the button navigates.
4. **Print / PDF Journey**:
   - *As a recruiter or candidate printing or exporting the resume to PDF*, I want the switcher to be automatically hidden, so that it does not clutter the printed output.
5. **Site Author Customization**:
   - *As a site administrator*, I want to disable the switcher site-wide (`resume_language_switcher: false`) or per-page (`language_switcher: false`), and customize destination URLs.

---

## 2. Test Execution & Evidence

### Command Run
```bash
bundle exec ruby test/test_language_switcher.rb
```

### RED Phase Output (Commit `2ecdcd2`)
```text
Running Language Switcher Test Suite...
FFFFFFFFFF

Results:
Passed: 0
Failures: 10

Failure Details:
  1) File _includes/language-switcher.html must exist
  2) _layouts/resume-en.html must include language-switcher.html
  3) _layouts/resume-ar.html must include language-switcher.html
  4) _layouts/default.html must include language-switcher.html
  5) _sass/_layout.scss must define .language-switcher styles
  6) _sass/_layout.scss must position .language-switcher fixed
  7) _sass/_layout.scss must position .language-switcher at left: 1.25rem
  8) _sass/_resume-rtl.scss must mirror .language-switcher styles
  9) _sass/_resume-rtl.scss must mirror .language-switcher to right: 1.25rem
  10) assets/css/main.scss must import @use 'layout'
```

### GREEN Phase Output (Commit `6f9b7bf`)
```text
Running Language Switcher Test Suite...
...........................

Results:
Passed: 27
Failures: 0

All tests passed successfully!
```

---

## 3. Test Specification & Verification Matrix

| # | What is guaranteed | Test Assertion | Test Type | Result | Evidence |
|---|-------------------|----------------|-----------|--------|----------|
| 1 | Include component exists | `File.exist?('_includes/language-switcher.html')` | Unit | PASS | Verified in `test_file_existence` |
| 2 | English resume includes component | `assert_includes(en_layout, 'language-switcher.html')` | Integration | PASS | Verified in `test_layout_integration` |
| 3 | Arabic resume includes component | `assert_includes(ar_layout, 'language-switcher.html')` | Integration | PASS | Verified in `test_layout_integration` |
| 4 | Default layout includes component | `assert_includes(default_layout, 'language-switcher.html')` | Integration | PASS | Verified in `test_layout_integration` |
| 5 | LTR positioning (top-left) | `.language-switcher { position: fixed; left: 1.25rem; }` | Unit | PASS | Verified in `test_scss_rules` |
| 6 | RTL positioning mirrored (top-right) | `html[dir="rtl"] .language-switcher { right: 1.25rem; left: auto; }` | Unit | PASS | Verified in `test_scss_rules` |
| 7 | Main stylesheet imports layout | `main.scss` `@use "layout"` | Unit | PASS | Verified in `test_scss_rules` |
| 8 | English resume renders label "عربي" | `assert_includes(en_html, 'عربي')` | E2E Build | PASS | Verified in `test_rendering_behavior` |
| 9 | English resume renders Arabic aria-label | `assert_includes(en_html, 'aria-label="التحويل إلى اللغة العربية"')` | Accessibility | PASS | Verified in `test_rendering_behavior` |
| 10 | English resume links to `/resume/ar/` | `assert_includes(en_html, 'href="/resume/ar/"')` | E2E Build | PASS | Verified in `test_rendering_behavior` |
| 11 | Arabic resume renders label "EN" | `assert_includes(ar_html, 'EN')` | E2E Build | PASS | Verified in `test_rendering_behavior` |
| 12 | Arabic resume renders English aria-label | `assert_includes(ar_html, 'aria-label="Switch language to English"')` | Accessibility | PASS | Verified in `test_rendering_behavior` |
| 13 | Arabic resume links to `/resume/en/` | `assert_includes(ar_html, 'href="/resume/en/"')` | E2E Build | PASS | Verified in `test_rendering_behavior` |
| 14 | Print suppression class present | `assert_includes(html, 'class="language-switcher no-print"')` | CSS / Print | PASS | Verified in `test_rendering_behavior` |
| 15 | Page-level override suppresses switcher | `language_switcher: false` produces no button | Functional | PASS | Verified in `test_rendering_behavior` |
| 16 | Error layout suppresses switcher | `layout: error` produces no button | Functional | PASS | Verified in `test_rendering_behavior` |
| 17 | Site-wide config override suppresses switcher | `resume_language_switcher: false` produces no button | Functional | PASS | Verified in `test_rendering_behavior` |

---

## 4. Build & Packaging Verification

```bash
# Clean Jekyll build
bundle exec jekyll build --config docs/_data/_config.sample.yml
# Exit code: 0, 0 Liquid errors

# Gem packaging
gem build bilingual-jekyll-resume-theme.gemspec
# Result: bilingual-jekyll-resume-theme-0.7.0.gem packaged cleanly
```
