# Plan: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub.
- **Phillipe**: asked for while the skill was being written.
- **Claude**: wording or a choice made while drafting, from neither set of skills.

| Step | Idea | Source |
|---|---|---|
| 1. Settle the decisions | Run Scope first if they haven't been asked | Phillipe |
| | Stop too if Scope stops at "small and obvious" | poteto: "Multi-phase plan" playbook |
| 2. Write the plan | The plan goes in the reply | Claude |
| | In the project's own terms | Matt: `to-spec`, `grill-with-docs` |
| | Behaviour and decisions, no file paths or code | Matt: `to-spec` |
| | Goal | Matt: `to-spec` (problem statement) |
| | What changes, as someone using it would meet it | Matt: `to-spec` (solution) |
| | Acceptance checks: a concrete scenario and what must be seen | poteto: "Multi-phase plan" playbook |
| | A passing test suite is not proof | poteto: "Multi-phase plan" playbook |
| | Each check is one the agent can run itself | poteto: `poteto-mode` ("Never hand the human a check you could run"), "Autonomous run" playbook |
| | Left out | Matt: `to-spec` (out of scope) |
| | Decided | Matt: `to-spec` (implementation decisions). poteto: "Prototype" playbook |
| | Unproven | poteto: "Multi-phase plan" playbook |
| | To record: decisions and new terms | Matt: `grill-with-docs` |
| | The build writes them, not the plan | Claude |
| 3. Confirm and publish | Ask the user to confirm the plan | Matt: `grilling`. poteto: "Multi-phase plan" playbook |
| | Publish it as an issue | Matt: `to-spec`. Phillipe chose issues |
| | No tracker: a file, deleted when the work lands | poteto: "Multi-phase plan" playbook |
| | Offer to split work too big for one session | Matt: `to-tickets`. Claude linked the two skills |

Step 1 is an exit when Scope stops at "small and obvious": no plan is written. Step 3 is the other: on to the Split skill, when the work is big.
