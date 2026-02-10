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

1. **Identify changes:**
   - New: skill directories in duet but not in ~/.claude/skills/
   - Modified: skills that exist in both but have different files
   - Unchanged: skills that match

2. **For modified skills, show the diff:**
   - Use `diff -ru ~/.claude/skills/SKILL skills/SKILL` to show what will change
   - Summarize: what's being added, removed, or changed

3. **Ask before overwriting:**
   - If there are new or modified skills, use AskUserQuestion to confirm
   - Show the list of skills that will be installed/updated
   - Proceed only if user confirms

4. **Install confirmed skills:**
   - Copy new and modified skill directories to ~/.claude/skills/
   - Report what was installed

Do not delete skills from ~/.claude/skills/ that don't exist in duet.

5. **Verify installation:**
   - For each skill installed in step 4, confirm its directory exists in ~/.claude/skills/ and contains non-empty files
   - Report a pass/fail count (e.g., "2/2 skills verified")
