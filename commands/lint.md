---
description: Run markdownlint on specified files or the whole project
allowed-tools: [Bash, Read, Glob]
---

# Lint

## Context

- Markdownlint config: !`cat .markdownlint.json`

## Your Task

Run markdownlint on the target files and report results.

### Arguments

`${ARGUMENTS:-}` — Three usage patterns:

1. **No arguments** — Lint all markdown files in the project
2. **File path(s)** — Lint specific files
3. **Directory** — Lint all `.md` files in that directory

### Workflow

1. **Determine targets:**
   - If arguments provided, use them
   - Otherwise, lint `commands/**/*.md` and `skills/**/*.md`

2. **Run markdownlint:**

   ```bash
   npx markdownlint-cli [targets]
   ```

3. **Report results:**
   - If clean, report "No lint issues found"
   - If violations found, group by file and list each issue
   - For fixable issues, suggest `npx markdownlint-cli --fix [file]`
