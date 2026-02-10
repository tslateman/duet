---
description: Install duet commands to ~/.claude/commands for user-wide availability
allowed-tools: [Bash, Read, Glob, AskUserQuestion]
---

# Install Commands

## Context

- Duet commands: !`ls -1 commands/*.md 2>/dev/null | xargs -n1 basename`
- User commands: !`ls -1 ~/.claude/commands/ 2>/dev/null || echo "(none)"`

## Your Task

Install commands from duet to ~/.claude/commands/ for user-wide availability.

1. **Identify changes:**
   - New: files in duet but not in ~/.claude/commands/
   - Modified: files that exist in both but differ
   - Unchanged: files that match

2. **For modified files, show the diff:**
   - Use `diff -u ~/.claude/commands/FILE commands/FILE` to show what will change
   - Summarize: what's being added, removed, or changed

3. **Ask before overwriting:**
   - If there are new or modified files, use AskUserQuestion to confirm
   - Show the list of files that will be installed/updated
   - Proceed only if user confirms

4. **Install confirmed files:**
   - Copy new and modified files to ~/.claude/commands/
   - Report what was installed

Do not delete files from ~/.claude/commands/ that don't exist in duet.

5. **Verify installation:**
   - For each file installed in step 4, confirm it exists in ~/.claude/commands/ and is non-empty
   - Report a pass/fail count (e.g., "3/3 commands verified")
