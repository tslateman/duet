---
name: agent-watchdog-recipe
workers: 2
parallel: true
---

# Agent Watchdog, Agent Recipe

An audit splits cleanly on its two questions. "Did the agent do what was asked?" is coverage: behavior gaps and scope drift, judged against the reconstructed contract. "Can I believe the agent's claims?" is verification: are the tests, CI, and command output real and green. These are independent lenses, and one context tends to let a confident summary paper over a missing test. Two workers keep coverage honest and verification skeptical.

## Decomposition

The manager reconstructs the contract first (the original request, constraints, and acceptance criteria) and hands the same contract to both workers. Worker 1 checks the diff against the contract. Worker 2 checks the agent's evidence against reality. Neither edits files.

## Workers

### Worker 1: Coverage Auditor

**Focus:** Did the agent do what was asked?

**Framework:** Reconstruct the Contract and the Gap and Scope-drift classes from the skill.

**Scope boundaries:**

- Handles: missing or incomplete behavior, skipped constraints, unrelated changes (scope drift), unmet acceptance criteria.
- Does NOT handle: whether the tests/CI actually ran or passed.

**Prompt template:**

> You are auditing whether an agent did what was asked. Here is the reconstructed contract: {contract}. Read the diff and the relevant files around it. For each item in the contract, mark it done, incomplete, or missing, citing the file and line. Flag any change NOT in the contract as scope drift. Do not edit files. Return a list of gaps and scope-drift items, each with evidence.

### Worker 2: Verification Auditor

**Focus:** Can I believe the agent's claims?

**Framework:** Audit the Evidence and the Bug and Verification-miss classes from the skill.

**Scope boundaries:**

- Handles: whether claimed tests/commands actually ran and passed, CI state, weak or absent evidence, likely bugs or regressions in the touched code.
- Does NOT handle: whether the feature scope was complete.

**Prompt template:**

> You are verifying an agent's claims, not taking them on faith. Here is the contract: {contract} and the agent's final claims: {claims}. Check the actual evidence: run or read the tests it said it ran, check CI state via `gh`, compare claimed command output to real output, and read the touched code for likely bugs. Do not edit files. Return verification misses (claim with weak or no evidence) and bugs (likely failure or regression), each with the evidence you found or could not find.

## Synthesis

The manager merges both lists into one gap report in the skill's Report format:

1. **Lead with Status** (done / blocked / stale / running).
2. **Merge findings** into Gaps: coverage gaps and scope drift from Worker 1, verification misses and bugs from Worker 2.
3. **Deduplicate** where a coverage gap and a verification miss describe the same hole; keep the one with stronger evidence.
4. **Rank** by what blocks acceptance: a missing requirement or a failing test outranks a weak-but-probably-fine claim.
5. **State remaining risk** plainly: anything unverified or waiting on CI, review, deploy, or a human. If the user authorized fixes, fix only the clear-evidence gaps and note what was changed and validated.
