# Vamp

Where we are while figuring out where to go.

---

## Current State

- 10 commands, 13 skills, 1 agent — markdown only, no build system
- commands: capture-memory, debrief, lint, memory-audit, note-why, ponder, question, retro, sweep, whats-next
- skills: adr, design, diagnose, excalidraw, ia, mermaid, naming, performance, prose, research, review, sharpen, testing
- FRAMEWORKS.md indexes 13 framework-to-skill mappings
- plugin namespace (`duet:`) provides skills directly — no install step needed
- `.claude/commands/` — duet-only (install-statusline)
- skills use frontmatter for auto-triggering (adr led, others followed)
- CLAUDE.md trimmed to essentials: project structure, lint, command authoring, naming
- prose skill self-contained with full Elements of Style reference
- conservative permissions: deny destructive ops, ask before push/rebase
- `/retro` includes memory health check — scans MEMORY.md for staleness before persistence prompt
- version 0.1.1

## Decided

- ~~"install" not "sync"~~ — removed. Plugin namespace (`duet:`) eliminates the need for install commands; they created duplicates in `~/.claude/skills/`
- ~~accepted the ~/.claude/ install pattern~~ — reversed. Plugin skills use namespaced access (`duet:research`), not standalone copies
- CLAUDE.md stays lean — project structure and authoring rules, not aspirational content
- `/why` → `/note-why` — name the action, not the content; avoid ask/tell ambiguity
- `/think-next` → `/ponder` — name what you do, not what comes next
- `/adr` moved from command to skill — it's a document framework, not a discrete action
- `/whats-next` kept — pressure-tested, earns its name (Taskwarrior precedent)
- skills expand by domain — each grounded in a specific framework or author
- SKILL.md with frontmatter as the standard skill file convention
- `/ia` grounded in Rosenfeld/Morville + Diataxis — includes taxonomy construction heuristics
- `/mermaid` + `/excalidraw` split: mermaid for inline docs (GitHub-native), excalidraw for architecture overviews (hand-drawn, editable)
- `/performance` grounded in Knuth — measure-profile-optimize-measure loop
- `/sweep` added for post-agent cleanup — checks blast radius, fixture damage, stale refs, debug artifacts, scope bleed
- questions-not-just-actions pattern validated — `/question` and `/ponder` both earn their keep
- `/sharpen` skill added for iterative code refinement
- `/capture-memory` and `/memory-audit` commands added for session persistence and memory hygiene

## Open Threads

- pre-push hook reminds to update vamp.md (local only, not tracked)
- `score/` as home for notes if they multiply (from riffs)
- skill frontmatter descriptions double as auto-trigger rules — how precise should they be?
- ~~design skill generalizes frontend-design~~ — retired. Marketplace plugin disabled; duet `/design` covers the full scope.
- `/review` has no named framework in FRAMEWORKS.md — every other skill cites an authority
- README skill descriptions truncate mid-sentence — generate-readme.sh needs a cleaner cutoff or shorter source field
- `sync-version.sh` exists but version bump was manual — wire it in or remove it
- FRAMEWORKS.md at 13 rows — a second index dimension (by concern, not just framework) exists but lives in the same file. Split or keep?
