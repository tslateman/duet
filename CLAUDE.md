# Duet

Claude Code plugin for reflection, code quality, writing, and design. Markdown only — no build system.

## Lint

```bash
markdownlint commands/**/*.md skills/**/SKILL.md
```

## Project Structure

```
commands/
  capture-memory.md    Capture learnings to MEMORY.md
  debrief.md           Review agent work, surface loose ends
  lint.md              Run markdownlint on files
  memory-audit.md      Audit project memory files for staleness
  ponder.md            Surface a question worth sitting with
  probe.md             Probe recent changes with pointed questions
  retro.md             Session retrospective
  sweep.md             Post-op check for artifacts, damage, stale refs
  vamp.md              Survey the project and choose what to play next
skills/
  FRAMEWORKS.md        Framework-to-skill index
  adr/                 Architecture Decision Records (Nygard)
  automagic-problem-discovery/  Friction audit that ends in a built tool (5 Whys)
  debugging/           Systematic debugging (Agans)
  design/              Intentional design (visual, API, system)
  excalidraw/          Programmatic Excalidraw diagrams
  ia/                  Information architecture (Rosenfeld + Diataxis)
  mermaid/             Mermaid.js diagrams for GitHub markdown
  naming/              Naming as design diagnostic (Benner + Bloch)
  performance/         Profiling and optimization (Knuth)
  prose/               Strunk's Elements of Style for all writing
  research/            Systematic technical investigation
  review/              Structured code review with context capture
  testing/             Test strategy (Beck's Test Desiderata)
  vibe-check/          Judgment linter for vibe-coded output
agents/
  code-simplifier.md   Refine code for clarity and maintainability
statusline/
  statusline-command.sh  Lean status bar (dir, git, model, context, vim)
scripts/
  generate-readme.sh   Auto-generate README tables from source
evals/
  evals.json           Master eval registry (generated from the scenario tree)
  run.sh               Eval runner (with/without skill + grader)
  <skill>/<scenario>/  43 scenarios across all 14 skills; vibe-check has 4, the rest 3 each
```

### Skill Directory Contents

- `SKILL.md` — Required. Skill definition, methodology, and trigger rules
- `RECIPE.md` — Optional. Bach recipe for multi-agent decomposition
- `references/` — Optional. Framework excerpts and supporting documentation
- `scripts/` — Optional. Executable tooling (e.g., diagram generators)

### Eval Scenario Contents

Each scenario directory (`evals/<skill>/<scenario>/`) contains:

- `capability.txt` — One-line description of what this scenario tests
- `task.md` — Realistic prompt with inline code/text fixture
- `criteria.json` — Array of assertions: `id`, `text`, `type` (required/recommended/includes)

Run evals: `bash evals/run.sh [skill] [scenario]`. Uses `claude -p` with and without the skill, then grades output against assertions. Set `EVAL_MODEL` to override the default (claude-sonnet-4-6).

## Command Authoring

### Frontmatter (Required)

```yaml
---
description: Brief one-line description of what this command does
allowed-tools: [Bash, Read, Glob, Grep] # Optional: restrict tools
---
```

- `description`: Required. Used for command discovery
- `allowed-tools`: Optional. Omit to allow all tools
- Use patterns like `Bash(git add:*)` to restrict specific commands

### Skill Frontmatter

```yaml
---
name: skill-name
description: Brief description with optional trigger phrases ("Use when...")
user-invocable: true # Optional. Set to false for auto-invoke-only skills
---
```

- `name`: Required. Skill identifier, used in autocomplete
- `description`: Required. Serves dual purpose: autocomplete display and auto-trigger matching
- `user-invocable`: Optional. Defaults to true. Set to `false` for skills that should only auto-invoke based on context, not appear as explicit `/skill` commands

### Inline Execution

- `` !`git status` `` — Executes command and injects output
- `${ARGUMENTS:-default}` — Accesses command arguments

### Formatting Rules

- ATX-style headers (`##` not underlines)
- Fence code blocks with language identifiers
- Numbered lists for sequential steps, bullets for unordered
- No trailing whitespace

## Naming Conventions

| Element       | Convention      | Example             |
| ------------- | --------------- | ------------------- |
| Command files | `kebab-case.md` | `capture-memory.md` |
| Directories   | `kebab-case/`   | `testing/`          |
