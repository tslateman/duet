# Duet

Slash commands for Claude Code that streamline git workflows and encourage reflection.

## Commands

| Command | Description |
|---------|-------------|
| `/commit` | Stage and commit changes |
| `/commit-push-pr` | Commit, push, and open a PR |
| `/clean-gone` | Remove stale local branches |
| `/debrief` | Review what landed across sessions |
| `/retro` | Capture learnings and open threads |
| `/think-next [n]` | Generate `n` philosophy questions |

## Installation

Clone and copy commands to your project:

```bash
git clone https://github.com/tslateman/duet.git
cp -rn duet/commands your-project/.claude/commands
```

## Requirements

- [Claude Code](https://claude.ai/code)
- Git
- GitHub CLI (`gh`)
