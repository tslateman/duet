# Duet

Reflection, writing, and design skills for Claude Code.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/tslateman/duet/main/install.sh | bash
```

Or clone directly:

```bash
git clone https://github.com/tslateman/duet.git ~/.claude/plugins/duet
```

## Update

```bash
git -C ~/.claude/plugins/duet pull
```

Or run the install script again; it pulls if already installed.

## Philosophy

> Two voices in dialogue, neither dominant. The composition emerges from the interaction. [Read more.](notes/philosophy.md)

## Getting Started

You don't need to memorize the catalog. Describe what you're doing in plain
language and Claude routes to the right skill automatically:

- "debug this" → `/debugging`
- "review my PR" → `/review`
- "how should I test this" → `/testing`

Explore the full catalog by problem type in [Skills by Concern](skills/FRAMEWORKS.md#skills-by-concern).

Use `/install-statusline` to set up a lean status bar for Claude Code sessions.

## How Duet Works

- **Skills** auto-invoke from context and teach methodology
- **Commands** are workflows you invoke by name
- **Agents** are subprocesses for parallel work

## Commands

| Command           | Description                                                                   |
| ----------------- | ----------------------------------------------------------------------------- |
| `/capture-memory` | Capture learnings to MEMORY.md, output compact summary                        |
| `/debrief`        | Review what agents accomplished, surface loose ends across sessions           |
| `/lint`           | Run markdownlint on specified files or the whole project                      |
| `/memory-audit`   | Audit project memory files for staleness, orphans, bloat, and duplication     |
| `/ponder [n]`     | Surface a question worth sitting with                                         |
| `/probe`          | Probe recent changes with 2-3 pointed questions                               |
| `/retro`          | Reflect on recent work—capture learnings and surface what to think about next |
| `/sweep`          | Post-op check for artifacts, damage, and stale references after agent work    |
| `/vamp`           | Survey the project and choose what to play next                               |

## Skills

| Skill          | Description                                                                                                                                                                                |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `/adr`         | Generate Architecture Decision Records that capture the reasoning behind technical decisions.                                                                                              |
| `/debugging`   | Systematic debugging that applies the scientific method to failures.                                                                                                                       |
| `/design`      | Intentional design thinking for interfaces, components, and systems.                                                                                                                       |
| `/excalidraw`  | Create Excalidraw diagrams programmatically.                                                                                                                                               |
| `/ia`          | Evaluate and improve how information is organized for findability.                                                                                                                         |
| `/mermaid`     | Create diagrams and visualizations using Mermaid.js v11 syntax.                                                                                                                            |
| `/naming`      | Evaluate and improve names in code using naming as a design diagnostic.                                                                                                                    |
| `/performance` | Profiling methodology and optimization strategy for performance work.                                                                                                                      |
| `/prose`       | Apply Strunk's writing rules to prose—documentation, commits, error messages, UI text. Clearer, stronger, more professional. Also handles sharpening and tightening drafts by subtraction. |
| `/research`    | Systematic technical investigation—evidence gathering, option comparison, and actionable recommendations.                                                                                  |
| `/review`      | Framework for code review that captures context future maintainers need—concerns raised, alternatives rejected, risks accepted.                                                            |
| `/testing`     | Design test strategy using Beck's Test Desiderata — which properties matter, which tradeoffs to make.                                                                                      |

## Agents

| Agent             | Description                                                                                                                                                                  |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `code-simplifier` | Simplifies and refines code for clarity, consistency, and maintainability while preserving all functionality. Focuses on recently modified code unless instructed otherwise. |

## Recipes

Seven skills include `RECIPE.md` files that teach Bach (a multi-agent
orchestrator) how to decompose domain tasks into parallel workers. Each recipe
defines roles, inputs, and coordination patterns for multi-agent work. See
[FRAMEWORKS.md](skills/FRAMEWORKS.md) for the full list.

## Structure

```text
duet/
├── .claude-plugin/
│   └── plugin.json       # Plugin metadata
├── commands/             # Slash commands
├── skills/               # Skills with supporting files
│   └── <name>/SKILL.md
├── agents/               # Subagent definitions
├── statusline/           # Status bar script
├── scripts/              # Build and maintenance scripts
└── notes/                # Project thinking
```

## Requirements

- [Claude Code](https://claude.ai/code)
- Git
- GitHub CLI (`gh`)

## License

MIT
