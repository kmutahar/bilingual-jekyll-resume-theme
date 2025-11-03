# Data Structure Documentation

This document explains all data file structures used by the bilingual Jekyll resume theme. Each section of your resume is stored in a separate YAML file in the `_data/` directory.

Key Features:

1. Complete coverage of all 12 data types with commented YAML examples
2. Clear explanations of how each field is used and displayed
3. Multiple examples per section showing different use cases
4. Important notes like the certification courses field being for personal record-keeping only (never displayed)
5. Display format descriptions so users understand how their data will appear
6. General guidelines section covering:
    * Date formats (ISO format vs display text)
    * Active/inactive flags
    * Required vs optional fields
    * Special characters in YAML
    * File locations
    * How to enable/disable sections in _config.yml

Highlights:

* Experience & Volunteering: Explained the grouping by company and the alternative durations field for non-continuous periods
* Education: Clarified the difference between single award field and awards list
* Certifications: Emphasized that nested courses are NOT displayed (personal record-keeping only)
* Languages: Explained the two display modes (section vs header) and the descrp_short field purpose
* Dates: Clear distinction between ISO dates for auto-formatting and display text for manual control
* HTML Entities: Explained when to use &mdash; and &amp;

## Table of Contents

1. [Experience](#experience)
2. [Education](#education)
3. [Certifications](#certifications)
4. [Courses](#courses)
5. [Volunteering](#volunteering)
6. [Projects](#projects)
7. [Skills](#skills)
8. [Recognition](#recognition)
9. [Associations](#associations)
10. [Languages](#languages)
11. [Links](#links)
12. [Interests](#interests)
13. [General Guidlines](#general-guidelines)

---

## Experience

**File:** `_data/experience.yml`

Jobs are grouped by company name. Multiple roles at the same company will be displayed together. Roles are sorted by `startdate` (most recent first).

```yaml
# Each entry represents a role/position
- company: "Freelance, Self-employed"          # Required: Company/organization name
  position: "Wordpress Developer"              # Required: Job title/position
  startdate: 2018-05-01                        # Required: Start date (YYYY-MM-DD format)
  enddate: 2018-08-31                          # Optional: End date (YYYY-MM-DD) or "Present" for current roles
  location: "Remote"                           # Optional: Job location
  active: true                                 # Required: Set to false to hide this entry
  notes:                                       # Optional: Personal notes (not displayed on resume)
  summary:                                     # Optional: Job description (only shown if enable_summary is true in _config.yml)

# Example with multiple duration periods (alternative to startdate/enddate)
- company: "State University"
  position: "Lecturer"
  durations:                                   # Alternative: Use this instead of startdate/enddate for non-continuous periods
    - duration: "Jun 2020 &mdash; Jan 2021"    # Display text for first period
    - duration: "&amp; Jun 2022 &mdash; Dec 2022"  # Display text for second period
  location: "Semenyih, Malaysia"
  active: true
  notes:
  summary:

# Example of current position
- company: "Acme Corporation"
  position: "Senior Developer"
  startdate: 2020-03-15
  enddate: Present                             # Use "Present" for ongoing positions
  location: "New York, NY"
  active: true
  notes: "Remember to update this quarterly"
  summary: "Led development team of 5 engineers building cloud infrastructure."
```

**Display Format:** 
- Company name appears as a heading
- Multiple roles at same company are grouped together
- Each role shows: Position • Date Range • Location
- Dates auto-format as "Mon YYYY" (e.g., "May 2018")

---

## Education

**File:** `_data/education.yml`

```yaml
- degree: "Bachelor of Business"  # Required: Degree name and details
  active: true                                 # Required: Set to false to hide this entry
  uni: "State University"     # Required: University/institution name
  year: "Sep 2020 &mdash; June 2024"           # Required: Time period (as display text)
  location: "Sana'a, Yemen"                    # Required: Location of institution
  awards:                                      # Optional: List of awards/honors received
    - award: "Deans List (2021-2022)"
    - award: "Deans List (2020-2021)"
  award: "Graduated with Honors"              # Optional: Single award (alternative to awards list)
  summary:                                     # Optional: Additional description

# Minimal example
- degree: "High School Diploma"
  active: true
  uni: "Springfield High School"
  year: "2015 &mdash; 2019"
  location: "Springfield, IL"
```

**Display Format:**
- University name as heading
- Second line: Degree • Year • Location
- Awards listed as bullet points
- Summary paragraph (if provided)

---

## Certifications

**File:** `_data/certifications.yml`

```yaml
- name: "Business Certificate"        # Required: Certification name
  active: false                                # Required: Set to true to display on resume
  issuing_organization: "State Univerisity" # Required: Organization that issued the certification
  credential_id: "ABC123XYZ"                   # Optional: Credential/certificate ID number
  credential_url: "https://example.com/cert/ABC123XYZ" # Optional: URL to verify credential
  issue_date: 2024-03-15                       # Required: Date issued (YYYY-MM-DD format)
  expiration: 2027-03-15                       # Optional: Expiration date (YYYY-MM-DD format)
  courses:                                     # Optional: INTERNAL USE ONLY - not displayed on resume
    - name: "Accounting for Business"       # These nested courses are for personal record-keeping
      active: false                            # They link courses to their parent certification
      issuing_organization: "State Univerisity"  # but are never shown on the final resume
      credential_id: "COURSE123"
      credential_url: "https://example.com/course/COURSE123"
      issue_date: 2024-01-10
      expiration:

# Example with credential ID but no URL
- name: "AWS Certified Solutions Architect"
  active: true
  issuing_organization: "Amazon Web Services"
  credential_id: "AWS-CSA-2024-1234"
  credential_url: ""                           # Empty if no verification URL exists
  issue_date: 2024-06-01
  expiration: 2027-06-01
```

**Display Format:**
- Certification name as heading
- Organization • Issue Date — Expiration Date •
- Credential ID: [clickable link if URL provided] (URL shown in print)

**Important Note:** The `courses` field within certifications is for **personal record-keeping only** and will **never be displayed** on your resume. Use the separate `courses.yml` file for courses you want to display.

---

## Courses

**File:** `_data/courses.yml`

```yaml
- name: "Certificate of Course Completion"  # Required: Course name
  active: true                                 # Required: Set to false to hide this entry
  issuing_organization: "ABC Academy"  # Required: Organization providing the course
  credential_id: "MC-DRW-2025-456"            # Optional: Credential/certificate ID
  credential_url: "https://academy.example.com/verify/456"  # Optional: URL to verify credential
  startdate: 2025-02-03                        # Required: Course start date (YYYY-MM-DD format)
  enddate: 2025-02-06                          # Optional: Course end date (YYYY-MM-DD format)
  expiration:                                  # Optional: Credential expiration date
  notes:                                       # Optional: Personal notes (not displayed)
  summary:                                     # Optional: Course description (only shown if enable_summary is true)

# Example without credential
- name: "Introduction to Machine Learning"
  active: true
  issuing_organization: "Stanford Online"
  credential_id: ""
  credential_url: ""
  startdate: 2024-09-01
  enddate: 2024-12-15
  summary: "Comprehensive introduction to ML algorithms and practical applications."
```

**Display Format:**
- Course name as heading
- Organization • Start Date — End Date
- Summary paragraph (if provided and enabled)
- Credential ID with link (if provided)

---

## Volunteering

**File:** `_data/volunteering.yml`

Structure is identical to Experience section. Volunteer positions are grouped by organization.

```yaml
- company: "Red Cross"           # Required: Organization name
  position: "First Aid"                          # Required: Role/position title
  startdate: 2011-11-01                        # Required: Start date (YYYY-MM-DD)
  enddate: 2013-01-31                          # Optional: End date or "Present"
  location: "Springfield, IL"                # Optional: Location
  active: false                                # Required: Set to true to display
  notes:                                       # Optional: Personal notes (not displayed)
  summary:                                     # Optional: Description of volunteer work

# Example with durations (alternative date format)
- company: "Local Food Bank"
  position: "Volunteer Coordinator"
  durations:
    - duration: "Summer 2022"
    - duration: "&amp; Winter 2021"
  location: "Austin, TX"
  active: true
  summary: "Organized food distribution events serving 500+ families monthly."
```

**Display Format:**
Same as Experience section - grouped by organization, sorted by date.

---

## Projects

**File:** `_data/projects.yml`

```yaml
- project: "Closed Source Project"                        # Required: Project name
  active: true                                 # Required: Set to false to hide
  role: "Maintainer"                           # Required: Your role in the project
  duration: "May 2021 &mdash; Present"        # Required: Time period (as display text)
  url: "https://www.example.com/"              # Optional: Project URL
  description:                                 # Required: Project description

# Complete example
- project: "Open Source Dashboard"
  active: true
  role: "Lead Developer"
  duration: "Jan 2023 &mdash; Jun 2024"
  url: "https://github.com/username/dashboard"
  description: "Built a real-time analytics dashboard using React and Node.js, serving 10K+ users daily."

# Example without URL
- project: "University Capstone Project"
  active: true
  role: "Team Lead"
  duration: "Sep 2022 &mdash; May 2023"
  url: ""
  description: "Developed an inventory management system for local businesses."
```

**Display Format:**
- Project name as heading (clickable if URL provided)
- Role • Duration
- Description paragraph
- URL shown in parentheses on printed version

---

## Skills

**File:** `_data/skills.yml`

```yaml
- skill: "Organizational leadership"           # Required: Skill name/title
  active: true                                 # Required: Set to false to hide
  description: "I have several years of experience leading organizations from community groups to business departments. From public speaking, to mentoring, to coordination of people and events, I can lead in any context."  # Required: Detailed description

# Multiple examples
- skill: "Full-Stack Web Development"
  active: true
  description: "Expert in JavaScript, React, Node.js, and PostgreSQL. Built and deployed 20+ production applications."

- skill: "Technical Writing"
  active: true
  description: "Created comprehensive documentation for APIs, user guides, and technical specifications."

- skill: "Legacy Skill"
  active: false                                # This will not appear on resume
  description: "Old technology no longer relevant to current career goals."
```

**Display Format:**
- Skill name as subheading
- Description as paragraph

---

## Recognition

**File:** `_data/recognitions.yml`

```yaml
- award: "Outstanding Achievement"             # Required: Award name
  active: true                                 # Required: Set to false to hide
  organization: "Springfield Young Professionals"  # Required: Awarding organization
  year: "2010, 2014"                          # Required: Year(s) received (can be multiple)
  summary: "Awarded the Outstanding Achievement award for contributions made to the community and professional accomplishments."  # Required: Award description

# Multiple year format example
- award: "Employee of the Quarter"
  active: true
  organization: "Acme Corporation"
  year: "Q2 2023, Q4 2023"
  summary: "Recognized for exceptional performance and dedication to team success."

# Single award example
- award: "Dean's List"
  active: true
  organization: "State University"
  year: "2019, 2020, 2021, 2022"
  summary: "Maintained GPA above 3.5 for four consecutive years."
```

**Display Format:**
- Award name as heading
- Organization • Year
- Summary paragraph

---

## Associations

**File:** `_data/associations.yml`

```yaml
- organization: "Internet Sociaity"  # Required: Organization name
  active: true                                 # Required: Set to false to hide
  role: "Mentor"                              # Required: Your role/position
  year: "July 2022 &mdash; Present"          # Required: Time period (as display text)
  url: "https://example.com/"         # Optional: Organization URL
  summary:                                     # Required: Description of involvement

# Complete example
- organization: "IEEE Computer Society"
  active: true
  role: "Member"
  year: "2020 &mdash; Present"
  url: "https://www.computer.org/"
  summary: "Active participant in local chapter events and technical workshops."

# Example without URL
- organization: "Local Chamber of Commerce"
  active: true
  role: "Board Member"
  year: "2021 &mdash; 2023"
  url: ""
  summary: "Served on the technology committee, advising on digital transformation initiatives."
```

**Display Format:**
- Organization name as heading (clickable if URL provided)
- Role • Year
- Summary paragraph
- URL shown in parentheses on printed version

---

## Languages

**File:** `_data/languages.yml`

```yaml
- language: English                            # Required: Language name
  active: true                                 # Required: Set to false to hide
  description: "Native proficiency"            # Required: Full proficiency description
  descrp_short: "Native"                       # Required: Short form for header display

# Multiple examples
- language: Arabic
  active: true
  description: "Professional working proficiency"
  descrp_short: "Professional"

- language: Spanish
  active: true
  description: "Limited working proficiency"
  descrp_short: "Limited"

- language: French
  active: false                                # Not currently displayed
  description: "Elementary proficiency"
  descrp_short: "Elementary"
```

**Display Format:**
- Languages section displays in a two-column table
- Each entry shows: Language — Description
- If `lang_header` is enabled in `_config.yml`, languages appear in the page header instead

**Proficiency Levels (suggested):**
- Native / Bilingual
- Professional working proficiency
- Limited working proficiency  
- Elementary proficiency

---

## Links

**File:** `_data/links.yml`

```yaml
- description: "Resume"       # Required: Link description/title
  active: true                                 # Required: Set to false to hide
  url: "https://example.com/"       # Required: URL

# Multiple examples
- description: "Personal Blog"
  active: true
  url: "https://myblog.com"

- description: "Portfolio Website"
  active: true
  url: "https://portfolio.example.com"

- description: "GitHub Profile"
  active: true
  url: "https://github.com/username"

- description: "Old Website"
  active: false                                # This link will not appear
  url: "https://old-site.com"
```

**Display Format:**
- Bulleted list of clickable links
- URL shown in parentheses on printed version

---

## Interests

**File:** `_data/interests.yml`

Simple list of interests/hobbies.

```yaml
- description: "Human rights and world affairs"  # Required: Interest description

- description: "Photography and visual storytelling"

- description: "Hiking and outdoor adventures"

- description: "Playing guitar and songwriting"

- description: "Reading science fiction and philosophy"
```

**Display Format:**
- Simple bulleted list under "Outside Interests" heading
- No active/inactive toggle - if it's in the file, it shows

---

## General Guidelines

### Date Formats

**For startdate/enddate fields:**
- Always use ISO format: `YYYY-MM-DD` (e.g., `2024-03-15`)
- These auto-format to "Mon YYYY" in English (e.g., "Mar 2024")
- Arabic layout uses custom date formatting

**For display text fields (year, duration):**
- Use any text format you want
- Use `&mdash;` for em dash (—)
- Use `&amp;` for ampersand (&)
- HTML entities needed because YAML interprets special characters

### Active Flag

Nearly all entries have an `active: true/false` field:
- `true` = entry appears on resume
- `false` = entry hidden but kept in your records

### Optional vs Required

- **Required** fields must have a value (can be empty string `""` for optional-marked fields)
- **Optional** fields can be omitted or left empty
- If a required field is empty, that section may not render correctly

### Special Characters in YAML

```yaml
# Use quotes for strings with special characters
name: "Bachelor's Degree: Computer Science"

# HTML entities for display text
duration: "2020 &mdash; 2023"              # em dash
organization: "Smith &amp; Associates"      # ampersand

# URLs don't need quotes (unless they contain special YAML characters)
url: https://example.com
```

### File Location

All data files go in the `_data/` directory or a subdirectory based on the `_config.yml`:
```
_data/
├── experience.yml
├── education.yml
├── certifications.yml
├── courses.yml
├── volunteering.yml
├── projects.yml
├── skills.yml
├── recognitions.yml
├── associations.yml
├── languages.yml
├── links.yml
└── interests.yml
```

### Enabling Sections in _config.yml

To control which sections appear on your resume, edit `_config.yml`:

```yaml
resume_section:
  experience: true
  education: true
  certifications: true
  courses: true
  volunteering: true
  projects: true
  skills: true
  recognition: true
  associations: true
  interests: true
  languages: true
  links: true
  lang_header: false  # If true, languages show in header instead of separate section

resume_section_order:
  - experience
  - education
  - certifications
  - skills
  - projects
  - volunteering
  - recognition
  - associations
  - languages
  - links
  - interests

```
