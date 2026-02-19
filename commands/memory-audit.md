---
description: Audit project memory files for staleness, orphans, bloat, and duplication
allowed-tools: [Bash, Read, Glob, Grep]
---

Audit all project memory files for health issues.

## Step 1: Discover Memory Files

Find all MEMORY.md files:
!`find ~/.claude/projects/*/memory -name MEMORY.md 2>/dev/null`

## Step 2: Check Each File

For each MEMORY.md found, run these checks:

### Orphan Detection

Extract the project path from the memory directory name (e.g., `-Users-tslater-dev-council` maps to `/Users/tslater/dev/council`). Check if the project directory exists. Report orphans -- memory files for projects that have been moved, renamed, or deleted.

### Size Check

Count lines and estimate tokens (~1.5 tokens/word). Flag files over 50 lines or ~2,000 tokens. These load into every session for that project and consume context.

### Ghost Names

Search each memory file for archived or renamed project names:

- "Lineage" (renamed to Lore)
- "Oracle" (absorbed into Lore)
- "Ralph" (archived)
- "Monarch" (renamed to Lore)
- "Flow" (absorbed into Neo) -- exclude "Data Flow"

Report line numbers.

### Stale Markers

Search for items that sound completed:

- Lines containing "resolved", "fixed", "done", "completed" (case-insensitive)
- Date references older than 30 days (pattern: `2026-01` or earlier)
- Lines starting with `~~` (strikethrough, indicating resolved items)

### CLAUDE.md Overlap

If the project has a CLAUDE.md, compare section headers. Flag memory sections whose headers also appear in CLAUDE.md (e.g., both files have "## Architecture"). This suggests content that belongs in CLAUDE.md, not MEMORY.md.

## Step 3: Report

Output a summary table:

```
| Project | Lines | Issues |
|---------|-------|--------|
| council | 56    | clean  |
| lore    | 48    | 2 stale markers |
```

Then list specific issues grouped by type:

```
ORPHANS (memory for deleted/moved projects):
  (none)

SIZE (over 50 lines):
  lore: 140 lines (~4k tokens)

GHOST NAMES:
  geordi: "Lineage" on lines 7, 8

STALE MARKERS:
  lore: "Fixed" on line 49, "Resolved" on line 108

CLAUDE.MD OVERLAP:
  geordi: "Architecture" header in both files
```

End with a one-line count: "X files audited, Y issues found across Z files."
