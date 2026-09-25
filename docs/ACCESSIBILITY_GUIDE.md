# Accessibility Guide (WCAG 2.1 & 2.2 AA Compliance)

`bilingual-jekyll-resume-theme` is engineered from the ground up to achieve high-fidelity visual parity and strict **WCAG 2.1 / 2.2 Level AA compliance** across both Left-to-Right (English) and Right-to-Left (Arabic) layouts.

---

## Table of Contents

- [1. Overview & Accessibility Standards](#1-overview--accessibility-standards)
- [2. Semantic Landmarks & Page Structure](#2-semantic-landmarks--page-structure)
- [3. Keyboard Navigation & Skip-to-Content Links](#3-keyboard-navigation--skip-to-content-links)
- [4. Visible Focus Rings (:focus-visible)](#4-visible-focus-rings-focus-visible)
- [5. Screen Reader Optimization & .sr-only Utility](#5-screen-reader-optimization--sr-only-utility)
- [6. Color Contrast Ratios & Dark Mode Verification](#6-color-contrast-ratios--dark-mode-verification)
- [7. Arabic (RTL) Internationalization & Bidi Safety](#7-arabic-rtl-internationalization--bidi-safety)
- [8. Testing & Verification Procedures](#8-testing--verification-procedures)

---

## 1. Overview & Accessibility Standards

The theme satisfies the four core WCAG principles:

1. **Perceivable**: All information and user interface components are presentable in ways users can perceive (text alternatives, sufficient color contrast, robust dark/light tokens, responsive fluid typography).
2. **Operable**: All interface components and navigation are fully operable via keyboard (tab navigation, skip links, visible focus indicators, no keyboard traps).
3. **Understandable**: Clear language attributes (`lang="en"`, `lang="ar"`), logical reading order, bidirectional text isolation (`<span dir="ltr">`), and predictable navigation controls.
4. **Robust**: Semantic HTML5 landmark roles (`banner`, `main`, `contentinfo`), Schema.org Person microdata, and broad compatibility with modern assistive technologies (NVDA, JAWS, VoiceOver, TalkBack).

---

## 2. Semantic Landmarks & Page Structure

All theme layouts define explicit ARIA landmark roles alongside semantic HTML5 elements:

| HTML Element | ARIA Role | Identification | Purpose |
| :--- | :--- | :--- | :--- |
| `<header class="page-header">` | `role="banner"` | Page Header | Houses candidate name, title, avatar, and contact bar |
| `<main class="main-content">` | `role="main"` | `id="main-content"` `tabindex="-1"` | Primary content container target of skip-to-content links |
| `<footer class="page-footer">` | `role="contentinfo"` | Page Footer | Generation timestamp, copyright, and permalink |
| `<details class="language-switcher">` → `<nav class="language-switcher-panel">` | native disclosure + `role="navigation"` (implicit on `<nav>`) | Language Switcher | Floating dropdown language selector, zero JavaScript |
| `<form class="error-search">` | `role="search"` | Search Form | Search interface on error pages |

---

## 3. Keyboard Navigation & Skip-to-Content Links

To satisfy **WCAG 2.4.1 (Bypass Blocks)**, all layouts include an accessible skip link positioned as the first focusable element inside `<body>`.

`_layouts/resume.html`, `_layouts/default.html`, and `_layouts/profile.html` render the link text from the active locale's `ui.skip_to_content` key in `_data/locales/<lang>.yml`:
```html
<a href="#main-content" class="skip-link no-print">{{ locale.ui.skip_to_content }}</a>
```
English renders "Skip to main content"; Arabic renders "الانتقال إلى المحتوى الرئيسي".

### Behavior:
- **Default State**: Visually hidden off-screen (`top: -100px`).
- **Focus State**: When a user presses `Tab` upon page entry, the skip link smoothly transitions into view at `top: 1rem` with a prominent high-contrast background (`--accent-color`) and 2px focus ring. Pressing `Enter` shifts focus directly to `<main id="main-content">`.

---

## 4. Visible Focus Rings (`:focus-visible`)

To satisfy **WCAG 2.4.7 (Focus Visible)** and **WCAG 2.5.8 (Target Size)**:
- Universal `:focus-visible` styling is defined in `_sass/_base.scss`:
  ```scss
  :focus-visible {
    outline: 2px solid var(--accent-color, #3064a9);
    outline-offset: 2px;
  }
  ```
- Focus rings automatically match the active color theme and dark mode contrast tokens.
- Mouse clicks do not trigger intrusive focus rings, preserving clean visual ergonomics.

---

## 5. Screen Reader Optimization & `.sr-only` Utility

- Vector SVG icons (social links, contact badges, search buttons) include visually hidden text labels via the `.sr-only` utility class:
  ```html
  <a href="..." class="icon-link" aria-label="GitHub" title="GitHub">
    <svg aria-hidden="true" focusable="false">...</svg>
    <span class="sr-only">GitHub</span>
  </a>
  ```
- **`.sr-only` CSS Definition**:
  ```scss
  .sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border-width: 0;
    text-decoration: none !important;
  }
  ```

---

## 6. Color Contrast Ratios & Dark Mode Verification

All color pairings meet or exceed the **WCAG AA minimum contrast ratio of 4.5:1** for standard body text and **3.0:1** for large headings and UI components:

| Element | Light Mode Pair | Contrast Ratio | Dark Mode Pair | Contrast Ratio | Level |
| :--- | :--- | :---: | :--- | :---: | :---: |
| Body Text | `#333333` on `#ffffff` | **12.6:1** | `#e0e0e0` on `#121212` | **13.8:1** | **AAA** |
| Muted Text | `#646464` on `#ffffff` | **5.9:1** | `#aaaaaa` on `#121212` | **8.0:1** | **AA** |
| Accent Links | `#3064a9` on `#ffffff` | **5.4:1** | `#6ba4e8` on `#121212` | **6.6:1** | **AA** |
| Buttons | `#333333` on `#efefef` | **11.2:1** | `#e0e0e0` on `#2a2a2a` | **9.2:1** | **AAA** |

---

## 7. Arabic (RTL) Internationalization & Bidi Safety

1. **Root Direction**: Set via `<html dir="rtl" lang="ar">`.
2. **Typography**: Arabic font stack uses `Cairo` with `line-height: 1.6` (minimum) to prevent vertical clipping of vowel diacritics (Tashkeel like Fatḥah, Ḍammah, Kasrah) and consonant dots.
3. **Bi-directional (Bidi) Text Isolation**: URLs, phone numbers, and code identifiers within Arabic sentences are enclosed in `<span dir="ltr">` to prevent punctuation, slashes, and numbers from reversing.

---

## 8. Testing & Verification Procedures

Run the automated build and verify accessibility attributes:

```bash
# Build static site
bundle exec jekyll build --source demo --destination _site

# Verify skip link presence
grep -q 'class="skip-link' _site/index.html && echo "Skip link verified."

# Verify main landmark
grep -q 'role="main"' _site/index.html && echo "Main landmark verified."
```
