---
description: Capture learnings to MEMORY.md, output compact summary
allowed-tools: [Read, Edit, Write]
---

<!--
Memory files hold lessons. CLAUDE.md holds instructions.

| MEMORY.md                                    | CLAUDE.md                                    |
| -------------------------------------------- | -------------------------------------------- |
| "We learned X breaks"                        | "Use Y instead of X"                         |
| Gotchas, patterns, open threads              | Architecture, commands, conventions           |
| Never: architecture, file layouts, CLI docs  | Never: session history, resolved items        |
-->

Reflect on the work just completed, then persist learnings for future sessions.

## Step 1: Reflect

Identify 2-4 concrete technical insights:

- Patterns discovered or reinforced
- Gotchas or surprises encountered
- Techniques that worked well (or didn't)

Focus on _insights_, not actions taken. Be specific -- name files, functions, concepts.

## Step 2: Dedup Guard

Read the project's CLAUDE.md (if it exists). For each insight from Step 1, check
whether CLAUDE.md already covers it. If so, drop it and note "already in
CLAUDE.md" in the Step 4 output. Memory captures lessons CLAUDE.md does not.

## Step 3: Write to Memory

Read the existing MEMORY.md in the project's memory directory. Find the right
section for each insight. Add to an existing section when one fits. Create a new
section only when no existing section applies.

Format for entries:

```markdown
## [Topic Name]

- **[Bold insight]**: explanation with specific file/function references
```

If MEMORY.md doesn't exist, create it with a `# [Project] Project Memory`
header first.

Keep entries concise -- this file loads into every session's context.

### Routing check

If an insight references a different project by name (e.g., mentions "duet"
while working in "lore"), note it in the Step 4 output: "Consider: this insight
may belong in [other project]'s memory, not [current project]'s."

### Size check

After writing, count lines in MEMORY.md. If over 50 lines, warn: "MEMORY.md is
[N] lines. Consider running /memory-audit to identify content that can be pruned
or moved."

## Step 4: Output Summary

After writing to memory, output ONLY:

```
Captured to MEMORY.md:
- [1-line summary of each insight]

Skipped (already in CLAUDE.md):
- [1-line summary, if any]

Routing notes:
- [cross-project notes, if any]
```

Omit the Skipped or Routing sections if empty. Do not output the full
reflection -- it's in MEMORY.md now.
