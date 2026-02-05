# CLAUDE.md - Duet Repository Guidelines

Slash commands for Claude Code. Markdown only—no build system.

## Build/Lint/Test

```bash
markdownlint commands/**/*.md
```

## Markdown Command Files

### Frontmatter (Required)

```yaml
---
description: Brief one-line description of what this command does
allowed-tools: [Bash, Read, Glob, Grep]  # Optional: restrict tools
---
```

- `description`: Required. Used for command discovery
- `allowed-tools`: Optional. Omit to allow all tools
- Use patterns like `Bash(git add:*)` to restrict specific commands

### Content Structure

```markdown
## Context
- Current status: !`git status`
- Current branch: !`git branch --show-current`

## Your Task
1. Step one
2. Step two
```

### Inline Execution Syntax

- `!`backtick`git status`backtick - Executes command and injects output
- `${ARGUMENTS:-default}` - Accesses command arguments

### Formatting Rules

- ATX-style headers (`##` not underlines)
- Fence code blocks with language identifiers
- Numbered lists for sequential steps, bullets for unordered
- One blank line between sections
- No trailing whitespace

## Shell Scripts

If adding shell scripts:

```bash
#!/bin/bash
set -euo pipefail

# script-name - Brief description
# Usage: script-name [arguments]
```

Quote variables (`"$var"`), use `[[` for conditionals, prefer `$(command)` over backticks.

## Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Command files | `kebab-case.md` | `commit-push-pr.md` |
| Directories | `kebab-case/` | `commit-commands/` |

## Creating New Commands

1. Place in appropriate directory under `commands/`
2. Include frontmatter with description
3. Test the command manually before committing

## Git Workflow

- **Commit messages**: Imperative mood ("Add feature" not "Added feature"), 50 chars max
- **Branch naming**: `feature/description` or `fix/description`

## Session Habits

After significant work, update `notes/vamp.md` with current state.
