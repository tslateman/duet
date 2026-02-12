# The Nine Rules of Debugging

From David Agans' _Debugging: The 9 Indispensable Rules for
Finding Even the Most Elusive Software and Hardware Problems_
(2002).

## Rule 1: Understand the System

Read the manual. Read the code. Know what the system is
_designed_ to do before deciding it's doing something wrong.

**In practice:**

- Read the function's contract before debugging it
- Check the API docs for the library call that fails
- Understand the expected data flow before tracing it
- "It's broken" often means "I misunderstand the spec"

**Violation symptom:** You're debugging correct behavior.

## Rule 2: Make It Fail

Find a reliable reproduction. Without one, you're guessing.

**In practice:**

- Record exact steps to reproduce
- Identify the triggering conditions
- Simplify until you have the minimal reproduction
- If it's intermittent, look for timing, concurrency,
  or state-dependent triggers

**Violation symptom:** "It works on my machine" or "I can't
reproduce it reliably."

## Rule 3: Quit Thinking and Look

The most violated rule. Stop theorizing and observe what
actually happens.

**In practice:**

- Add logging at every step of the suspect code path
- Use a debugger to inspect actual values
- Print the actual HTTP request, not what you think it is
- Compare "what I think the state is" vs "what it actually is"

**Violation symptom:** "I'm sure the value is X" without
having printed it.

## Rule 4: Divide and Conquer

Binary search the problem space to narrow the location.

**In practice:**

- Comment out half the suspect code — does it still fail?
- Is the input correct? Check at the midpoint of processing
- `git bisect` to find the introducing commit
- Divide by layer: is it the UI, the API, or the database?

**Violation symptom:** Reading through the entire codebase
linearly looking for the bug.

## Rule 5: Change One Thing at a Time

Each experiment tests exactly one variable.

**In practice:**

- Revert all changes, then apply one at a time
- Test after each configuration change
- Isolate environment differences one by one
- If you changed two things and it works, you don't know which
  fixed it (or if they're masking each other)

**Violation symptom:** "I changed five things and now it
works" (but you don't know why).

## Rule 6: Keep an Audit Trail

Write down what you did and what happened.

**In practice:**

- Log each hypothesis and its test result
- Note exact error messages (don't paraphrase)
- Record timestamps for intermittent bugs
- When you find it, the trail shows others the path

**Violation symptom:** Trying the same thing twice because
you forgot you already tested it.

## Rule 7: Check the Plug

Verify assumptions so basic they feel insulting to check.

**In practice:**

- Is the code you're reading the code that's running?
- Did the build complete? Is the deploy current?
- Are you on the right branch? The right environment?
- Is the database you're querying the one the app connects to?
- Is the test actually running? (Not skipped, not cached)

**Violation symptom:** Hours of debugging code that isn't
executing.

## Rule 8: Get a Fresh View

Explain the problem to someone (or something) else.

**In practice:**

- Describe the problem from scratch, omitting nothing
- The act of explaining often surfaces hidden assumptions
- Ask someone unfamiliar with the code — naive questions
  are powerful
- If you're stuck after 30 minutes, get a fresh view

**Violation symptom:** Tunnel vision. Re-reading the same
code expecting different insight.

## Rule 9: If You Didn't Fix It, It Ain't Fixed

Prove the fix works. Prove it works for the right reason.

**In practice:**

- Remove the fix — does the bug return?
- Can you explain _why_ the fix works?
- Does the fix handle the root cause or just the symptom?
- Add a test that fails without the fix and passes with it

**Violation symptom:** "It seems to work now" without
understanding the causal mechanism.
