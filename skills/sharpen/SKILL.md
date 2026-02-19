---
name: sharpen
user-invocable: false
description: Tighten and sharpen prose by subtraction. Use when the user asks to "tighten", "sharpen", "cut this down", "too long", "make it tighter", "trim", or when a draft is bloated and needs editorial discipline.
---

# Sharpening Is Subtraction

## Overview

Sharpening a draft means removing everything that doesn't serve the core point. Not rewriting. Not adding "voice." Cutting.

## Core Principles

### 1. Cut Structure, Keep Substance

Drafts bloat through structure, not through ideas. Headers, transitions, framing paragraphs, and setup sentences add length without adding meaning. Cut them first. The substance survives.

### 2. Catch LLM-isms

AI-generated text carries recognizable signatures: contrastive pivots, filler authority phrases, uniform tone, and predictable word choices. These patterns weaken prose even when the underlying argument is strong. Identify them and cut or rewrite.

### 3. Substance Over Voice for High-Stakes Prose

"Humanizing" prompts add colloquialisms and personality but dilute the core argument. For leadership pitches, technical proposals, and executive communication, fluff hurts more than polish helps. Prioritize the argument.

### 4. Trust the Author's Cuts

A single note from the author ("cut 'The stakes are real'") often does more than an elaborate rewriting pass. The author knows what matters. When they cut, follow the instinct rather than restoring through rewording.

## LLM-ism Catalog

Recognizable AI writing patterns and their fixes:

| Pattern                     | Example                                         | Fix                                             |
| --------------------------- | ----------------------------------------------- | ----------------------------------------------- |
| Contrastive pivot           | "That's not a trend piece -- that's the stakes" | State what it is. Skip the negation setup.      |
| Needless stakes declaration | "The stakes are real."                          | Delete it. If the argument is strong, it shows. |
| Uniform sentence rhythm     | Every paragraph same length, same cadence       | Vary length. Let some sentences punch.          |
| Hedged authority            | "It's worth noting that..."                     | Drop the hedge. State the point.                |
| Formulaic structure         | Intro paragraph, three body sections, summary   | Start with the strongest point. Cut the frame.  |
| Predictable word choices    | Always the most probable next word              | Choose the specific word, not the expected one. |
| Throat-clearing openers     | "When we think about X, we need to consider..." | Delete and start at the verb.                   |

## Workflow

1. **Read the draft.** Identify the core point in one sentence
2. **Cut everything that doesn't serve it.** Framing, transitions, restatements, setup paragraphs
3. **Scan for LLM patterns.** Check the catalog above. Fix or delete each instance
4. **Verify nothing was lost.** Read the shortened version. Does every important idea survive? If yes, the cut version is the better version

## Before/After Examples

### Contrastive Pivot Removed

**Before:**

> Organizations on the right side of the specification bottleneck are pulling
> 10-80x revenue per employee. That's not a trend piece -- that's the stakes.

**After:**

> Organizations on the right side of the specification bottleneck are pulling
> 10-80x revenue per employee.

The number speaks for itself. The second sentence adds nothing.

### Throat-Clearing Cut

**Before:**

> Three questions worth putting in front of leadership:

**After:**

> Three questions for leadership:

Five words removed. Same meaning.

### Structure Replaced by Substance

**Before (sprawling pitch with headers, setup paragraphs, and framing):**

> We talk about AI like the hard part is getting it to build things. It's not.
> The hard part is telling it _what_ to build with enough clarity that you can
> check whether it worked.
>
> ## The Specification Bottleneck
>
> \[three paragraphs of framing\]
>
> ## Some of This Can't Be Measured
>
> \[measurement discussion\]

**After (substance only):**

> The bottleneck is specifying what to build with enough precision to know
> whether it worked. Solve that and AI compresses execution. Miss it and you
> produce more waste, faster.

One paragraph replaces an entire section. The argument gets stronger because the framing is gone.

## The Test

Can you remove this sentence without losing meaning? Remove it.

## See Also

- `/prose` -- Strunk's rules for grammar and composition. Sharpen is editorial
  discipline; prose is mechanical correctness. They complement each other.
