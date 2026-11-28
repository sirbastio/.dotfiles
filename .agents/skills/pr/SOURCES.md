# Pull request: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea. These rules were step 6 of `../agent-verify/SKILL.md` until they were split out. Rows are grouped by step, not always in order.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub. "Guide 06" is `docs/guide/06-verify-and-ship.md` there.
- **Phillipe**: asked for while the skill was being written, or carried from his own rules and from prepr's `pr-handover` skill.
- **Claude**: wording or a choice made while drafting, from neither set of skills.

| Step | Idea | Source |
|---|---|---|
| Opening lines | Its own skill, loaded whenever a pull request is written | Matt: `pr` ("Use when writing a PR body"). poteto: "Opening a PR" playbook ("Invoked at the end of every other playbook"). Phillipe: asked for the split |
| | The project's template headings win | Phillipe: prepr's rule that a description fills its template. Matt's `pr` ships its own template instead |
| 1. Open with what is left for the reader | The first line says what is left for the reader, above every heading | Phillipe: the checks he had to run were hard to find, under two headings and inside a collapsed block (prepr's pull requests 270 to 279) |
| | One `- [ ]` task per thing left, never collapsed | Claude: GitHub counts the tasks in its pull request list, and Review's step 5 already ticks what held |
| | One `Not checked:` line, and no gap named anywhere else | Claude, from prepr's pull requests 274 and 276, where gaps sat in the evidence, under Risk and in the collapsed block |
| 5. Check it | Read in a minute: 250 words outside the collapsed block, checked by `pr-check.sh` | poteto: "Opening a PR" playbook ("a one-minute briefing under 40 lines"). Phillipe: the pull requests had grown to 60 to 80 lines. The first limit was 40 lines, which prepr's pull requests 270 to 279 kept while running 360 to 700 words, so it counts words, and a script does the counting |
| | Drop a heading with nothing under it | poteto: "Opening a PR" playbook ("dropping empty ones") |
| | The project's own terms, from its glossary | Matt: `pr` ("Use the user's domain language from `GLOSSARY.md`") |
| | Too big for the space: say so and where it could be split | Cursor's team kit: `make-pr-easy-to-review` ("recommend splitting instead of polishing around the problem"). poteto: "Opening a PR" playbook ("Stack follow-ups"). Claude: so the 40 lines have a way out other than cramming |
| 2. Say what changed and why | A picture or up to five bullets, never both | Claude, from prepr's pull request 246, where bullets restated the tree. Matt: `pr` ("keep prose brief") |
| | Say what changed and why | poteto: "Opening a PR" playbook. Matt: `pr` |
| | Link the plan's issue | Cursor's team kit (`cursor-team-kit` in `cursor/plugins`): `make-pr-easy-to-review` ("Link issue trackers... when they explain intent"). Review's step 1 reads the plan from it |
| | Open with the smallest picture that shows the change | Matt: `pr` (Summary), credited there to Dex Horthy's `show-me` skill |
| | Mark the picture as a diff where it alters what was there | Matt: `pr` (Summary: "Use `diff` when the point is what changes and the surrounding shape already exists") |
| 4. Leave out | A choice the reader wouldn't overturn | poteto: "Opening a PR" playbook (Tradeoffs: "only rejected alternatives a reviewer would otherwise ask about"). A line, not a heading |
| | Risk in a line or two: whether it can be undone, and what it could break | Matt: `pr` (Merge Danger). poteto: "Opening a PR" playbook (Blast Radius). Here because Review is optional, so the pull request must be enough to decide on |
| 3. Fold the evidence away | Per check: what was done, what was seen, the screenshot or output | Phillipe: reviews evidence, not code. poteto: guide 06. Matt: `pr` (Evidence) |
| | Leave out the project's own checks, which CI shows | Claude, from prepr's pull request 246, which listed typecheck, lint and Jest |
| | The before beside the after where one was captured | Matt: `pr` (Evidence) |
| | Name the commit the evidence was captured at | Claude, so Review can tell what changed since. poteto: "Shipping" playbook ("A verdict covers a patch") |
| | One line and one capture stay open; the rest is collapsed | Phillipe: "a bunch of stuff saying how it's verified" hid what was left to do. Matt: `pr` (Evidence is one before and after, not a list of every check). It used to be the other way round: the evidence open and the unrun checks collapsed |
| 4. Leave out | How the work went; files, docs and tests touched; a risk that restates the change | Claude, from prepr's pull requests 273 to 279, which carried review history, lists of docs touched and counts of phrases run. Matt: `pr` ("Skip all preambles and keep prose brief") |
| 6. Open it | Ready, not as a draft | Phillipe: "always ready", also when a check was not run. poteto: "Opening a PR" playbook ("Open PRs ready"). The line had gone missing from Verify |
| | An open pull request is updated, not opened again | Phillipe: often runs Verify on a branch whose pull request is already up |
| 7. Attach the captures | Upload screenshots with `gh`'s `--attach` | GitHub CLI 2.99 (September 2026). Phillipe: no pull request had carried a screenshot of the running app |
| | Set each screenshot's width with `pr-image-width.sh` (260 for a phone, about 600 for a desktop window), a before and after in one table row | Phillipe: the images in prepr's test pull request 254 were too big. Claude: a script, because `--attach` doesn't rewrite an `<img>` tag, so the width has to be set after the upload |
| | The script moves an image under its text, outside a table | Phillipe: in prepr's pull request 285 each check's sentence wrapped around its screenshot. Claude: in the script, since a written rule about line breaks is one an agent forgets |
| | A video goes up the same way, cut to the seconds that show the check | Phillipe: asked whether `gh` takes video. Tried on prepr's pull request 254, where five seconds of a phone screen came to 2 MB and showed as a player. poteto: guide 06 asks for video as proof |
| | Never merge | Phillipe |
