# Vamp

Where we are while figuring out where to go.

---

## Current State

- prose skill self-contained with Strunk's Elements of Style
- two-tier command structure:
  - `commands/` — globally installable via `/install-commands`
  - `.claude/commands/` — duet-only (install-commands, install-skills)
- install-* commands show diff and confirm before overwriting
- whats-next moved here from tutor (duet is command source of truth)

## Decided

- "install" not "sync" — honest about one-way push, no bidirectional sync
- show diff before overwrite — careful by default
- accepted the ~/.claude/ install pattern over plugin installation

## Open Thread

**idea**: What if vamp.md checked alignment before major pushes—not just project state, but vision?

---

- pre-push hook reminds to update vamp.md (local only, not tracked)
