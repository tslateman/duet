# Duet

A Claude Code plugin for reflection, code quality,
writing, and design.

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

Or run the install script again — it pulls if already installed.

## Commands

| Command | Description |
| --- | --- |
| `/debrief` | Review what agents accomplished, surface loose ends across sessions |
| `/lint` | Run markdownlint on specified files or the whole project |
| `/note-why` | Note the rationale behind a commit using git notes |
| `/ponder [n]` | Surface a question worth sitting with |
| `/question` | Surface 2-3 pointed questions about code you just changed |
| `/retro` | Reflect on recent work—capture learnings and surface what to think about next |
| `/whats-next` | Analyze project and suggest what to work on next |

## Skills

| Skill | Description |
| --- | --- |
| `/adr` | Generate Architecture Decision Records that capture the reasoning behind technic... |
| `/design` | Intentional design thinking for interfaces, components, and systems. Use when th... |
| `/diagnose` | Systematic debugging that applies the scientific method to failures. Use when th... |
| `/ia` | Evaluate and improve how information is organized for findability. Use when the ... |
| `/naming` | Evaluate and improve names in code using naming as a design diagnostic. Use when... |
| `/performance` | Profiling methodology and optimization strategy for performance work. Use when t... |
| `/prose` | Apply Strunk's writing rules to prose—documentation, commits, error messages, UI... |
| `/research` | This skill should be used when the user asks to "research X", "investigate Y", "... |
| `/review` | Framework for code review that captures context future maintainers need—concerns... |
| `/testing` | Design test strategy using Beck's Test Desiderata — which properties matter, whi... |

## Agents

| Agent | Description |
| --- | --- |
| `code-simplifier` | Simplifies and refines code for clarity, consistency, and maintainability while preserving all functionality. Focuses on recently modified code unless instructed otherwise. |

## Per-project installation

Copy individual components into a project instead
of installing the plugin globally.
From within the duet directory:

- `/install-commands` — copy commands to
  `~/.claude/commands/`
- `/install-skills` — copy skills to
  `~/.claude/skills/`
- `/install-statusline` — install lean status bar
  to `~/.claude/`

All show diffs for modified files and let you
cherry-pick.

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
