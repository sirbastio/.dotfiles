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
| 6. Check and hand on | Read the whole diff once and take out what shouldn't ship | poteto: `deslop`, in the `cursor-team-kit` plugin of `cursor/plugins` |
| | Once for the branch, not once per commit | poteto: `deslop`. Phillipe asked for the loop to be faster |
| | Run the project's full checks | Matt: `implement`. Phillipe |
| | Go on to Verify | Phillipe |
| | Then push and open the pull request | Phillipe |
| | Say what changed, why, and how it was checked | poteto: "Opening a PR" playbook. Matt: `pr` |
| | Say what couldn't be checked from this machine, as steps to follow | Phillipe: prepr's `pr-handover` ("To check in the simulator") |
| | Never merge | Phillipe |
| | Tell the user the outcome, the decisions and what isn't done | Phillipe |
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
| A fresh agent strips the comments | poteto: `no-comments` | Belongs to Review |
| A sub-agent per issue in its own worktree | Matt: `implement-spec`. poteto: "Feature" playbook | Running several builds at once is a different skill |
| Code review at the end of the build | Matt: `implement` | Belongs to Review |
| Proof on the real thing | poteto: `principle-prove-it-works` | Belongs to Verify |
| Name the data and its types before writing logic | poteto: `principle-foundational-thinking`, `principle-model-the-domain` | Left to the agent |
| Fake only what can't be run | Matt: `tdd/mocking.md`. poteto: `typescript-best-practices` | Left to the agent |
| Use the glossary's terms for names in code and tests | Matt: `tdd` | Left to the agent |
| Shape the types so a wrong state can't be written | poteto: `principle-type-system-discipline`, `principle-model-the-domain` | Left to the agent |
| Do a run of the same edit with a script | poteto: `principle-build-the-lever` (summary only, not read in full) | Left to the agent |
| Bug: read the real state instead of guessing, and revert what didn't fix it | poteto: "Bug fix" playbook | Left to the agent |

Step 6 leads on to the Verify skill, which doesn't exist yet.
