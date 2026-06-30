---
name: agent-watchdog
description: Audit whether another agent actually did what was asked, not just whether the code is good. Use to watch, audit, compare, or fix another agent's work: a Claude Code or Codex session, a transcript, a PR, a branch, a CI run, or a workflow run.
---

# Agent Watchdog

Watch another agent's work like a reviewer with a pager: reconstruct the request, verify the evidence, and close the gap between what was asked and what actually happened. This audits the _agent_ (did it do the task, did it really verify), not the code itself; pair it with `/review` or `/code-review` for the code.

Adapted from BuilderIO/skills (MIT).

## Choose the mode

Infer the mode from the user's wording:

- **Watch only:** monitor a session, PR, branch, CI run, or workflow until it reaches a terminal state. No edits.
- **Audit:** read the prompt, transcript, diff, tests, CI, and final claims, then return a gap report. No edits.
- **Audit and fix:** audit first, then make narrow fixes for clear gaps. No broad rewrites, branch moves, or speculative changes.
- **Compare:** given multiple agents or runs, judge each against the same original request and reconcile the differences.

If authority is unclear, default to audit-only and say what you would fix.

## Resolve the target

1. Identify every artifact supplied: session or transcript path, thread URL, PR, branch, commit, CI run, issue, or pasted summary.
2. Resolve it from the most direct source (local transcript, repo logs, `gh` for PR/CI), not a summary.
3. If it is still running and you were asked to watch, poll at a reasonable interval until it is done, blocked, stale, or waiting on a human.
4. If it cannot be resolved, ask for the missing identifier.

## Reconstruct the contract

Build a compact contract before judging the work:

- The original request and any later scope changes. This is the source of truth, NOT the agent's own summary.
- Explicit constraints: branch rules, no-edit requests, versions, validation expectations, security or privacy limits.
- Implied acceptance criteria: user-visible behavior, tests, CI, docs, deploys, review replies.
- The agent's final claims and its "could not do" caveats.

## Audit the evidence

Inspect evidence, not vibes:

- Read the changed files and the relevant unchanged files around them.
- Check git status and diff without reverting unrelated work.
- Compare the commands the agent claimed to run against actual output.
- Inspect failed or skipped tests, CI logs, and error traces; for UI work, prefer screenshots or a browser check over prose claims.
- For PR work, verify unresolved threads and CI state from the source system.

Classify each issue:

- **Gap:** requested behavior missing or incomplete.
- **Bug:** the implementation likely fails or regresses.
- **Verification miss:** may be right, but the evidence is weak.
- **Scope drift:** changed something unrelated or skipped a constraint.
- **No issue:** already handled, with evidence.

## Fix narrowly (only when authorized)

1. Fix only gaps with clear evidence.
2. Preserve unrelated local changes; do not move branches unless explicitly asked.
3. Use existing repo patterns and targeted tests.
4. Re-run the smallest useful validation after each meaningful fix.
5. If a fix needs a product decision, a credential, a destructive action, or a broad rewrite, stop and report it instead of guessing.

## Report

Lead with the outcome. Keep it scannable:

```md
Status: done / blocked / stale / running
Requested: what the user asked the agent to do
Observed: what the agent changed, claimed, and verified
Gaps: missing behavior, bugs, weak verification, scope drift
Fixes made: files changed + validation run (omit for audit-only)
Remaining risk: unverified, or waiting on CI/review/deploy/human
```

Name exact files, commands, PRs, or thread IDs when they matter.

## See Also

The post-agent triad, each a different question about a finished run:

- `/debrief`: recap of what agents accomplished across sessions, with loose ends; this audits one run against its ask
- `/sweep`: post-op check for artifacts and damage left behind; this checks whether the work got done
- `/review`: structured review of the code itself, with reasoning capture
- `/debugging`: when an audited gap turns out to be a real bug, build the loop and isolate it
- `RECIPE.md`: Agent recipe for parallel decomposition (2 workers)
