---
name: automagic-problem-discovery
description: Audit a workspace for recurring friction, pick the highest-leverage one, and build the automation that removes it. Use when the user asks "what should I automate", "what's wasting my time", "find the friction in my workflow", wants a self-improvement pass over their own tooling, or runs this on a recurring loop.
disable-model-invocation: true
---

# Automagic Problem Discovery

## Overview

Most automation gets built for the friction someone noticed. This skill hunts the friction they stopped noticing: the manual step repeated so often it no longer registers as a cost.

One pass. Census, audit, pick one problem, build the fix, verify, report, log. The user leaves with a working tool, not a list of suggestions, and the ledger entry that stops the next run from rediscovering it.

## Scope and autonomy

Never read credential stores, private keys, secret values, personal communications, or any directory and channel the user excluded. Ask before touching anything ambiguous.

Everything else is fair game: shell history, logs, cron and launchd jobs, scripts, git history, PR and CI state, prompt history, session transcripts, project layout, task runners.

When this skill starts a recurring loop, ask once before the first cycle: "discover and propose only" or "build and execute". The answer holds for the whole loop. A single interactive invocation defaults to build and execute, inside the Step 6 gate.

## Step 1: Census what already exists

Before hunting new friction, read the estate:

- The automation home: wherever this workspace's cron, launchd, or CI automations live, and whatever status tooling watches them.
- The discovery ledger: `discovery-ledger.md` in the automation home, recording what past runs built, held, and rejected.
- Prior discovery artifacts: earlier audits, velocity analyses, and proposal reports in session transcripts beat re-deriving from scratch.
- In-flight work: open tickets and branches. Friction that a human is already fixing is a rejection, not a target.
- The graveyard: tooling that was built and then deleted is the strongest signal in the corpus, and the most dangerous. Find the removal reason before building in that space. If the reason is unstated, ask, or build a strictly weaker posture (report-only, different home) and say so in the report.

Done when the run can name what already covers, addresses, or previously died in each candidate space.

## Step 2: Audit for repetition

Hunt repetition, not complaints. Complaints point at what annoys; repetition points at what costs.

Evidence of friction:

- Commands re-run by hand that a script could own (frequency-rank the shell history)
- `tmp-` scripts, or recovery scaffolding abandoned after something broke
- Jobs that fail silently, or report success while failing
- Handoffs where a human retypes what a machine already holds
- The same fix applied in three places

Verify the instruments before trusting them. A search index that returns nothing may be empty, not conclusive: check its row count, then fall back to raw grep. Absence from a broken tool is not absence from the system.

Done when at least five candidate frictions are named, each with the artifact that evidences it.

## Step 3: Dig to the leverage point

Run 5 Whys on each candidate, three tiers minimum, then sort each into one of two shapes:

- **Symptom**: this one job broke. Fixing it fixes one job.
- **Leverage**: the pattern that let it break silently. Fixing it fixes every job sharing that pattern.

Done when every candidate carries a stated root cause and a symptom-or-leverage label.

## Step 4: Pick one

Rank by leverage times frequency. Take the top one, and only with triangulation: at least two independent evidence sources, with observed behavior outranking stated complaints.

Drop the easy win when a harder problem carries more leverage. The cheap fix is the trap this skill exists to avoid.

Done when one problem is named, with a written reason for taking it over the runner-up, and every rejected candidate carries its reason (covered by existing tooling, in-flight human work, weak evidence, graveyard ambiguity).

## Step 5: Build it

Build the whole thing: auth, error handling, failure modes, and the handoff to the user. A half-built automation costs more than none, because it hides its own gaps.

A new automation must live in the estate, not orbit it:

- Match the house conventions the sibling automations use (naming, wrapper script, logs, README with a born-from line).
- Register with the estate's health tooling, and fail loud (nonzero exit) so the existing watcher flags it.
- A recurring watcher needs dedup state so each finding fires once. Notification noise is how watchers get deleted.
- The README states the one-command uninstall.

