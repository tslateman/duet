# Frameworks Index

Each duet skill is grounded in a specific framework or authority. This index maps the intellectual foundations to the skills that apply them.

## Skills by Framework

| Framework                | Authority                    | Skill                            | Core Idea                                                                    |
| ------------------------ | ---------------------------- | -------------------------------- | ---------------------------------------------------------------------------- |
| 9 Rules of Debugging     | David J. Agans               | `/debugging`                     | Scientific method applied to software failures                               |
| Test Desiderata          | Kent Beck                    | `/testing`                       | 12 properties every test balances; make tradeoffs deliberate                 |
| Elements of Style        | William Strunk Jr.           | `/prose`                         | Active voice, omit needless words, be specific                               |
| Naming Principles        | Benner                       | `/naming`                        | Understandability, conciseness, consistency, distinguishability              |
| API Design               | Joshua Bloch                 | `/naming`, `/design`             | Self-documenting, least astonishment, minimal surface                        |
| Ubiquitous Language      | Eric Evans (DDD)             | `/naming`                        | Code names match domain language                                             |
| ADR Format               | Michael Nygard               | `/adr`                           | Capture context and reasoning, not just the decision                         |
| Testing Trophy           | Kent C. Dodds                | `/testing`                       | Integration tests provide the best confidence-to-cost ratio                  |
| Modern Code Review       | Bacchelli & Bird             | `/review`                        | Code review's primary value is knowledge transfer, not defect detection      |
| Knuth's Performance Rule | Donald Knuth                 | `/performance`                   | Optimize the critical 3%; measure, profile, optimize, measure again          |
| Information Architecture | Rosenfeld, Morville & Arango | `/ia`                            | Organization, labeling, navigation, search for findability                   |
| Diataxis                 | Daniele Procida              | `/ia`                            | Four documentation modes: tutorial, how-to, explanation, reference           |
| Mermaid.js v11           | Mermaid project              | `/mermaid`                       | Text-based diagrams that render natively in GitHub markdown                  |
| Excalidraw Generator     | Excalidraw project           | `/excalidraw`                    | Programmatic hand-drawn diagrams via Python API                              |
| Judgment Linting         | Anthropic eval methodology   | `/vibe-check`                    | Higher-order code assertions that require AI reasoning, not regexes          |
| Compression Mode         | mattpocock/skills            | `/caveman`                       | Strunk taken to the extreme — drop every word that does not add signal       |
| Map Before Streets       | mattpocock/skills            | `/zoom-out`                      | Map callers, neighbors, and abstraction layers before reading details        |
| Deep Modules             | John Ousterhout              | `/improve-codebase-architecture` | Leverage at the interface — large behaviour behind small surface             |
| Seams & Adapters         | Michael Feathers             | `/improve-codebase-architecture` | Alter behaviour without editing in place; the interface is the test surface  |
| Design It Twice          | John Ousterhout              | `/improve-codebase-architecture` | First idea is unlikely to be best — produce radically different alternatives |
| Ubiquitous Language live | Eric Evans (DDD)             | `/grill-with-docs`               | Sharpen domain terms during conversation; persist to CONTEXT.md inline       |
| Lightweight ADR          | mattpocock/skills            | `/grill-with-docs`               | 1–3 sentence inline ADR for crystallising decisions during a grilling        |
| Visual Recap             | BuilderIO/skills             | `/visual-recap`                  | Map a diff to structured blocks before reading raw lines                     |
| Skill Craft              | mattpocock/skills            | `/writing-great-skills`          | Predictability via leading words, information hierarchy, and pruning         |

## Skills by Concern

| Concern                                | Primary Skill                    | Supporting Skills                 |
| -------------------------------------- | -------------------------------- | --------------------------------- |
| "Is this correct?"                     | `/debugging`                     | `/testing`, `/review`             |
| "Is this well-designed?"               | `/design`                        | `/naming`, `/adr`                 |
| "Is this well-tested?"                 | `/testing`                       | `/review`                         |
| "Is this well-named?"                  | `/naming`                        | `/design`, `/prose`               |
| "Is this well-written?"                | `/prose`                         | `/review`                         |
| "Is this fast enough?"                 | `/performance`                   | `/debugging`                      |
| "Should we document this decision?"    | `/adr`                           | `/review`, `/research`            |
| "What should we use?"                  | `/research`                      | `/adr`                            |
| "Can people find this?"                | `/ia`                            | `/naming`, `/design`              |
| "How should I visualize this?"         | `/mermaid`                       | `/excalidraw`                     |
| "Does this vibe-coded output hold up?" | `/vibe-check`                    | `/review`, `/naming`              |
| "Cut my output, save tokens"           | `/caveman`                       | `/prose`                          |
| "I'm lost in this code"                | `/zoom-out`                      | `/naming`, `/design`              |
| "Where should we refactor?"            | `/improve-codebase-architecture` | `/zoom-out`, `/naming`, `/design` |
| "Stress-test this plan with me"        | `/grill-with-docs`               | `/naming`, `/adr`, `/research`    |

## Recipes

Recipes teach Bach (a multi-agent orchestrator) how to decompose a domain task into parallel workers. Each recipe defines worker scope boundaries, prompt templates, and a synthesis step for the manager.

| Skill          | Recipe                  | Workers |
| -------------- | ----------------------- | ------- |
| `/review`      | `review/RECIPE.md`      | 3       |
| `/design`      | `design/RECIPE.md`      | 3       |
| `/research`    | `research/RECIPE.md`    | 2       |
| `/debugging`   | `debugging/RECIPE.md`   | 2       |
| `/testing`     | `testing/RECIPE.md`     | 2       |
| `/performance` | `performance/RECIPE.md` | 2       |
| `/prose`       | `prose/RECIPE.md`       | 3       |

## Cross-References

Skills that pair naturally:

- `/review` + `/naming` — Code review surfaces naming problems; naming review deepens code review
- `/adr` + `/research` — Research informs the decision; ADR captures it
- `/testing` + `/debugging` — Test failures trigger debugging; debugging reveals missing tests
- `/design` + `/naming` — Hard-to-name things signal design problems
- `/prose` + `/review` — Review captures context; prose makes it clear
- `/performance` + `/debugging` — Performance regressions are bugs; profiling is debugging for speed
- `/ia` + `/naming` — IA labeling problems are naming problems; naming reveals structural confusion
- `/mermaid` + `/excalidraw` — Mermaid for inline docs (GitHub-native); Excalidraw for architecture overviews (hand-drawn, editable)
- `/mermaid` + `/design` — Diagram layout is visual design; the same composition principles apply
- `/vibe-check` + `/review` — Vibe-check is the quick pre-commit read; review is the deep post-push audit
- `/vibe-check` + `/naming` — Shallow naming findings in vibe-check warrant a full naming pass
- `/caveman` + `/prose` — Caveman is Strunk's "omit needless words" at maximum setting; /prose for prose that has to read well, /caveman when only signal matters
- `/zoom-out` + `/naming` — Zoom-out renders the map in the codebase's own vocabulary; /naming is what gives that vocabulary teeth
- `/zoom-out` + `/research` — Zoom-out maps the inside of the system; /research maps the outside
- `/improve-codebase-architecture` + `/grill-with-docs` — Architectural candidates are the _what_; grill-with-docs is the _how_ of walking the design tree with the user
- `/grill-with-docs` + `/adr` — Grill-with-docs offers lightweight inline ADRs during a session; /adr writes the heavyweight Nygard-style record when a decision needs full context
- `/improve-codebase-architecture` + `/zoom-out` — Render the map first; then propose which modules to deepen against that map
