# Add a custom section

*Audience: site owners and theme developers*

Add a new resume section (`publications` in this example) that renders in every language.

## Steps

1. **Add the heading to every locale.** Add `ui.section_titles.publications` to each `_data/locales/<lang>.yml` you ship (in a consuming site, add it through site locale overrides; nested keys merge, so a one-key file per language is enough).
2. **Add one branch** to `_includes/resume-section.html` (in a consuming site, first copy the theme's file to your own `_includes/resume-section.html`), just before the final `{% endif %}`. It serves every language:
   ```liquid
   {% elsif include.section_name == "publications" and site.resume_section.publications %}
     <section class="content-section">
       <header class="section-header">
         <h2>{{ locale.ui.section_titles.publications }}</h2>
       </header>
       {% for item in resume_data.publications %}
         {% if item.active == true %}
           <div class="resume-item">
             <h3 class="resume-item-title">{{ item.title }}</h3>
             <p class="resume-item-details">{{ item.publisher }} &bull; {{ item.year }}</p>
           </div>
         {% endif %}
       {% endfor %}
     </section>
   ```
3. **Add data** as `publications.yml` in every language folder. Each file must be a list of items, each with an `active` flag; the validator checks only that shape for custom sections.
4. **Enable it:** `resume_section.publications: true` and `- publications` in `resume_section_order`.

## See also

- [Show language proficiency in the header](show-language-proficiency-in-header.md)
- [Includes reference](../reference/includes.md)
- [Data schemas](../reference/data-schemas.md)
- [Config reference](../reference/config.md)
