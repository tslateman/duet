# Duet

Claude Code plugin for reflection, code quality, and writing. Markdown only — no build system.

## Lint

```bash
markdownlint commands/**/*.md
```

## Project Structure

```
commands/
  debrief.md           Review agent work, surface loose ends
  question.md          Surface pointed questions about recent changes
  retro.md             Session retrospective
  whats-next.md        Suggest next actions
  note-why.md          Note the rationale behind a commit
  ponder.md            Surface a question worth sitting with
skills/
  adr/                 Architecture Decision Records
  diagnose/            Systematic debugging (Agans + Zeller)
  design/              Intentional design (visual, API, system)
  naming/              Naming as design diagnostic (Benner + Bloch)
  prose/               Strunk's Elements of Style for all writing
  research/            Systematic technical investigation
  review/              Structured code review with context capture
  testing/             Test strategy (Beck's Test Desiderata)
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

## Hooks

A git pre-push hook checks whether `notes/vamp.md` was modified in the commits being pushed. If not, it prompts for confirmation before allowing the push. Use `git push --no-verify` to skip.

## Naming Conventions

| Element       | Convention      | Example         |
| ------------- | --------------- | --------------- |
| Command files | `kebab-case.md` | `whats-next.md` |
| Directories   | `kebab-case/`   | `testing/`      |
