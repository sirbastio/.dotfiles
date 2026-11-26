# Pull request: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea. These rules were step 6 of `../agent-verify/SKILL.md` until they were split out.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub. "Guide 06" is `docs/guide/06-verify-and-ship.md` there.
- **Phillipe**: asked for while the skill was being written, or carried from his own rules and from prepr's `pr-handover` skill.
- **Claude**: wording or a choice made while drafting, from neither set of skills.

| Step | Idea | Source |
|---|---|---|
| Opening lines | Its own skill, loaded whenever a pull request is written | Matt: `pr` ("Use when writing a PR body"). poteto: "Opening a PR" playbook ("Invoked at the end of every other playbook"). Phillipe: asked for the split |
| | The project's template headings win | Phillipe: prepr's rule that a description fills its template. Matt's `pr` ships its own template instead |
| 1. Keep it short | Read in a minute, 40 lines at most | poteto: "Opening a PR" playbook ("a one-minute briefing under 40 lines"). Phillipe: the pull requests had grown to 60 to 80 lines |
| | Drop a heading with nothing under it | poteto: "Opening a PR" playbook ("dropping empty ones") |
| | The project's own terms, from its glossary | Matt: `pr` ("Use the user's domain language from `GLOSSARY.md`") |
| | Too big for the space: say so and where it could be split | Cursor's team kit: `make-pr-easy-to-review` ("recommend splitting instead of polishing around the problem"). poteto: "Opening a PR" playbook ("Stack follow-ups"). Claude: so the 40 lines have a way out other than cramming |
| | Say nothing twice; a picture or bullets, never both | Claude, from prepr's pull request 246, where bullets restated the tree. Matt: `pr` ("keep prose brief") |
| 2. Say what changed and why | Say what changed and why | poteto: "Opening a PR" playbook. Matt: `pr` |
| | Link the plan's issue | Cursor's team kit (`cursor-team-kit` in `cursor/plugins`): `make-pr-easy-to-review` ("Link issue trackers... when they explain intent"). Review's step 1 reads the plan from it |
| | Open with the smallest picture that shows the change | Matt: `pr` (Summary), credited there to Dex Horthy's `show-me` skill |
| | Mark the picture as a diff where it alters what was there | Matt: `pr` (Summary: "Use `diff` when the point is what changes and the surrounding shape already exists") |
| | A turned-down alternative only where the reader would ask | poteto: "Opening a PR" playbook (Tradeoffs: "only rejected alternatives a reviewer would otherwise ask about"). A line, not a heading |
| | Risk in a line or two: whether it can be undone, and what it could break | Matt: `pr` (Merge Danger). poteto: "Opening a PR" playbook (Blast Radius). Here because Review is optional, so the pull request must be enough to decide on |
| 3. Show the evidence | Per check: what was done, what was seen, the screenshot or output | Phillipe: reviews evidence, not code. poteto: guide 06. Matt: `pr` (Evidence) |
| | Leave out the project's own checks, which CI shows | Claude, from prepr's pull request 246, which listed typecheck, lint and Jest |
| | The before beside the after where one was captured | Matt: `pr` (Evidence) |
| | Name the commit the evidence was captured at | Claude, so Review can tell what changed since. poteto: "Shipping" playbook ("A verdict covers a patch") |
| | Not run here: steps to follow and what must be seen, and the change is not verified | Phillipe: `pr-handover` (Author) |
| | Not verified is said before any evidence; the steps go in a collapsed block | Claude, agreed by Phillipe. The block is outside the 40 lines because Review works down it |
| 4. Open it | Ready, not as a draft | Phillipe: "always ready", also when a check was not run. poteto: "Opening a PR" playbook ("Open PRs ready"). The line had gone missing from Verify |
| | Upload screenshots with `gh`'s `--attach` | GitHub CLI 2.99 (September 2026). Phillipe: no pull request had carried a screenshot of the running app |
| | Set each screenshot's width with `pr-image-width.sh` (260 for a phone, about 600 for a desktop window), a before and after in one table row | Phillipe: the images in prepr's test pull request 254 were too big. Claude: a script, because `--attach` doesn't rewrite an `<img>` tag, so the width has to be set after the upload |
| | Never merge | Phillipe |
