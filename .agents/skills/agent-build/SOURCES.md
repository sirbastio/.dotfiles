# Build: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub.
- **Phillipe**: asked for while the skill was being written, or carried from his own rules.
- **Claude**: wording or a choice made while drafting, from neither set of skills.

| Step | Idea | Source |
|---|---|---|
| Opening line | Every rule is a default, the project's rules win, a missing step is skipped | Phillipe |
| 1. Read the plan | Read the plan or issue and say its title | Matt: `implement` |
| | With no plan, go to Plan first | Phillipe |
| | If Plan stops at "small and obvious", build without one | Claude, following Plan's own exit |
| | Its acceptance checks are the finish line | Phillipe. poteto: "Multi-phase plan" playbook |
| | A branch that already has commits for the plan: read them and carry on, don't redo what landed | poteto: "Session pickup" playbook. Loose: hers reads the earlier session's transcript too. Matt's `handoff` writes a note for the next session instead |
| | List the access or secrets needed | Phillipe |
| 2. Get on a branch | Stay on a branch the session was started on for this work | Phillipe asked for cloud sessions to be covered. Claude's wording |
| | Follow the project's branch rule | Phillipe |
| | With none, a new branch from the main branch | poteto: "Opening a PR" playbook. Matt: `implement-spec` |
| | A worktree with its own branch when other work shares the checkout | Phillipe. Matt: `implement-spec`. poteto uses one always: "Opening a PR" playbook |
| | Say the branch at the end, and remove the worktree once merged or abandoned | Phillipe. Matt: `implement-spec` (clean-up) |
| 3. Prepare the ground | Remove dead code first, as its own commit | poteto: `principle-subtract-before-you-add`, "Refactoring" playbook |
| 4. Build one unit at a time | A unit is one behaviour, its test and its code | Matt: `tdd` ("one slice at a time"). Phillipe: test in the same change |
| | Test first, and watch it fail for the expected reason | Matt: `tdd`, for all work. poteto: `tdd`, for bugs with a cheap test only. Phillipe chose Matt's, since the plan gives the tests something to check against |
| | The least code that passes | Matt: `tdd`. poteto: `tdd` |
| | Run that test and the type check before moving on | Matt: `implement`. poteto: `principle-sequence-verifiable-units` |
| | Commit each unit | poteto: `principle-sequence-verifiable-units`. Phillipe |
| | Commit only what you changed | Phillipe |
| | Push after each commit on a machine that won't outlast the session | Claude, for cloud sessions |
| | Never all the tests first | Matt: `tdd` ("horizontal slicing"): a test needs the code's shape, which the plan doesn't give |
| | Where a test is costly, use the closest thing that runs | poteto: `tdd` |
| | The same when the project has no tests | Claude |
| | No test is better than a bad one | poteto: `tdd` |
| | Bug: reproduce first, and commit the failing test before the fix | poteto: "Bug fix" playbook, `principle-sequence-verifiable-units` |
| | Bug: fix it where it first went wrong | poteto: `principle-fix-root-causes`. Phillipe |
| | Bug: look for the same fault elsewhere | poteto: `principle-fix-root-causes` |
| | Structure only: pin today's behaviour first | poteto: "Refactoring" playbook |
| | Structure only: move every caller and delete the old way | poteto: `principle-migrate-callers-then-delete-legacy-apis` |
| | Structure only: after a rename, search strings and docs for the old name | poteto: "Refactoring" playbook |
| 5. Record | Write the plan's "To record" items in the same change | Phillipe. Matt: `grill-with-docs` |
| 6. Check | Read the whole diff once and take out what shouldn't ship | poteto: `deslop`, in the `cursor-team-kit` plugin of `cursor/plugins` |
| | Once for the branch, not once per commit | poteto: `deslop`. Phillipe asked for the loop to be faster |
| | Run the project's full checks | Matt: `implement`. Phillipe |
| 7. Review the code | Have the code reviewed before the pull request, and fix what is found | Matt: `implement` (ends with `code-review`). Phillipe: global rule to run `/code-review` and fix before handing over. Review is optional, so it can't wait for Review |
| | Fresh sub-agents, one question each | Matt: `code-review` (two parallel sub-agents) |
| | Bugs: try to break the change | poteto: `interrogate` ("Break this change"). Loose: hers is a panel of different models, this is one sub-agent |
| | A bug finding counts only when a run shows it | poteto: `interrogate` ("Leave out anything you did not run") |
| | Plan: what's missing, what wasn't asked for, what's built wrong | Matt: `code-review` (Spec) |
| | Each plan finding quotes the plan's line | Matt: `code-review` ("Quote the spec line for each finding") |
| | Rules: where it breaks the project's written rules | Matt: `code-review` (Standards), without his list of code smells |
| | Comments included | poteto: `no-comments`. Phillipe |
| | Each rules finding names the rule | Matt: `code-review` ("cite the standard") |
| | Skip what the project's tooling already enforces | Matt: `code-review` |
| | No findings is a valid result | poteto: `interrogate` |
| | On a small change, skip the review | Claude. Phillipe: small tasks aren't forced through every stage, and his global rule names logic, data and server changes only |
| 8. Hand on | Go on to Verify, which opens the pull request and tells the user the outcome | Phillipe |
| While building | Keep going, and stop only when blocked or for what can't be undone | Phillipe. poteto: `poteto-mode` ("Autonomy") |
| | Make the decisions that can be undone and list them | Phillipe. poteto: `worker.md` |
| | A bug or missing feature found on the way is a follow-up | poteto: "Refactoring" playbook, where it covers refactors only. Claude stretched it to all work |
| | Unless the change can't work without it | Claude. Phillipe asked why not |
| | A correction becomes a type, lint rule or test before a written rule | Phillipe. poteto: `correct`, `principle-encode-lessons-in-structure` |
| Tests | A test states what a user of the code can see | Matt: `tdd`. poteto: `principle-test-behavior-not-implementation`. Phillipe |
| | Fails when the behaviour breaks, passes when only the insides change | poteto: `principle-test-behavior-not-implementation` |
| | The expected value comes from the requirement | Matt: `tdd` ("tautological"). poteto: `principle-test-behavior-not-implementation` |
| | Never weaken a test to fit the code | poteto: `tdd` |
| Code | The smallest change that meets the goal | poteto: `principle-laziness-protocol` |
| | Check data where it enters, trust the types inside | poteto: `principle-boundary-discipline`, `principle-type-system-discipline` |
| | No comments in the project's own code; reshape it instead | Phillipe. poteto: `no-comments` |
| | The keep list | poteto: `comment-sicko`. Phillipe added the test caption |
| | Never switch off a rule that guards correctness | poteto: `comment-sicko`. Phillipe |

