# Data Structure Guide (`_data/`)

YAML schemas for every resume data file. Each resume section is one YAML file in a per-language data folder under `_data/`. The schemas are identical in every language; only the text values are translated.

UI strings, month names, and error page copy are not resume data: they live in the theme's locale files, `_data/locales/<lang>.yml`, documented in [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md).

---

## Table of Contents

- [Overview & Folder Architecture](#overview--folder-architecture)
- [Resume Content Sections](#resume-content-sections)
  - [1. Experience (`experience.yml`)](#1-experience-experienceyml)
  - [2. Education (`education.yml`)](#2-education-educationyml)
  - [3. Certifications (`certifications.yml`)](#3-certifications-certificationsyml)
  - [4. Courses (`courses.yml`)](#4-courses-coursesyml)
  - [5. Volunteering (`volunteering.yml`)](#5-volunteering-volunteeringyml)
  - [6. Projects (`projects.yml`)](#6-projects-projectsyml)
  - [7. Skills (`skills.yml`)](#7-skills-skillsyml)
  - [8. Recognition (`recognitions.yml`)](#8-recognition-recognitionsyml)
  - [9. Associations (`associations.yml`)](#9-associations-associationsyml)
  - [10. Languages (`languages.yml`)](#10-languages-languagesyml)
  - [11. Links (`links.yml`)](#11-links-linksyml)
  - [12. Interests (`interests.yml`)](#12-interests-interestsyml)
- [Header & Executive Summary (`header.yml`)](#header--executive-summary-headeryml)
- [Error Page Copy](#error-page-copy)
- [General Guidelines](#general-guidelines)
  - [Date Formats & ISO Standards](#date-formats--iso-standards)
  - [Active / Inactive Visibility Flags](#active--inactive-visibility-flags)
  - [YAML Formatting & Special Characters](#yaml-formatting--special-characters)
  - [Section Mapping Summary](#section-mapping-summary)

---

## Overview & Folder Architecture

> [!TIP]
> Keep one folder per language (`_data/en/`, `_data/ar/`, `_data/es/`, ...), each holding the same file names. Complete starter data for six languages (a Sherlock Holmes demo persona) is in [`_data/`](_data/): `en`, `ar`, `es`, `fr`, `de`, `ur`.

```text
_data/
├── ar/
│   ├── header.yml
│   ├── experience.yml
│   ├── education.yml
│   ├── certifications.yml
│   ├── courses.yml
│   ├── volunteering.yml
│   ├── projects.yml
│   ├── skills.yml
│   ├── recognitions.yml
│   ├── associations.yml
│   ├── languages.yml
│   ├── links.yml
│   └── interests.yml
├── en/
│   ├── header.yml
│   ├── experience.yml
│   ├── education.yml
│   ├── certifications.yml
│   ├── courses.yml
│   ├── volunteering.yml
│   ├── projects.yml
│   ├── skills.yml
│   ├── recognitions.yml
│   ├── associations.yml
│   ├── languages.yml
│   ├── links.yml
│   └── interests.yml
└── ...                       # one folder per language in `languages:`
```

In your site's `_config.yml` (see [`CONFIG_GUIDE.md`](CONFIG_GUIDE.md#3-languages)), each language's `data_path` points at its folder:

```yaml
languages:
  en:
    data_path: en   # _data/en/
  ar:
    data_path: ar   # _data/ar/
```

The file lists below name the English and Arabic starter files; every other language folder mirrors them.

---

## Resume Content Sections

### 1. Experience (`experience.yml`)

- **Files:** [`_data/en/experience.yml`](_data/en/experience.yml) / [`_data/ar/experience.yml`](_data/ar/experience.yml)
- **Config Toggle:** `resume_section.experience: true`
- **Behavior:** Roles are grouped by `company` name. Multiple positions at the same employer appear together, sorted by `startdate` (most recent first).

```yaml
# Standard role entry with ISO dates
- company: "Acme Corporation"
  position: "Senior Product Manager"
  startdate: 2022-03-01
  enddate: Present # Use "Present" for ongoing roles
  location: "San Francisco, CA"
  active: true
  summary: "Led cross-functional team of 12 engineers delivering enterprise AI products."

# Role with custom non-continuous duration strings
- company: "State University"
  position: "Adjunct Lecturer"
  durations:
    - duration: "Jun 2020 &ndash; Jan 2021"
    - duration: "&amp; Jun 2022 &ndash; Dec 2022"
  location: "Austin, TX"
  active: true
  summary: "Taught undergraduate courses in software architecture and human-computer interaction."
```

**Display Format:**
- Company name appears as a prominent section item heading.
- Multiple roles at the same company are automatically grouped together.
- Each role displays: **Position • Date Range • Location**.
- ISO dates render as `<month> <year>` through [`../_includes/date-formatter.html`](../_includes/date-formatter.html), with month names from the active locale (`March 2022` in English, `مارس 2022` in Arabic).
- Summary paragraph displays below the role details when provided and `enable_summary: true` is configured in `_config.yml`.

---

### 2. Education (`education.yml`)

- **Files:** [`_data/en/education.yml`](_data/en/education.yml) / [`_data/ar/education.yml`](_data/ar/education.yml)
- **Config Toggle:** `resume_section.education: true`
- **Required fields:** `uni` (or `institution`/`school`), `degree`, and `year` (a freeform display string — the validator requires it be present, but does not parse or format-check it, since it's shown as-is rather than run through the date formatter). An entry may use `startdate`/`enddate` instead of `year`; when present those are validated as ISO dates like every other section.

```yaml
- degree: "M.S. in Computer Science"
  uni: "Stanford University"
  year: "Sep 2018 &ndash; Jun 2020"
  location: "Stanford, CA"
  active: true
  awards:
    - award: "Graduate Research Fellowship"
    - award: "Dean's Honors List (2019)"
  summary: "Specialized in distributed systems and natural language processing."

- degree: "B.S. in Software Engineering"
  uni: "State University"
  year: "2014 &ndash; 2018"
  location: "Seattle, WA"
  active: true
  award: "Graduated Magna Cum Laude"
```

**Display Format:**
- University/institution name appears as a heading.
- Second line displays: **Degree • Year • Location**.
- Honors and achievements are rendered as bulleted points under the degree (supporting both single `award` and multiple `awards` lists).
- Summary paragraph displays beneath honors when provided.

---

### 3. Certifications (`certifications.yml`)

- **Files:** [`_data/en/certifications.yml`](_data/en/certifications.yml) / [`_data/ar/certifications.yml`](_data/ar/certifications.yml)
- **Config Toggle:** `resume_section.certifications: true`

```yaml
# Example with verification credential and URL
- name: "AWS Certified Solutions Architect &ndash; Professional"
  issuing_organization: "Amazon Web Services"
  credential_id: "AWS-PSA-987654"
  credential_url: "https://aws.amazon.com/verification"
  issue_date: 2023-04-15
  expiration: 2026-04-15
  active: true

# Example with nested courses for personal record-keeping
- name: "Business Certificate in Financial Management"
  active: true
  issuing_organization: "State University Executive Education"
  credential_id: "ABC123XYZ"
  credential_url: "https://example.com/cert/ABC123XYZ"
  issue_date: 2024-03-15
  expiration: 2027-03-15
  courses: # Optional: INTERNAL USE ONLY - not displayed on resume
    - name: "Accounting for Corporate Business"
      active: true
      issuing_organization: "State University"
      credential_id: "COURSE123"
      credential_url: "https://example.com/course/COURSE123"
      issue_date: 2024-01-10
      expiration:
```

> [!IMPORTANT]
> The nested `courses:` list within certification entries is designed strictly for **personal record-keeping and linking coursework to parent credentials**. It is **never rendered** on the generated resume. To display coursework visibly on your resume, use [`courses.yml`](#4-courses-coursesyml).

**Display Format:**
- Certification name appears as a bold heading.
- Second line displays: **Issuing Organization • Issue Date – Expiration Date**.
- Credential ID is rendered as a clickable link if `credential_url` is provided, and the full destination URL is printed in parentheses in physical and PDF outputs.

---

### 4. Courses (`courses.yml`)

- **Files:** [`_data/en/courses.yml`](_data/en/courses.yml) / [`_data/ar/courses.yml`](_data/ar/courses.yml)
- **Config Toggle:** `resume_section.courses: true`

```yaml
- name: "Deep Learning Specialization"
  issuing_organization: "DeepLearning.AI / Coursera"
  credential_id: "COURSERA-DL-1234"
  credential_url: "https://coursera.org/verify/COURSERA-DL-1234"
  startdate: 2024-01-10
  enddate: 2024-03-20
  active: true
  summary: "Comprehensive sequence covering CNNs, RNNs, Transformers, and optimization algorithms."
```

**Display Format:**
- Course name appears as a heading.
- Second line displays: **Issuing Organization • Start Date – End Date**.
- Summary paragraph displays if provided and `enable_summary: true` is configured in `_config.yml`.
- Credential ID displays with an interactive link when `credential_url` is provided.

---

### 5. Volunteering (`volunteering.yml`)

- **Files:** [`_data/en/volunteering.yml`](_data/en/volunteering.yml) / [`_data/ar/volunteering.yml`](_data/ar/volunteering.yml)
- **Config Toggle:** `resume_section.volunteering: true`

```yaml
- company: "Code for Good"
  position: "Technical Mentor"
  startdate: 2021-06-01
  enddate: Present
  location: "Remote"
  active: true
  summary: "Mentored aspiring engineers from underrepresented backgrounds on web development and open source contribution."
```

**Display Format:**
- Same layout structure as the [Experience](#1-experience-experienceyml) section: grouped by organization name and sorted chronologically.
- Displays: **Position • Date Range • Location** followed by the summary paragraph.

---

### 6. Projects (`projects.yml`)

- **Files:** [`_data/en/projects.yml`](_data/en/projects.yml) / [`_data/ar/projects.yml`](_data/ar/projects.yml)
- **Config Toggle:** `resume_section.projects: true`

```yaml
- project: "Open Source Data Pipeline"
  role: "Author & Maintainer"
  duration: "Jan 2023 &ndash; Present"
  url: "https://github.com/yourusername/pipeline"
  active: true
  description: "High-throughput streaming ETL pipeline written in Go and Apache Kafka, processing 5M+ daily events."
```

**Display Format:**
- Project title appears as a bold heading (rendered as a clickable link if `url` is specified).
- Second line displays: **Role • Duration**.
- Project description appears as a paragraph below.
- In print and PDF versions, external URLs are automatically echoed in parentheses.

---

### 7. Skills (`skills.yml`)

- **Files:** [`_data/en/skills.yml`](_data/en/skills.yml) / [`_data/ar/skills.yml`](_data/ar/skills.yml)
- **Config Toggle:** `resume_section.skills: true`

```yaml
- skill: "Cloud Architecture & Infrastructure"
  active: true
  description: "Expert in AWS, GCP, Terraform, Docker, and Kubernetes. Designed and deployed multi-region high-availability infrastructure."

- skill: "Product Strategy & Technical Leadership"
  active: true
  description: "Roadmapping, OKR tracking, cross-functional mentoring, agile sprint leadership, and stakeholder communication."
```

**Display Format:**
- Skill name appears as a bold subheading (`<h3>`).
- Description appears as a detailed narrative paragraph immediately below the subheading.

---

### 8. Recognition (`recognitions.yml`)

- **Files:** [`_data/en/recognitions.yml`](_data/en/recognitions.yml) / [`_data/ar/recognitions.yml`](_data/ar/recognitions.yml)
- **Config Toggle:** `resume_section.recognitions: true`

> [!NOTE]
> The configuration toggle and render order key is **`recognitions`** (plural), matching the data file **`recognitions.yml`**. The singular `recognition` key was removed in v1.0.0.

```yaml
- award: "Innovator of the Year"
  organization: "Global Tech Summit"
  year: "2023"
  active: true
  summary: "Awarded for exceptional contributions to open-source developer tooling and developer velocity."

- award: "Dean's Excellence Award"
  organization: "State University"
  year: "2019, 2020"
  active: true
  summary: "Recognized for academic achievement and research excellence in computer engineering."
```

**Display Format:**
- Award name appears as a bold heading.
- Second line displays: **Awarding Organization • Year**.
- Summary description appears as a paragraph.

---

### 9. Associations (`associations.yml`)

- **Files:** [`_data/en/associations.yml`](_data/en/associations.yml) / [`_data/ar/associations.yml`](_data/ar/associations.yml)
- **Config Toggle:** `resume_section.associations: true`

```yaml
- organization: "Association for Computing Machinery (ACM)"
  role: "Senior Member"
  year: "2019 &ndash; Present"
  url: "https://www.acm.org"
  active: true
  summary: "Active contributor to SIGMOD working groups on data systems and data governance."
```

**Display Format:**
- Organization name appears as a heading (clickable link if `url` is provided).
- Second line displays: **Role • Year**.
- Summary paragraph describes candidate involvement and leadership.
- In print mode, the destination URL is echoed in parentheses.

---

### 10. Languages (`languages.yml`)

- **Files:** [`_data/en/languages.yml`](_data/en/languages.yml) / [`_data/ar/languages.yml`](_data/ar/languages.yml)
- **Config Toggles:**
  - `resume_section.lang_header: true`: Renders compact language chips directly in the header.
  - `resume_section.languages: true`: Renders a standalone two-column table section.

```yaml
- language: "English"
  description: "Native / Bilingual proficiency"
  descrp_short: "Native" # Used for compact header chips
  active: true

- language: "Arabic"
  description: "Professional working proficiency"
  descrp_short: "Professional"
  active: true

- language: "German"
  description: "Elementary working proficiency"
  descrp_short: "Elementary"
  active: true
```

**Display Format:**
- **Table Mode (`resume_section.languages: true`):** Renders a responsive two-column table in the main body. Each entry displays: **Language: Description**.
- **Header Chips Mode (`resume_section.lang_header: true`):** Renders inline compact badges below the job title in the resume header using the `descrp_short` attribute.

---

### 11. Links (`links.yml`)

- **Files:** [`_data/en/links.yml`](_data/en/links.yml) / [`_data/ar/links.yml`](_data/ar/links.yml)
- **Config Toggle:** `resume_section.links: true`

```yaml
- description: "Technical Blog & Architecture Articles"
  url: "https://blog.yourdomain.com"
  active: true

- description: "GitHub Open Source Dossier"
  url: "https://github.com/yourusername"
  active: true
```

**Display Format:**
- Clean bulleted list of clickable text links.
- External URLs are echoed in parentheses during print and PDF rendering.

---

### 12. Interests (`interests.yml`)

- **Files:** [`_data/en/interests.yml`](_data/en/interests.yml) / [`_data/ar/interests.yml`](_data/ar/interests.yml)
- **Config Toggle:** `resume_section.interests: true`

```yaml
- description: "Distributed systems research and open-source software"
- description: "Landscape photography and digital storytelling"
- description: "Long-distance trail running and mountaineering"
```

**Display Format:**
- Unordered bulleted list under the "Outside Interests" section heading.
- Does not require an active flag: any item listed in the file will render.

---

## Header & Executive Summary (`header.yml`)

- **Files:** [`_data/en/header.yml`](_data/en/header.yml) / [`_data/ar/header.yml`](_data/ar/header.yml)
- **Config Toggle:** `languages.<lang>.header_intro: true` (per language)

Contains the executive bio summary rendered directly beneath the candidate name, job title, and social links bar:

```yaml
# _data/en/header.yml
intro: >-
  Results-oriented engineering leader with 10+ years of experience designing scalable distributed systems, cloud platforms, and bilingual consumer products. Passionate about developer tooling, accessibility, and high-performance architecture.
```

```yaml
# _data/ar/header.yml
intro: >-
  قائد هندسي متميز يتمتع بخبرة تزيد عن 10 سنوات في تصميم الأنظمة الموزعة والمنصات السحابية والتطبيقات ثنائية اللغة. شغوف بأدوات المطورين ومعايير النفاذ الرقمي والبنى التحتية عالية الأداء.
```

**Display Format:**
- Appears as a prominent narrative paragraph immediately below candidate name, title, contact row, and social links in the resume header.
- Only displays when `languages.<lang>.header_intro: true` is set for that language in `_config.yml`.
- Fully supports basic HTML inline formatting (e.g., `<strong>`, `<em>`).

---

## Error Page Copy

Error page text is not in your data folders. Each locale file carries an `error_pages` map, and [`../_layouts/error.html`](../_layouts/error.html) renders one block per language in `site.languages`, in config order:

```yaml
# _data/locales/en.yml (excerpt)
error_pages:
  "404":
    title: "Page Not Found"
    message: "The page you are looking for might have been removed, had its name changed, or is temporarily unavailable."
  "403": { title: "...", message: "..." }
  "500": { title: "...", message: "..." }
  "503": { title: "...", message: "..." }
  return_link: "Return to resume"
```

To change the copy, override `error_pages` in your site's `_data/locales/<lang>.yml` (see [`MULTILINGUAL_GUIDE.md`](MULTILINGUAL_GUIDE.md#overriding-theme-locales)). Pages using `layout: error` accept `code` (default `"404"`) and `show_reload: true` in front matter; the reload button also appears automatically for `500` and `503`. Return links point at each `languages.<lang>.url`.

---

## General Guidelines

### Date Formats & ISO Standards

1. **Structured Dates (`startdate`, `enddate`, `issue_date`):**
   - Always specify dates in ISO format: `YYYY-MM-DD` (e.g., `2024-03-15`).
   - `YYYY-MM` and `YYYY` are also accepted by the validator.
   - Every language formats dates through [`../_includes/date-formatter.html`](../_includes/date-formatter.html), using the `months` list in `_data/locales/<lang>.yml`.
   - For ongoing positions leave `enddate` blank or use a word from the locale's `present_values` (for example `Present`); it renders as the locale's `ui.present`.

2. **Freeform Display Strings (`year`, `duration`):**
   - Used in education, projects, and associations.
   - Use HTML entities like `&ndash;` for en-dash (–) and `&amp;` for ampersand (&).

### Active / Inactive Visibility Flags

All resume items support the boolean `active:` flag:
- `active: true`: Item renders on the resume.
- `active: false`: Item is preserved in your YAML record but omitted from generated HTML.
- No `active` key: the item does not render either, and the validator warns. `interests.yml` is the exception: its items have no flag and always render.

### YAML Formatting & Special Characters

- Wrap values containing colons, quotes, or dashes in double quotes:
  ```yaml
  name: "AWS Certified: Solutions Architect"
  ```
- Multiline summaries should use YAML folded blocks (`>-`) or literal blocks (`|`):
  ```yaml
  summary: >-
    First line of summary text that will flow continuously
    without unwanted line breaks.
  ```

### Section Mapping Summary

| Section Name | Config Key (`resume_section`) | Render Order Key (`resume_section_order`) | YAML File Name |
|---|---|---|---|
| Experience | `experience` | `experience` | `experience.yml` |
| Education | `education` | `education` | `education.yml` |
| Certifications | `certifications` | `certifications` | `certifications.yml` |
| Courses | `courses` | `courses` | `courses.yml` |
| Volunteering | `volunteering` | `volunteering` | `volunteering.yml` |
| Projects | `projects` | `projects` | `projects.yml` |
| Skills | `skills` | `skills` | `skills.yml` |
| Recognition | `recognitions` | `recognitions` | `recognitions.yml` |
| Associations | `associations` | `associations` | `associations.yml` |
| Languages | `languages` / `lang_header` | `languages` | `languages.yml` |
| Links | `links` | `links` | `links.yml` |
| Interests | `interests` | `interests` | `interests.yml` |
| Header Intro | `languages.<lang>.header_intro` | *(rendered in header)* | `header.yml` |
