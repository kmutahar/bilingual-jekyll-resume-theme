# Localized JSON Resume export

The theme generates one JSON Resume document per configured language at
`/<lang>/resume.json`. It also generates `/resume.json` from the default language.
These are static build outputs, prefixed by `baseurl` when served. Existing YAML
keys and HTML layouts continue working without migration.

## Configuration

Exports are enabled by default. Add this optional block to `_config.yml`:

```yaml
json_resume:
  enabled: true
  root_export: true
  languages: [] # Missing or empty means every key in site.languages
  privacy:
    export_contact_info: true

# Optional usernames; existing social_links values remain URL strings.
social_usernames:
  github: octocat
```

Set `enabled: false` to disable all exports, or `root_export: false` to disable
only the root copy. A nonempty `languages` list is an allowlist; unknown languages
are warned about and ignored. A malformed non-array allowlist skips generation.
Language codes may contain letters, digits, and internal hyphens or underscores;
route separators and traversal characters are rejected.

The root copy is generated only if the default language is allowed and its
localized export succeeds. A collision with an authored page, static file,
collection document, or existing generated page preserves that resource and logs
a warning. A collision at the localized route also suppresses its root copy.
A root-only collision does not suppress the localized export.

CV pages advertise only successfully generated localized exports:

```html
<link rel="alternate" type="application/json" href="/en/resume.json" hreflang="en">
```

The exporter records successful routes for the shared head include. Profile and
error pages do not advertise exports. Jekyll emits `.json` files; the web host
must serve them with `Content-Type: application/json`. This plugin cannot set
HTTP headers on a static host.

## Visibility and privacy

- Data comes from `languages.<lang>.data_path`, including nested dot paths and an
  empty path for root data.
- Sections must be enabled and present in `resume_section_order`. Entries require
  exactly `active: true`, except interests, whose HTML list has no active filter.
- Header languages follow `display_header_contact_info` and `resume_section.lang_header`.
  Section languages follow the existing section-placement rules.
- The biography is `header.intro` only when `header_intro: true`; profile `about`
  content is not used as a fallback. Work and volunteer summaries require
  `enable_summary: true`. The avatar requires `resume_avatar: true` and uses the
  same default image as the CV.
- Email is exported when the contact bar or contact-me CTA is visible. Phone and
  location are exported only when the contact bar is visible. `enable_live: true`
  selects each live contact value independently, falling back to its base value
  when the live key is absent or false.
- `export_contact_info: false` omits email, phone, the entire location object, and
  WhatsApp profiles. `social_links.email` is never exported as a social profile.
  This setting does not redact free-form narrative text, usernames, or arbitrary
  URLs, and it does not change the HTML site's contact visibility.
- Documented optional enrichment fields can appear in JSON even if HTML does not
  display those fields. The export is a supported subset of the CV, not a lossless
  representation of every website field.

## Field mappings

All field names below on the left are existing YAML names or optional additions;
camelCase names on the right belong only to the JSON output.

| Source | JSON Resume target |
|---|---|
| `languages.<lang>.name`, `resume_title` | `basics.name`, `basics.label` |
| `avatar_url` or theme fallback | `basics.image` |
| Selected `contact_info.email`, `phone` | `basics.email`, `basics.phone` |
| Actual CV page URL, falling back to `languages.<lang>.url` | `basics.url`, `meta.canonical` |
| `header.intro` | `basics.summary` |
| Per-language `address`, `postal_code`, `city`, `country_code`, `region` | `basics.location.address`, `postalCode`, `city`, `countryCode`, `region` |
| Supported `social_links.<network>` and `social_usernames.<network>` | `basics.profiles[].network`, `url`, `username` |
| `experience.company`, `position`, `location`, `summary`, `url`, `highlights` | `work[].name`, `position`, `location`, `summary`, `url`, `highlights` |
| `volunteering.company`, `position`, `summary`, `url`, `highlights` | `volunteer[].organization`, `position`, `summary`, `url`, `highlights` |
| `education.uni`, `degree` (fallback `study_type`), `area`, `score` (fallback `gpa`), `courses`, `url` | `education[].institution`, `studyType`, `area`, `score`, `courses`, `url` |
| Work, volunteer, education, project `startdate`, `enddate` | Corresponding `startDate`, `endDate` |
| `certifications.name`, `issuing_organization`, `issue_date`, `credential_url` | `certificates[].name`, `issuer`, `date`, `url` |
| `recognitions.award` (fallback `title`, `recognition`), `organization`, `summary`, `date` | `awards[].title`, `awarder`, `summary`, `date` |
| Four-digit recognition `year`, when `date` is absent | `awards[].date` |
| `skills.skill`, `level_label`, `keywords` | `skills[].name`, `level`, `keywords` |
| `languages.language`, displayed `descrp_short` (header) or `description` (section) | `languages[].language`, `fluency` |
| `interests.name` (fallback `description`), `keywords` | `interests[].name`, `keywords` |
| `projects.project`, `description`, `url`, `highlights`, `keywords` | `projects[].name`, `description`, `url`, `highlights`, `keywords` |
| Project `roles`, or scalar `role` wrapped in an array | `projects[].roles` |

