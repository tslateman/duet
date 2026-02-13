# Frameworks Index

Each duet skill is grounded in a specific framework or authority. This index maps the intellectual foundations to the skills that apply them.

## Skills by Framework

| Framework                | Authority                    | Skill                | Core Idea                                                          |
| ------------------------ | ---------------------------- | -------------------- | ------------------------------------------------------------------ |
| 9 Rules of Debugging     | David J. Agans               | `/diagnose`          | Scientific method applied to software failures                     |
| Test Desiderata          | Kent Beck                    | `/testing`           | 12 properties every test balances; make tradeoffs deliberate       |
| Elements of Style        | William Strunk Jr.           | `/prose`             | Active voice, omit needless words, be specific                     |
| Naming Principles        | Benner                       | `/naming`            | Understandability, conciseness, consistency, distinguishability    |
| API Design               | Joshua Bloch                 | `/naming`, `/design` | Self-documenting, least astonishment, minimal surface              |
| Ubiquitous Language      | Eric Evans (DDD)             | `/naming`            | Code names match domain language                                   |
| ADR Format               | Michael Nygard               | `/adr`               | Capture context and reasoning, not just the decision               |
| Testing Trophy           | Kent C. Dodds                | `/testing`           | Integration tests provide the best confidence-to-cost ratio        |
| Performance Loop         | —                            | `/performance`       | Measure, profile, optimize, measure again                          |
| Knuth's Rule             | Donald Knuth                 | `/performance`       | Optimize the critical 3%, not the other 97%                        |
| Information Architecture | Rosenfeld, Morville & Arango | `/ia`                | Organization, labeling, navigation, search for findability         |
| Diataxis                 | Daniele Procida              | `/ia`                | Four documentation modes: tutorial, how-to, explanation, reference |
| Mermaid.js v11           | Mermaid project              | `/mermaid`           | Text-based diagrams that render natively in GitHub markdown        |
| Excalidraw Generator     | Excalidraw project           | `/excalidraw`        | Programmatic hand-drawn diagrams via Python API                    |

## Skills by Concern

| Concern                             | Primary Skill  | Supporting Skills      |
| ----------------------------------- | -------------- | ---------------------- |
| "Is this correct?"                  | `/diagnose`    | `/testing`, `/review`  |
| "Is this well-designed?"            | `/design`      | `/naming`, `/adr`      |
| "Is this well-tested?"              | `/testing`     | `/review`              |
| "Is this well-named?"               | `/naming`      | `/design`, `/prose`    |
| "Is this well-written?"             | `/prose`       | `/review`              |
| "Is this fast enough?"              | `/performance` | `/diagnose`            |
| "Should we document this decision?" | `/adr`         | `/review`, `/research` |
| "What should we use?"               | `/research`    | `/adr`                 |
| "Can people find this?"             | `/ia`          | `/naming`, `/design`   |
| "How should I visualize this?"      | `/mermaid`     | `/excalidraw`          |

## Cross-References

Skills that pair naturally:

- `/review` + `/naming` — Code review surfaces naming problems; naming review deepens code review
- `/adr` + `/research` — Research informs the decision; ADR captures it
- `/testing` + `/diagnose` — Test failures trigger debugging; debugging reveals missing tests
- `/design` + `/naming` — Hard-to-name things signal design problems
- `/prose` + `/review` — Review captures context; prose makes it clear
- `/performance` + `/diagnose` — Performance regressions are bugs; profiling is debugging for speed
- `/ia` + `/naming` — IA labeling problems are naming problems; naming reveals structural confusion
- `/mermaid` + `/excalidraw` — Mermaid for inline docs (GitHub-native); Excalidraw for architecture overviews (hand-drawn, editable)
- `/mermaid` + `/design` — Diagram layout is visual design; the same composition principles apply
