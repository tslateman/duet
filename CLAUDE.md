# Duet

Claude Code plugin for git workflows, reflection, code quality, and writing. Markdown only — no build system.

## Lint

```bash
markdownlint commands/**/*.md
```

## Project Structure

```
commands/
  commit-commands/     commit, commit-push-pr, clean-gone
  adr.md               Architecture Decision Records
  debrief.md           Review agent work, surface loose ends
  retro.md             Session retrospective
  whats-next.md        Suggest next actions
  why.md               Annotate commits with rationale
  think-next.md        Philosophy × engineering questions
skills/
  frontend-design/     Production-grade UI generation
  prose/               Strunk's Elements of Style for all writing
  research/            Systematic technical investigation
  review/              Structured code review with context capture
agents/
  code-simplifier.md   Refine code for clarity and maintainability
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

## Naming Conventions

| Element       | Convention      | Example             |
| ------------- | --------------- | ------------------- |
| Command files | `kebab-case.md` | `commit-push-pr.md` |
| Directories   | `kebab-case/`   | `commit-commands/`  |