Left out, and why:

| Idea | Source | Why |
|---|---|---|
| Agree with the user where the tests go | Matt: `tdd` | A question round before every build |
| Tidying belongs to review, not the loop | Matt: `tdd` | Covered by the smallest change and the read of the whole diff in step 6 |
| A fresh agent that only strips comments | poteto: `no-comments` | Folded into the Rules question in step 7 |
| A sub-agent per issue in its own worktree | Matt: `implement-spec`. poteto: "Feature" playbook | Running several builds at once is a different skill |
| A fixed list of code smells for the reviewer | Matt: `code-review` | The project's written rules only |
| Use the tool's own code review, such as Claude Code's `/code-review` | Phillipe: global rule | Phillipe cut it, to follow Matt and poteto instead |
| Report the reviews side by side and never merge them into one ranking | Matt: `code-review` | The build fixes the findings, it doesn't report them |
| A panel of different models reviewing the same diff | poteto: `interrogate`, `arena` | One reviewer per question |
| Ask the user about any finding on security, data or sign-in | poteto: `bugbot-triage` | The build doesn't stop for it. Review keeps the line |
| Proof on the real thing | poteto: `principle-prove-it-works` | Belongs to Verify |
| Name the data and its types before writing logic | poteto: `principle-foundational-thinking`, `principle-model-the-domain` | Left to the agent |
| Fake only what can't be run | Matt: `tdd/mocking.md`. poteto: `typescript-best-practices` | Left to the agent |
| Use the glossary's terms for names in code and tests | Matt: `tdd` | Left to the agent |
| Shape the types so a wrong state can't be written | poteto: `principle-type-system-discipline`, `principle-model-the-domain` | Left to the agent |
| Do a run of the same edit with a script | poteto: `principle-build-the-lever` (summary only, not read in full) | Left to the agent |
| Bug: read the real state instead of guessing, and revert what didn't fix it | poteto: "Bug fix" playbook | Left to the agent |
| Grade review findings as critical, warning or note | Cursor's team kit: `review-and-ship` | The build fixes what is found, it doesn't report it |
| Regroup commits in dependency order before review | Cursor's team kit: `make-pr-easy-to-review` | Each unit is already its own commit |

Read after step 7 was written, so not a source: `review-and-ship` in Cursor's team kit (`cursor-team-kit` in `cursor/plugins`). It reviews for correctness, regressions, security and fit to intent with parallel sub-agents, and fixes the critical findings before the pull request, which is the same shape as step 7.

Step 8 is the exit: on to the Verify skill, which opens the pull request. The pull request lines that were here moved to Verify's step 6.
