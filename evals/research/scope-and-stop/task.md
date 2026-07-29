Apply the /research skill. One question: does `ruff format` produce output
identical to `black` for our codebase, yes or no, and if not, where does it
differ? We are deciding whether swapping the tool creates a one-time diff or an
ongoing formatting disagreement.

Evidence collected, do not search further:

**Ruff docs, current, "Known deviations from Black":** ruff format is designed as
a drop-in replacement and matches Black output in over 99.9% of lines on a large
corpus. Documented intentional deviations include: handling of certain magic
trailing commas in subscripts, some parenthesization of long `del` statements,
formatting of blank lines after module docstrings, and behavior on `# fmt: skip`
in some positions.

**Ruff changelog, 2026-02:** "the formatter is stable; the 2026 style guide
introduces no deviations from Black 25.x beyond those documented."

**Our repo facts:** 214k lines of Python, black 24.4.2 pinned in pre-commit,
`# fmt: off`/`# fmt: on` appears 31 times, `# fmt: skip` appears 4 times, and we
have no `del` statements longer than one line.