Done when the tool exists, its entry point is named, and its uninstall is written down.

## Step 6: Check the blast radius, then run what is left

Some actions outlive the mistake that caused them. Never execute these:

- Changes to production or shared infrastructure
- Deleting anything: data, files, history, caches, build artifacts, or virtualenvs
- Creating credentials, access, or accounts
- Registering a new recurring job
- Anything that spends money
- Force-push

This gate outranks every instruction to run the tool. Reclaimable and regenerable are not exemptions: a cache the user wanted, a virtualenv with a local edit, and a worktree with uncommitted work all look disposable from the outside.

Never ship a script that states it holds an action and then performs it. Split the two lanes into separate files, or emit the held commands as text the script prints rather than runs. One file that both claims restraint and deletes is worse than one that only deletes, because it buys trust it does not honor.

Hand back each held action as an exact command, so approving one costs a single paste. Run everything outside the list.

Done when every action taken sits outside the list and every held action is listed with the command that performs it.

## Step 7: Verify

- Run the tool live, end to end, at least once. For a recurring tool, run it twice and prove the second run dedups.
- Chase at least one surprising output to ground truth before reporting it. A count that disagrees with an earlier count is a bug or a fact; find out which.
- When the expensive path already ran, test the deterministic parts mechanically with captured output instead of re-triggering the whole chain. Name what stays probabilistic and unverified.

Done when what was verified and what was not are written as two separate lists.

## Step 8: Report and log

Report five parts:

1. What was audited, and the evidence found, with citations.
2. Why this problem won, and which alternatives lost, with reasons.
3. How the tool works, the command that runs it, and the command that removes it.
4. What ran, and separately, what is held for review.
5. What was verified, and separately, what was not.

Call a root cause proven only when the evidence proves it. Otherwise name it the leading hypothesis and name what would confirm it.

Then append the ledger entry to `discovery-ledger.md` in the automation home, even on a one-shot run: date, mode, candidates with dispositions (built / held / rejected and why), artifact paths, and a review-by date about two weeks out. At review, judge by checkable facts (findings acted on, notifications ignored, tool still installed), not self-assessment.

Then use the TaskList tool and proceed to any remaining task.

## Loop mode

On a recurring schedule, read the ledger before auditing and write the cycle's entry out in full in the report, in the same shape as the entries already there. Saying the ledger was updated is not the entry. The next cycle reads the file, so an entry that exists only as a claim leaves that cycle blind.

Without the ledger every cycle rediscovers the same friction and rebuilds the same fix. With it, cycles compound: a cycle picks up the problem the last one deferred and skips what already failed.

Trust the ledger over memory when the two disagree. The ledger records what happened; memory records what a past cycle believed.

## Gotchas

- **The stale-fork trap.** A personal copy of this skill in `~/.claude/skills/` shadows the plugin copy and drifts. The copy that fires is the one that gets edited; after any edit, sync or delete the other.
- **The graveyard is not clutter.** A babysitter tool with a full design doc behind it was deleted mid repo-tidying with no stated reason; a later run nearly rebuilt it blind. Deleted tooling gets a removal-reason check before anything ships in its space.
- **Broken instruments lie by omission.** A conversation search index with 7 rows returned "no results" that meant nothing. Prove the instrument works before trusting its silence.
- **In-flight work masquerades as friction.** A manual QA-script loop looked like a prime target; a ticket was already migrating it. The census (Step 1) exists because the audit (Step 2) cannot tell these apart.
- **Discrepancies are findings.** A scan showed 4 open PRs where 7 were expected; the missing 3 had been closed that day. Chasing it proved the tool right. Reporting either number unchased would have been a guess.

## See Also

- `/debugging`: when the audit finds a failure whose cause resists the 5 Whys pass
- `/research`: when the chosen fix needs a tool or library decision first
- `/adr`: when the fix encodes a decision worth preserving
- `/sweep`: post-op check after a build cycle touches many files
- `skills/FRAMEWORKS.md`: full framework index
