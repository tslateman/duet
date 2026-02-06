# Vamp

Where we are while figuring out where to go.

---

## Current State

- prose skill now self-contained with Strunk's Elements of Style (public domain)
- eliminated superpowers-marketplace dependency (~800ms git clone per startup)
- `/sync-skills` command syncs duet skills to ~/.claude/skills/ for global use
- duet not loading as plugin (only code-review scoped here) - commands live in ~/.claude/commands/

## Next

- consider proper plugin installation for duet
- or accept the ~/.claude/commands/ + /sync-skills pattern

---

- pre-push hook reminds to update vamp.md (local only, not tracked)
