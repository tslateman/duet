---
description: Surface 2-3 pointed questions about code you just changed
allowed-tools:
  [Bash(git diff:*), Bash(git log:*), Bash(git show:*), Read, Grep, Glob]
---

Surface questions worth answering about recent changes.
Grounded in actual diffs, not abstract philosophy.

## 1. Gather Changes

Check what changed recently:

```bash
git diff HEAD~3 --stat
```

```bash
git log --oneline -5
```

If there are uncommitted changes, include those too:

```bash
git diff --stat
```

Read the actual diffs to understand what was written:

```bash
git diff HEAD~3
```

## 2. Generate Questions

From the diffs and commit history, surface **2-3 questions**
the developer should answer. Target these categories:

- **Design decisions** -- Why this approach over alternatives?
  What tradeoff was made?
- **Edge cases** -- What inputs, states, or timing would
  break this?
- **Naming and abstraction** -- Does the name match what the
  code actually does? Is the boundary in the right place?
- **Assumptions** -- What must stay true for this to keep
  working? What's implicit?
- **Missing pieces** -- What's conspicuously absent given
  what was added?

## 3. Formatting

Present each question as:

### Q: [The question]

> [1-2 lines of context showing *which specific change*
> > prompted this question -- reference files, functions,
> > or lines]

Do not answer the questions. Do not suggest fixes.
The value is in the asking.

Keep questions concrete. Name files, functions, variables.
Avoid "have you considered..." generality -- point at
the code.
