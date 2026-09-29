# Link translations with hreflang

*Audience: site owners*

Make the language switcher and the `hreflang` tags connect the translations of a page.

Give every translation of a page the same `t_id`:

```yaml
---
layout: resume
lang: en
permalink: /en/cv/
t_id: resume
---
```

```yaml
---
layout: resume
lang: ar
permalink: /ar/cv/
t_id: resume
---
```
