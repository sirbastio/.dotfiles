# Verify: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub. "Guide 06" is `docs/guide/06-verify-and-ship.md` there.
- **Phillipe**: asked for while the skill was being written, or carried from his own rules and from prepr's `pr-handover` skill.
- **Claude**: wording or a choice made while drafting, from neither set of skills.

| Step | Idea | Source |
|---|---|---|
| Opening lines | Every rule is a default, the project's rules win, a missing step is skipped | Phillipe, as in Build |
| | Tests and checks are Build's, this is proof on the real thing | poteto: `principle-prove-it-works`. Plan already says a passing test suite is not the proof |
| 1. List the checks | The plan's acceptance checks are the list | Phillipe. poteto: guide 06 ("State the finish condition up front") |
| | With no plan, write them from the diff before running anything | Claude |
| | A check for each state the change touches | Phillipe: `pr-handover` ("To check in the simulator"), without its UI list |
| | A scenario and what must be seen | poteto: "Multi-phase plan" playbook, by way of Plan |
| | Each check names the data it needs | Phillipe: `pr-handover` ("Say what the data must be when it matters"). poteto: `create-verification-skill` feature-map example (Preconditions) |
| | Each check must be able to fail on this change | Matt: `diagnosing-bugs` ("red-capable"). Loose: he says it of a bug's reproduction, Claude stretched it to every check |
| 2. See what can run here | Sort each check by whether this machine can run it | Phillipe: the build may be in the cloud. Claude's wording |
| | Confirm it's running this change first | poteto: `create-verification-skill` (Doctor). Loose: her check is wider (process, port, version, auth) |
| | No project verify skill: say so at the end and name the set-up skill | Claude. It doesn't run set-up itself, so the build keeps moving |
| 3. Pick the checker | A fresh sub-agent that didn't build it | poteto: "Shipping" playbook ("an author checks what it meant to build"). Loose: hers is one cloud agent per pull request at merge time |
| | It gets the checks and nothing of how the change was built | Claude |
| | The builder checks a small change | Claude. Phillipe: small tasks aren't forced through every stage |
| | A check that can't run here is reported as not run | Phillipe: `pr-handover` (Author) |
| 4. Run each check | Match the check to the change | poteto: guide 06 |
| | The path a user takes, never an internal shortcut | poteto: `create-verification-skill` (Evidence) |
| | Capture the action and its result, and any side effect | poteto: `create-verification-skill` (Evidence) |
| | Where the change alters what was there, capture the before as well | Matt: `pr` (Evidence: before and after). poteto: guide 06 ("a before-and-after video"), "Shipping" playbook ("parent against head") |
| | Script the check when you can, so it can be run again | poteto: `principle-prove-it-works` |
| | Bug: rerun the original reproduction | Matt: `diagnosing-bugs`. poteto: "Bug fix" playbook |
| 5. Judge each one | Held, failed or not run here | poteto: guide 06 ("inconclusive"), `swarm` (PASS, ISSUES, BLOCKED) |
| | Failed: suspect how you looked before the code | poteto: `principle-prove-it-works` |
| | If the project's verify skill was wrong, fix it in the same change | poteto: `maintain-verification-skill` ("a doctor failure caused by skill drift is drift: fix it"). Here it happens when a run trips over it, not on a daily pass |
| | Then fix it and run every check again | Claude |
| | Never weaken a check to make it pass | poteto: `create-verification-skill` ("Never weaken the journey to make it pass"), "Autonomous run" playbook ("never relax the predicate") |
| 6. Open the pull request | Stop only what you started, and keep the evidence | poteto: `create-verification-skill` (Cleanup) |
| | A change to a screen, a command or anything the verify skill names updates that skill and its feature map in the same change | poteto: `maintain-verification-skill`, as one line instead of a daily pass. Phillipe: prepr's feature-map test, and he asked what happens when a change alters something Verify uses |
| | Verify opens the pull request, not Build | Phillipe: "verifies it the best it can, notes where it comes short and makes a PR". poteto: guide 06 has the same order |
| | Only once no check has failed. A check not run here doesn't stop it | Phillipe. Claude's wording |
| | Say what changed and why | poteto: "Opening a PR" playbook. Matt: `pr` |
| | Link the plan's issue | Cursor's team kit (`cursor-team-kit` in `cursor/plugins`): `make-pr-easy-to-review` ("Link issue trackers... when they explain intent"). Review's step 1 reads the plan from it |
| | Open with the smallest picture that shows the change | Matt: `pr` (Summary), credited there to Dex Horthy's `show-me` skill |
| | Per check: what was done, what was seen, the screenshot or output | Phillipe: reviews evidence, not code. poteto: guide 06. Matt: `pr` (Evidence) |
| | The before beside the after where one was captured | Matt: `pr` (Evidence) |
| | Name the commit the evidence was captured at | Claude, so Review can tell what changed since. poteto: "Shipping" playbook ("A verdict covers a patch") |
| | Not run here: steps to follow and what must be seen, and the change is not verified | Phillipe: `pr-handover` (Author) |
| | Risk: whether it can be undone, and what it could break | Matt: `pr` (Merge Danger). poteto: "Opening a PR" playbook (Blast Radius). Here because Review is optional, so the pull request must be enough to decide on |
| | Open it ready, not as a draft | Phillipe: "always ready", also when a check was not run. poteto: "Opening a PR" playbook ("Open PRs ready") |
| | Never merge | Phillipe |
| | Tell the user the outcome, the decisions and what isn't done | Phillipe |
| | With no pull request, the evidence goes in the reply | Claude |

