---
description: Install duet skills to ~/.claude/skills for user-wide availability
allowed-tools: [Bash, Read, Glob, AskUserQuestion]
---

# Install Skills

## Context

- Duet skills: !`ls -1 skills/`
- User skills: !`ls -1 ~/.claude/skills/ 2>/dev/null || echo "(none)"`

## Your Task

Install skills from duet to ~/.claude/skills/ for user-wide availability.

1. **Inventory all skills:**
   - Compare each skill directory with its counterpart under `~/.claude/skills/` using `diff -rq`
   - Categorize: **new**, **modified**, or **unchanged**
   - Present a summary table

2. **Select which to install:**
   - Skip unchanged skills
   - For modified skills, show the diff
   - Ask the user which new/modified skills they want to install
   - If nothing is new or modified, report "Everything up to date" and stop

3. **Install selected skills:**
   - Copy only the user's selections to `~/.claude/skills/`
   - Do not delete skills from ~/.claude/skills/ that don't exist in duet

4. **Verify installation:**
   - Confirm each installed skill directory exists with non-empty files
   - Report pass/fail count
