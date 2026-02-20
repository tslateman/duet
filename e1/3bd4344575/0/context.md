# Session Context

## User Prompts

### Prompt 1

Implement the following plan:

# Plan: Duet Tooling & Polish

## Context

The `/whats-next` analysis surfaced three tooling improvements and three polish fixes. Several turned out to already be in place (GH Actions, URLs), narrowing the actual work.

## Changes

### 1. GitHub Actions — already done

`.github/workflows/lint.yml` already runs `markdownlint-cli` on PRs to `main`, plus frontmatter validation and broken-reference checks. No changes needed.

### 2. URLs — already consistent

`inst...

### Prompt 2

commit this

### Prompt 3

## Context

- Current git status: On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   README.md
	modified:   notes/riffs.md
	modified:   notes/vamp.md

no changes added to commit (use "git add" and/or "git commit -a")
- Current git diff (staged and unstaged c...

