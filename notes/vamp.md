# Vamp

Where we are while figuring out where to go.

---

## Current State

- 6 commands, 9 skills, 1 agent — markdown only, no build system
- skills: adr, design, diagnose, ia, naming, prose, research, review, testing
- two-tier command structure:
  - `commands/` — globally installable via `/install-commands`
  - `.claude/commands/` — duet-only (install-commands, install-skills)
- install-\* commands inventory, diff, confirm, verify — full workflow
- skills use frontmatter for auto-triggering (adr led, others followed)
- CLAUDE.md trimmed to essentials: project structure, lint, command authoring, naming
- prose skill self-contained with full Elements of Style reference
- conservative permissions: deny destructive ops, ask before push/rebase

## Decided

- "install" not "sync" — honest about one-way push, no bidirectional sync
- show diff before overwrite — careful by default
- accepted the ~/.claude/ install pattern over plugin installation
- CLAUDE.md stays lean — project structure and authoring rules, not aspirational content
- `/why` → `/note-why` — name the action, not the content; avoid ask/tell ambiguity
- `/think-next` → `/ponder` — name what you do, not what comes next
- `/adr` moved from command to skill — it's a document framework, not a discrete action
- `/whats-next` kept — pressure-tested, earns its name (Taskwarrior precedent)
- skills expand by domain (design, diagnose, ia, naming, testing) — each grounded in a specific framework or author
- SKILL.md with frontmatter as the standard skill file convention
- `/ia` grounded in Rosenfeld/Morville + Diataxis — includes taxonomy construction heuristics

## Open Threads

- pre-push hook reminds to update vamp.md (local only, not tracked)
- what if vamp.md checked alignment before major pushes — not just project state, but vision?
- `score/` as home for notes if they multiply (from riffs)
- commands that ask questions, not just execute tasks — `/question` and `/ponder` now exist
- skill frontmatter descriptions double as auto-trigger rules — how precise should they be?
- design skill generalizes frontend-design — does the user-level frontend-design skill need updating or retiring?
- `/ia` covers structural IA; tutor's knowledge-design.md covers pedagogical IA — clear boundary or will they drift?
- FRAMEWORKS.md now has 12 rows (IA + Diataxis added) — approaching the point where a second index dimension might help