Moved to `../agent-review/SKILL.md`, because checking a pull request someone else built is Review's job:

| Idea | Source |
|---|---|
| Start from the pull request's list of checks not run | Phillipe: `pr-handover` (Checker) |
| A session on someone else's pull request checks them itself, with no sub-agent | Claude |
| Look past the list: try what it doesn't name around the change | Phillipe: `pr-handover` (Checker) |
| Fix a small slip, send a wrong approach back as a comment | Phillipe: `pr-handover` (Checker) |
| Tick what held, and note what was seen where it didn't | Phillipe: `pr-handover` (Checker) |
| For how a screen looks, the user's own look is final | Phillipe |
| An agent that didn't write the code proves the pull request again before it merges | poteto: "Shipping" playbook |

Left out, and why:

| Idea | Source | Why |
|---|---|---|
| A per-project skill for launch, health check, drive, evidence and clean-up, with a feature map | poteto: `create-verification-skill`, `maintain-verification-skill` | Its own skill: `../verify-setup/SKILL.md` |
| A small driver agents call | poteto: guide 06 | Built when agents keep improvising the same steps, not part of Verify |
| Launch and drive it the project's own way, and reuse a running instance | Phillipe. poteto: `create-verification-skill` | Phillipe cut it. The opening line already puts the project's rules first |
| The UI states by name: empty, filled, long text, error, keyboard open | Phillipe: `pr-handover` | A project fact, not a method |
| "Looks right" is not a result | Phillipe: `pr-handover` | Step 6 already asks what was seen |
| A check run by a different path has not held | poteto: `create-verification-skill` feature-map example | "The path a user takes" already covers it |
| Several agents checking at once | poteto: `swarm` | One simulator at a time on Phillipe's machine |
| Pixel comparison against a frozen baseline | poteto: "Visual parity" playbook | Only for work that must match a reference |
| Vetting a measured number | poteto: `benchmark-checklist` | Only for performance work |
| Proving a property formally | poteto: `create-formal-verification-skill` | A different kind of proof |
| A script that walks a person through a check | Matt: `diagnosing-bugs` (`hitl-loop`) | Checks not run are written as steps instead |

Not read: poteto's talk "All Code Is Slop (Except Mine)". Her written guide was used in its place.

Step 6 is the exit: the pull request is open, or with none the evidence is in the reply. `../agent-review/SKILL.md` comes next, started by the user.
