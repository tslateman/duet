# Vamp

Where we are while figuring out where to go.

---

## Current State

- 8 commands, 12 skills, 1 agent — markdown only, no build system
- commands: debrief, lint, note-why, ponder, question, retro, sweep, whats-next
- skills: adr, design, diagnose, excalidraw, ia, mermaid, naming, performance, prose, research, review, testing
- FRAMEWORKS.md indexes 13 framework-to-skill mappings
- two-tier command structure:
  - `commands/` — globally installable via `/install-commands`
  - `.claude/commands/` — duet-only (install-commands, install-skills, install-statusline)
- install-\* commands inventory, diff, confirm, verify — full workflow
- skills use frontmatter for auto-triggering (adr led, others followed)
- CLAUDE.md trimmed to essentials: project structure, lint, command authoring, naming
- prose skill self-contained with full Elements of Style reference
- conservative permissions: deny destructive ops, ask before push/rebase
- version 0.1.1

## Decided

- "install" not "sync" — honest about one-way push, no bidirectional sync
- show diff before overwrite — careful by default
- accepted the ~/.claude/ install pattern over plugin installation
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

## Open Threads

- pre-push hook reminds to update vamp.md (local only, not tracked)
- `score/` as home for notes if they multiply (from riffs)
- skill frontmatter descriptions double as auto-trigger rules — how precise should they be?
- design skill generalizes frontend-design — does the marketplace frontend-design skill need retiring?
- `/review` has no named framework in FRAMEWORKS.md — every other skill cites an authority
- README skill descriptions truncate mid-sentence — generate-readme.sh needs a cleaner cutoff or shorter source field
- `sync-version.sh` exists but version bump was manual — wire it in or remove it
- FRAMEWORKS.md at 13 rows — a second index dimension (by concern, not just framework) exists but lives in the same file. Split or keep?
