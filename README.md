# Duet

A Claude Code plugin for reflection, code quality,
writing, and frontend design.

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

| Command       | Description                                   |
| ------------- | --------------------------------------------- |
| `/debrief`    | Review what landed across sessions            |
| `/retro`      | Capture learnings and open threads            |
| `/note-why`   | Note the rationale behind a commit            |
| `/whats-next` | Analyze project and suggest what to work on   |
| `/ponder [n]` | Surface `n` questions worth sitting with      |
| `/question`   | Surface questions about code you just changed |

## Skills

| Skill       | Description                                    |
| ----------- | ---------------------------------------------- |
| `/adr`      | Generate Architecture Decision Records         |
| `/diagnose` | Systematic debugging via the scientific method |
| `/design`   | Intentional design for interfaces and systems  |
| `/naming`   | Naming as a design diagnostic                  |
| `/prose`    | Apply Strunk's writing rules to prose          |
| `/research` | Systematic technical research for decisions    |
| `/review`   | Structured code review with context capture    |
| `/testing`  | Test strategy using Beck's Test Desiderata     |

## Agents

| Agent             | Description                                  |
| ----------------- | -------------------------------------------- |
| `code-simplifier` | Refines code for clarity and maintainability |

## Per-project installation

Copy individual components into a project instead
of installing the plugin globally.
From within the duet directory:

- `/install-commands` — copy commands to
  `~/.claude/commands/`
- `/install-skills` — copy skills to
  `~/.claude/skills/`

Both show diffs for modified files and let you
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
└── notes/                # Project thinking
```

## Requirements

- [Claude Code](https://claude.ai/code)
- Git
- GitHub CLI (`gh`)

## License

MIT
