# Duet

Claude Code plugin for reflection, code quality, writing, and design. Markdown only — no build system.

## Lint

```bash
markdownlint commands/**/*.md skills/**/SKILL.md
```

## Project Structure

```
commands/
  debrief.md           Review agent work, surface loose ends
  lint.md              Run markdownlint on files
  question.md          Surface pointed questions about recent changes
  retro.md             Session retrospective
  sweep.md             Post-op check for artifacts, damage, stale refs
  whats-next.md        Suggest next actions
  note-why.md          Note the rationale behind a commit
  ponder.md            Surface a question worth sitting with
skills/
  FRAMEWORKS.md        Framework-to-skill index
  adr/                 Architecture Decision Records (Nygard)
  design/              Intentional design (visual, API, system)
  diagnose/            Systematic debugging (Agans)
  ia/                  Information architecture (Rosenfeld + Diataxis)
  naming/              Naming as design diagnostic (Benner + Bloch)
  performance/         Profiling and optimization (Knuth)
  prose/               Strunk's Elements of Style for all writing
  research/            Systematic technical investigation
  review/              Structured code review with context capture
  testing/             Test strategy (Beck's Test Desiderata)
agents/
  code-simplifier.md   Refine code for clarity and maintainability
statusline/
  statusline-command.sh  Lean status bar (dir, git, model, context, vim)
scripts/
  generate-readme.sh   Auto-generate README tables from source
  sync-version.sh      Sync plugin.json version with git tags
```

## Command Authoring

### Frontmatter (Required)

```yaml
---
description: Brief one-line description of what this command does
allowed-tools: [Bash, Read, Glob, Grep] # Optional: restrict tools
---
```

- `description`: Required. Used for command discovery
- `allowed-tools`: Optional. Omit to allow all tools
- Use patterns like `Bash(git add:*)` to restrict specific commands

### Inline Execution

- `` !`git status` `` — Executes command and injects output
- `${ARGUMENTS:-default}` — Accesses command arguments

### Formatting Rules

- ATX-style headers (`##` not underlines)
- Fence code blocks with language identifiers
- Numbered lists for sequential steps, bullets for unordered
- No trailing whitespace

## Hooks

A git pre-push hook checks whether `notes/vamp.md` was modified in the commits being pushed. If not, it prompts for confirmation before allowing the push. Use `git push --no-verify` to skip.

## Naming Conventions

| Element       | Convention      | Example         |
| ------------- | --------------- | --------------- |
| Command files | `kebab-case.md` | `whats-next.md` |
| Directories   | `kebab-case/`   | `testing/`      |