Experience and volunteering remain one record per role; company groups and
newest-first role ordering follow the HTML renderer. Supported social networks
are the ones rendered by the existing social include: GitHub, LinkedIn,
Telegram, Twitter, Medium, Dribbble, Facebook, Instagram, Website, WhatsApp,
Dev.to, Flickr, Pinterest, and YouTube. Their configured keys identify networks
in the export. Social URLs remain strings; nested `{url, username}` objects are
not introduced by this feature.

## Optional enrichment

Existing data does not need to change. For richer exports, add:

- Experience and volunteering: `url` and `highlights` (array of strings).
- Education: `area`, `study_type`, `score`, `url`, `courses` (array of strings).
  Existing `startdate` and `enddate` are supported; display-oriented `year` remains.
- Projects: `startdate`, `enddate`, `roles`, `highlights`, `keywords`. The last three
  are arrays of strings; existing scalar `role` works without `roles`.
- Recognitions: an ISO `date`, independently of the display-oriented `year`.
- Skills: textual `level_label` and an array of `keywords`. Numeric `level` retains
  its existing 1–5 meaning and is not converted to an invented proficiency label.
- Interests: `keywords` as an array of strings.
- Per-language config: `postal_code`, `city`, `country_code`, `region`.

Use `startdate`/`enddate` consistently. No `start_date`/`end_date` aliases are added.
The source validator checks added list fields, skill labels, project dates,
recognition dates, and relevant URLs; the exporter also validates output formats.

```yaml
# A skills.yml entry; translate content in each language's data folder.
- skill: Web development
  active: true
  level: 4
  level_label: Advanced
  keywords:
    - Ruby
    - Jekyll
```

## Dates, text, and URLs

Dates must be real calendar dates in `YYYY`, `YYYY-MM`, or `YYYY-MM-DD` form.
**Certificate `issue_date` is the exception:** the pinned schema requires a full
`YYYY-MM-DD`. A partial certificate date remains valid website data but is
omitted from JSON with a warning; the exporter never guesses a month or day.

Blank end dates, `Present` (case-insensitive), and the effective locale's
`present_values` omit `endDate` silently. Free-form `duration`, `durations`, and
education `year` are not parsed into dates. Date of birth is not exported.

Raw HTML tags are removed, block boundaries preserved as newlines, and HTML
entities decoded to Unicode. Markdown and native multilingual characters remain.
Liquid-like text is serialized literally; generated JSON bypasses Liquid and
layouts during Jekyll rendering.

Links must resolve to absolute HTTP(S) URLs. Local paths use `site.url` and
`site.baseurl`; without `site.url`, relative links are omitted with a warning.
Social profile URLs must already be absolute. Invalid email addresses, country
codes, dates, and URLs are omitted with contextual warnings that do not print
field values. Empty fields, arrays, objects, and sections are omitted.

## Standard and omissions

Validation uses the vendored [JSON Resume 1.0.0 schema](https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json)
(Draft 4) through `json_schemer`. Builds perform no schema downloads. `$schema`
points to this pinned version; `meta.version` is `1.0.0`, and `meta.lastModified`
is the build timestamp in UTC. If final schema validation unexpectedly fails,
the document is skipped and no discovery link is emitted.

Associations, standalone courses, generic links, date of birth, skill narrative
descriptions, education honors/summaries, certificate IDs/expiration, and
free-form display date ranges have no mapping in this exporter. No publications
or references are manufactured from other sections. Nested certificate courses
remain internal data and are not exported.

## Verification

Run the normal demo build and `bundle exec rake`. Export coverage includes
visibility, live contacts, privacy, locale characters, schema validation,
collisions, literal Liquid content, and discovery-link cleanup on rebuild.
Generated JSON can be downloaded directly or imported into JSON Resume tooling;
compatibility with every third-party renderer is not guaranteed by schema validity.
