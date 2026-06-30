---
name: grill-with-docs
description: Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. Use when the user wants to stress-test a plan against their project's language and documented decisions, or asks to "grill me with docs" or "interview me about this".
---

# Grill With Docs

Interview the user relentlessly about every aspect of the plan until you reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one at a time. For each question, propose your recommended answer.

Ask the questions one at a time, waiting for feedback on each before continuing.

If a question can be answered by exploring the codebase, explore the codebase instead.

## Domain awareness

During codebase exploration, also look for existing documentation:

### File structure

Most repos have a single context:

```
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

If a `CONTEXT-MAP.md` exists at the root, the repo has multiple contexts. The map points to where each one lives:

```
/
├── CONTEXT-MAP.md
├── docs/
│   └── adr/                          ← system-wide decisions
├── src/
│   ├── ordering/
│   │   ├── CONTEXT.md
│   │   └── docs/adr/                 ← context-specific decisions
│   └── billing/
│       ├── CONTEXT.md
│       └── docs/adr/
```

Create files lazily, only when you have something to write. If no `CONTEXT.md` exists, create one when the first term is resolved. If no `docs/adr/` exists, create it when the first ADR is needed.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with the existing language in `CONTEXT.md`, call it out immediately. _"Your glossary defines 'cancellation' as X, but you seem to mean Y, which is it?"_

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. _"You're saying 'account', do you mean the Customer or the User? Those are different things."_

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: _"Your code cancels entire Orders, but you just said partial cancellation is possible, which is right?"_

### Update CONTEXT.md inline

When a term is resolved, update `CONTEXT.md` right there. Don't batch them up, capture them as they happen. Use the format in [CONTEXT-FORMAT.md](CONTEXT-FORMAT.md).

Don't couple `CONTEXT.md` to implementation details. Only include terms that are meaningful to domain experts.

### Offer ADRs sparingly

Only offer to create an ADR when all three are true:

1. **Hard to reverse**, the cost of changing your mind later is meaningful
2. **Surprising without context**, a future reader will wonder "why did they do it this way?"
3. **The result of a real trade-off**, there were genuine alternatives and you picked one for specific reasons

If any of the three is missing, skip the ADR.

For a **lightweight inline ADR** (1–3 sentences, captured during grilling), use [ADR-FORMAT.md](ADR-FORMAT.md). For a **heavyweight Nygard-style ADR** with full context, consequences, and rejected alternatives, invoke `/adr` instead.

## Pairs With

- `/improve-codebase-architecture`: same grilling discipline applied to deepening candidates; shares `CONTEXT.md` upkeep
- `/adr`: heavyweight ADR generator when an inline 1–3 sentence ADR isn't enough
- `/naming`: naming difficulty surfaces during grilling; `/naming` is the deeper diagnostic
- `/research`: when a question can't be resolved by interview or by reading code, externalise it

---

_Adapted from [mattpocock/skills](https://github.com/mattpocock/skills)._
