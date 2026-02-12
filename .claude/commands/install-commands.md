---
description: Install duet commands to ~/.claude/commands for user-wide availability
allowed-tools: [Bash, Read, Glob, AskUserQuestion]
---

# Install Commands

## Context

- Duet commands: !`find commands -name '*.md' | sort`
- User commands: !`find ~/.claude/commands -name '*.md' 2>/dev/null | sort || echo "(none)"`

## Your Task

Install commands from duet to ~/.claude/commands/ for user-wide availability.

1. **Inventory all commands:**
   - Enumerate every `.md` file under `commands/`, including subdirectories
   - Compare each with its counterpart under `~/.claude/commands/` using `diff -q`
   - Categorize: **new**, **modified**, or **unchanged**
   - Present a summary table

2. **Select which to install:**
   - Skip unchanged commands
   - For modified commands, show the diff
   - Ask the user which new/modified commands they want to install
   - If nothing is new or modified, report "Everything up to date" and stop

3. **Install selected commands:**
   - Create subdirectories as needed
   - Copy only the user's selections
   - Do not delete files from ~/.claude/commands/ that don't exist in duet

4. **Verify installation:**
   - Confirm each installed file exists and is non-empty
   - Report pass/fail count
