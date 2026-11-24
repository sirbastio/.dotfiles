# Review: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub.
- **Phillipe**: asked for while the skill was being written, or carried from his own rules and from prepr's `pr-handover` skill (its Checker role).
- **Claude**: wording or a choice made while drafting, from neither set of skills.

Review is optional. Phillipe: "Most of the work should be done by here, so I won't always use review, but if I decide to or not all checks could be run, then I will." So nothing that must happen every time lives here: the code review is in Build's step 7, and the risk line is in Verify's pull request.

| Step | Idea | Source |
|---|---|---|
| Opening lines | Every rule is a default, the project's rules win, a missing step is skipped | Phillipe, as in Build |
| | Run by a session that didn't build the change | poteto: "Shipping" playbook ("an author checks what it meant to build") |
| 1. Read the pull request | Read its description and diff | Phillipe: `pr-handover` (Checker) |
| | Read the plan it came from | Matt: `code-review` ("Identify the spec source") |
| | Get on its branch | Phillipe: `pr-handover` (Checker) |
| | Its evidence covers the code at the commit it names, so note what changed since | poteto: "Shipping" playbook ("A verdict covers a patch"). Verify's step 6 names the commit |
| 2. Run what Verify couldn't | Work down the checks not run | Phillipe: `pr-handover` (Checker) |
| | The way Verify runs and judges a check | Claude, so the method is written once |
| | Rerun any check whose code changed since its evidence | poteto: "Shipping" playbook. Loose: she compares patches exactly, this is a judgement |
| | A check this machine can't run either stays not run | Claude |
| 3. Look past the list | Open each changed screen or command once more and try what the checks don't name | Phillipe: `pr-handover` (Checker) |
| | A finding counts only when a run shows it | poteto: `interrogate` ("Leave out anything you did not run") |
| | Review the code again only if the user asks | Claude. The code review itself is in Build, as Matt's `implement` has it |
| 4. Fix or send back | A small slip is fixed on the branch | Phillipe: `pr-handover` (Checker) |
| | So is a proven bug, the way Build builds, with the checks it touches rerun | Claude |
| | A wrong approach, or anything that changes behaviour, is a comment and stays unfixed | Phillipe: `pr-handover` (Checker) |
| | A finding about security, data or sign-in: ask the user | poteto: `bugbot-triage` ("Ask by default"). Loose: she says it of a review bot's comments |
| 5. Give the verdict | Update the description: tick what held, note what was seen where it didn't | Phillipe: `pr-handover` (Checker) |
| | Pass, pass with notes, or fail | poteto: "Shipping" playbook |
| | What only the user can judge: how a screen looks, and checks still not run | Phillipe |
| | Never merge | Phillipe: "I will decide to merge or take further action". poteto: "Babysit" playbook |

Left out, and why:

| Idea | Source | Why |
|---|---|---|
| Review every pull request | poteto: "Shipping" playbook | Phillipe: optional, for when he chooses or when checks couldn't run |
| Prove every check again before merge | poteto: "Shipping" playbook | Only what Verify couldn't run, or what changed since |
| The code review | Matt: `code-review`. poteto: `interrogate`, `no-comments` | In Build's step 7, so it runs even when Review doesn't |
| The risk line | Matt: `pr`. poteto: `blast-radius` | In Verify's pull request, for the same reason |
| CI failures, conflicts and a review bot's comments | poteto: "Babysit" playbook, `bugbot-triage` | Claude Code's `/steward` handles them |
| An agent merges once the verdict passes | poteto: "Shipping" playbook | Phillipe merges |
| Proving the one fact a change is safe because of | poteto: `blast-radius` | Only its question, "what could it break", is kept, in Verify's risk line |
| Turning a session's mistakes into checks and rules | Matt: `retro` | A different skill |

Not read in full: poteto's `comment-sicko` agent and her `arena` skill.

Read after this skill was written, so not a source: Cursor's team kit (`cursor-team-kit` in `cursor/plugins`). Its `review-and-ship` reviews before the pull request, which here is Build's step 7. Nothing in it covers a review after the pull request.

The skill ends at the verdict. Phillipe decides to merge or take further action.
