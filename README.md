# Duet

A Claude Code plugin for git workflows, reflection, code quality, writing, and frontend design.

## Skills

All skills are invokable with `/skill-name`. Claude can also load them automatically when relevant.

| Skill | Description |
|-------|-------------|
| `/commit` | Stage and commit changes |
| `/commit-push-pr` | Commit, push, and open a PR |
| `/clean-gone` | Remove stale local branches |
| `/debrief` | Review what landed across sessions |
| `/retro` | Capture learnings and open threads |
| `/think-next [n]` | Generate `n` philosophy questions |
| `/frontend-design` | Create distinctive, production-grade UIs |
| `/prose` | Apply Strunk's writing rules to prose |

## Agents

Custom subagent definitions for use with `context: fork` in skills.

| Agent | Description |
|-------|-------------|
| `code-simplifier` | Refines code for clarity and maintainability |

## Installation

Clone to your plugins directory:

```bash
git clone https://github.com/tslateman/duet.git ~/.claude/plugins/duet
```

Or copy to a project:

```bash
git clone https://github.com/tslateman/duet.git
cp -rn duet/commands your-project/.claude/commands
cp -rn duet/skills your-project/.claude/skills
cp -rn duet/agents your-project/.claude/agents
```

## Structure

```
duet/
├── .claude-plugin/
│   └── plugin.json       # Plugin metadata
├── commands/             # Simple slash commands
├── skills/               # Skills with supporting files
│   └── <name>/SKILL.md
└── agents/               # Subagent definitions
    └── <name>.md
```

Commands and skills both create slash commands. Use `commands/` for simple single-file commands; use `skills/` when you need supporting files or advanced features like `context: fork`.

## Requirements

- [Claude Code](https://claude.ai/code)
- Git
- GitHub CLI (`gh`)
