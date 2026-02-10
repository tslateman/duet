# Duet

A Claude Code plugin for git workflows, reflection, code quality, writing, and frontend design.

## Commands & Skills

All commands and skills are invokable with `/name`. Claude can also load them automatically when relevant.

### Commands

Single-file slash commands in `commands/`.

| Command           | Description                                      |
| ----------------- | ------------------------------------------------ |
| `/commit`         | Stage and commit changes                         |
| `/commit-push-pr` | Commit, push, and open a PR                      |
| `/clean-gone`     | Remove stale local branches                      |
| `/debrief`        | Review what landed across sessions               |
| `/retro`          | Capture learnings and open threads               |
| `/note-why`       | Note the rationale behind a commit               |
| `/whats-next`     | Analyze project and suggest what to work on next |
| `/ponder [n]`     | Surface `n` questions worth sitting with         |
| `/question`       | Surface questions about code you just changed    |

### Skills

Advanced skills with supporting files in `skills/`.

| Skill              | Description                                 |
| ------------------ | ------------------------------------------- |
| `/adr`             | Generate Architecture Decision Records      |
| `/frontend-design` | Create distinctive, production-grade UIs    |
| `/prose`           | Apply Strunk's writing rules to prose       |
| `/research`        | Systematic technical research for decisions |
| `/review`          | Structured code review with context capture |

## Agents

Custom subagent definitions for use with `context: fork` in skills.

| Agent             | Description                                  |
| ----------------- | -------------------------------------------- |
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
├── agents/               # Subagent definitions
│   └── <name>.md
└── notes/                # Project thinking
    ├── philosophy.md     # Why duet exists
    ├── riffs.md          # Ideas to play with
    └── vamp.md           # Current state
```

Commands and skills both create slash commands. Use `commands/` for simple single-file commands; use `skills/` when you need supporting files or advanced features like `context: fork`.

## Notes

The `notes/` directory holds project thinking that isn't code. `philosophy.md` captures why duet exists and the design principles behind it. `riffs.md` collects ideas worth exploring but not yet committed to. `vamp.md` tracks current project state and active threads.

## Permissions

Duet includes a permission set (`.claude/settings.json`) optimized for its workflows:

| Tier      | Operations                                                                             |
| --------- | -------------------------------------------------------------------------------------- |
| **Allow** | `Read`, `git status/log/diff/branch/show/notes`, `markdownlint`, `ls/cat/head/tail/wc` |
| **Ask**   | `Edit`, `git add/commit/push/checkout/restore/stash/merge/rebase`                      |
| **Deny**  | `rm -rf`, `git push --force`, `git reset --hard`, `.env`, `~/.ssh`, `~/.aws`           |

Conservative by design: all git writes prompt for confirmation. Customize as needed—project settings override user settings, and `deny` rules always win.

## Requirements

- [Claude Code](https://claude.ai/code)
- Git
- GitHub CLI (`gh`)

## License

MIT
