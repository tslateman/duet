# Session Context

## User Prompts

### Prompt 1

who did elton john sing duets with?

### Prompt 2

is AI a tool for the team, or is the team a tool for AI?

### Prompt 3

what should I work on next

### Prompt 4

Analyze this project and suggest what to work on next.

1. Review the current structure (README.md, directories, files)
2. Identify gaps or opportunities in these categories:
   - **Content** — Missing topics, incomplete guides
   - **Tooling** — CI/CD, automation, developer experience
   - **Polish** — Cross-references, consistency, organization

3. Present 2-3 concrete suggestions per category, briefly explained

Keep suggestions actionable and relevant to the project's purpose.

### Prompt 5

fix the README truncation

### Prompt 6

## Context

- Current git status: On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   .gitignore
	modified:   README.md
	modified:   scripts/generate-readme.sh

no changes added to commit (use "git add" and/or "git commit -a")
- Current git diff (staged and unstaged changes): diff --git a/.gitignore b/.gitignore...

### Prompt 7

reset the commit! we should run the prettier formatter on the README before committing it. just the readme, not all md

### Prompt 8

can we add this as a git hook rule?

### Prompt 9

local hook is fine

### Prompt 10

## Context

- Current git status: On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   .gitignore
	modified:   README.md
	modified:   scripts/generate-readme.sh

no changes added to commit (use "git add" and/or "git commit -a")
- Current git diff (staged and unstaged changes): diff --git a/.gitignore b/.gitignore...

### Prompt 11

interesting... i resumed "elton" but now i see kiki?

### Prompt 12

i see a concerning pattern...

❯ interesting... i resumed "elton" but now i see kiki?
  ⎿  [Image #1]

⏺ You renamed this session to "kiki" with /rename kiki earlier (after the Elton John duet partners question). The rename stuck — so when you resumed,
  it loaded this same session under its renamed label.

❯ /exit
  ⎿  Catch you later!

─────────────────────────────────────────────────...

### Prompt 13

it's a bug

### Prompt 14

yep

### Prompt 15

yes

### Prompt 16

hey... we probably should NOT file issues in this way - we ought to check guidelines first

### Prompt 17

record to lore

### Prompt 18

copy pasting claude output leaves weird line breaks:

    The curation gap. Capture writes freely, recall reads freely, review resolves one decision at a time. But nothing decides what's worth
  surfacing.
    Resume dumps the last 10 decisions and matching patterns — no ranking, no relevance beyond tag matching. The system remembers everything but
  curates
     nothing. What would a lore recall that prioritized look like? Not just "find matches" but "surface what matters right now."


better...

### Prompt 19

does iterm have anything similar?

