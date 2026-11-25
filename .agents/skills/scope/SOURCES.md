# Scope: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub.
- **Phillipe**: asked for while the skill was being written.
- **Claude**: wording or a choice made while drafting, from neither set of skills.

| Step | Idea | Source |
|---|---|---|
| Opening line | Facts are the agent's to find, decisions are the user's | Matt: `grilling` |
| 1. Restate the goal | Say the goal and the smallest change that meets it | poteto: `in-your-own-words`, `poteto-mode` |
| | Say so if the task isn't worth doing | poteto: `poteto-mode` ("No is an acceptable answer") |
| 2. Trace what the change touches | Trace the code and why it is that way | poteto: "Feature" playbook, `how`, `why`. Matt: `to-spec` |
| | Weigh whether each past decision still holds | Phillipe. Wording follows poteto: `why` |
| | Do each lookup in a separate agent | Matt: `grilling` |
| 3. Small and obvious: stop here | One or two files and one sensible approach: say so and stop | poteto: "Multi-phase plan" playbook |
| 4. Settle by running where possible | Run something instead of asking | poteto: "Prototype" playbook, `sharpen` |
| | The throwaway lives in a scratch folder outside the project | Claude |
| 5. Compare approaches | Sketch two approaches that differ | poteto: `architect` |
| | Where the change doesn't fit the design, one sketch is the design built as if it had been required from the start | poteto: `principle-redesign-from-first-principles`. Loose: hers is a rule to always redesign. Here it is one option the user chooses between, so it doesn't override the smallest change |
| | The agent recommends one | Phillipe. poteto: `architect` |
| | The user makes the final choice | Claude |
| 6. Ask for the decisions | Only decisions go to the user | poteto: "Multi-phase plan" playbook, `sharpen` |
| | "Anything that can't be undone" counts as a decision | Claude |
| | Ask for access and secrets the build will need | poteto: guide page "Run work while you sleep". Matt: `wayfinder`, `wizard` |
| | Ask in rounds, everything answerable now | Matt: `grilling` |
| | A recommended answer that "yes" accepts | Matt: `grilling` |
| | Done when nothing is assumed | Matt: `grilling` |
| 7. Hand over | List what was decided and what the throwaways showed | Claude |
| | Leads into Plan, and Plan can start here | Phillipe |

Step 3 is an exit: nothing further runs. Step 7 is the other: on to the Plan skill.
