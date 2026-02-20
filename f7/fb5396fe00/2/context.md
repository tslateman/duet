# Session Context

## User Prompts

### Prompt 1

we can drop vamp.md and the related pre-push hook

### Prompt 2

[Request interrupted by user]

### Prompt 3

oops! keep the `/vamp` skill - i just mean drop the note

### Prompt 4

## Context

- Current git status: On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   CLAUDE.md
	deleted:    hooks/pre-push.example
	deleted:    notes/vamp.md

no changes added to commit (use "git add" and/or "git commit -a")
- Current git diff (staged and unstaged changes): diff --git a/CLAUDE.md b/CLAUDE.md...

### Prompt 5

woah, I didn't want to delete .git/hooks/pre-push.pre-entire

### Prompt 6

[Request interrupted by user for tool use]

### Prompt 7

ah but it's about the old vamp note, so we don't need it

### Prompt 8

i want to expand philosophy.md
right now it focuses on going back and forth with the human-AI, but I also want to highlight another relationship. multiple humans adopting duet can themselves form a duet by "singing" their part in prompts to the model

### Prompt 9

beautiful, can we put 1 or 2 lines of summarizing the philosophy's metaphor into the readme? ok to link back to philosophy.md for more

### Prompt 10

can we tighten this line?
A Claude Code plugin for reflection, code, writing, and design.

### Prompt 11

yeah do it

### Prompt 12

the philosophy section of the readme is too long... really i just want a oneliner, maybe stylized like a quote, and citing philosophy.md

### Prompt 13

apply /prose

### Prompt 14

Base directory for this skill: /Users/tslater/.claude/plugins/cache/local/duet/0.1.1/skills/prose

# Writing Clearly and Concisely

## Overview

William Strunk Jr.'s _The Elements of Style_ (1918) teaches you to write clearly and cut ruthlessly.

**WARNING:** `references/elements-of-style.md` consumes ~12,000 tokens. Read it only when writing or editing prose.

## When to Use This Skill

Use this skill whenever you write prose for humans:

- Documentation, README files, technical explanations
- ...

### Prompt 15

can we drop the em dashes?

### Prompt 16

## Context

- Current git status: On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   README.md
	modified:   notes/philosophy.md

no changes added to commit (use "git add" and/or "git commit -a")
- Current git diff (staged and unstaged changes): diff --git a/...

