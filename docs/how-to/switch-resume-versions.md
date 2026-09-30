# Switch resume versions

*Audience: site owners*

Load a different set of resume data (for example a dated or role-specific version) for a language, without touching the data you already have.

## Steps

1. Put each version in its own folder under `_data/`, holding the same files as any language folder (`header.yml`, `experience.yml`, and the rest). For example:
   ```text
   _data/
     en/          # your everyday English data
     2025-06/
       PM/        # a June 2025 product-management version
       Eng/       # an engineering version
   ```
   Folder names can contain hyphens and digits. They cannot contain a dot, because a dot separates the levels of the path in the next step.
2. Point the language's `data_path` at the folder in `_config.yml`, separating nested folders with dots:
   ```yaml
   languages:
     en:
       data_path: "2025-06.PM"    # reads _data/2025-06/PM/*.yml
   ```
   Only that language changes. Every other language keeps its own `data_path`.
3. Stop the server and run `bundle exec jekyll serve` again. Changes to `_config.yml` are not picked up while the server is running.
4. Validate the data: `bundle exec validate-resume _data`. It should print `VALIDATION SUCCESSFUL`.
5. Open the language's CV page (for example `/en/cv/`) and confirm it shows the content of the version you chose.

To go back, set `data_path` to the original folder and restart.

## If it does not work

- **`Data directory '.../_data/2025-06/NOPE' for language 'en' does not exist.`** The path has a typo or the folder is missing. Check each segment of the path against the folder names.
- **The page still shows the old content.** You did not restart after editing `_config.yml`.
- **The validator reports a file that exists for one language but not another.** Every language's data folder should hold the same files, so copy the missing file into the version folder.

## Variations

- `data_path: ""` reads the files placed directly in `_data/`.
- To use a different version for each language, give each language its own `data_path`.

How the path is resolved is described in [Dynamic Data Resolution](../reference/layouts.md#dynamic-data-resolution).
