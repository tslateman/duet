---
description: Install duet statusline to ~/.claude for a lean, informative status bar
allowed-tools: [Bash, Read, Glob, AskUserQuestion]
---

# Install Statusline

## Context

- Duet statusline script: !`cat statusline/statusline-command.sh`
- Current user statusline config: !`jq -r '.statusLine // empty' ~/.claude/settings.json 2>/dev/null || echo "(none)"`
- Current user statusline script: !`cat ~/.claude/statusline-command.sh 2>/dev/null || echo "(none)"`

## Your Task

Install the duet statusline script to `~/.claude/` and configure it in `~/.claude/settings.json`.

1. **Check current state:**
   - Does `~/.claude/settings.json` already have a `statusLine` field?
   - Does `~/.claude/statusline-command.sh` already exist?
   - Categorize: **no existing statusline**, **identical**, or **different**

2. **If identical:** Report "Statusline already up to date" and stop.

3. **If different or new:**
   - If a statusline script already exists, show the diff between duet's version and the existing one
   - Ask the user whether to install (replace) or skip
   - Make clear this will overwrite their current statusline

4. **Install:**
   - Copy `statusline/statusline-command.sh` to `~/.claude/statusline-command.sh`
   - Make it executable: `chmod +x ~/.claude/statusline-command.sh`
   - If `~/.claude/settings.json` lacks a `statusLine` field, add it:
     ```json
     "statusLine": {
       "type": "command",
       "command": "bash ~/.claude/statusline-command.sh"
     }
     ```
   - Use `jq` to merge the statusLine field without disturbing other settings

5. **Verify:**
   - Confirm the script exists and is executable
   - Confirm `settings.json` has the `statusLine` field
   - Report success — note that the statusline will appear on next Claude Code session start
