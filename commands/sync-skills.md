---
description: Sync duet skills to ~/.claude/skills for global availability
allowed-tools: [Bash, Read, Glob]
---

# Sync Skills

## Context

- Duet skills: !`ls -1 skills/`
- User skills: !`ls -1 ~/.claude/skills/`

## Your Task

Sync skills from this repo to ~/.claude/skills/ so they're available globally.

1. For each skill directory in `skills/`:
   - Check if it exists in `~/.claude/skills/`
   - Compare files and report differences
   - Copy any missing or updated files

2. Report what was synced:
   - New skills added
   - Files updated
   - Already in sync

Use `rsync -av --itemize-changes` for clear reporting, or manual comparison if rsync unavailable.

Do not delete files from ~/.claude/skills/ that don't exist in duet.
