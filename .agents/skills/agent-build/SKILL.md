---
name: agent-build
description: Build a planned change in small tested units, review the code, then hand it to Verify.
disable-model-invocation: true
---

# Build

Every rule here is a default. The project's own rules win, and a step the project has nothing for is skipped.

## 1. Read the plan

- Read the plan or issue the user names, and say its title.
  - With no plan, follow `../agent-plan/SKILL.md` first.
  - If it stops at "small and obvious", build without one.
- Its acceptance checks are the finish line.
- List any access or secrets the work will need.

## 2. Get on a branch

- If the session started on a branch made for this work, stay on it.
  - Otherwise follow the project's branch rule.
- With none, start a new branch from the main branch, up to date.
- If other work is under way in the same checkout, build in a worktree with a branch of its own.
  - Say the branch at the end.
  - Remove the worktree once its branch is merged or abandoned.

## 3. Prepare the ground

- Remove dead code the change would build on, as its own commit.

## 4. Build one unit at a time

A unit is one behaviour: its test and its code.

- Write the test first and watch it fail for the reason you expect.
- Write the least code that passes it.
- Run that test and the type check. Move on only when both pass.
- Commit the unit. Commit only what you changed.
  - On a machine that won't outlast the session, push the branch after each commit.
- Never write all the tests first.
- Where a test would be costly or brittle, or the project has no tests, use the closest thing that runs (a script, a command) and say so.
  - No test is better than a bad one.

For a bug:

- Reproduce it first.
  - The failing test is the reproduction, and is committed before the fix.
- Fix it where it first went wrong, not where it showed.
- Look for the same fault elsewhere.

For a change of structure only:

- Pin today's behaviour with a test before moving anything.
- Move every caller and delete the old way in the same change.
- After a rename, search for the old name in strings and docs too.

## 5. Record

- Write the plan's "To record" items into the project's decision record and glossary, where it keeps them, in the same change.

## 6. Check

- Read the whole diff against the main branch once.
  - Take out leftovers from earlier attempts, unrelated edits, and anything that doesn't match the code around it.
- Run the project's full checks and fix what they find.

## 7. Review the code

On a small change, skip this step.

- Give the diff to fresh sub-agents, one question each:
  - **Bugs**: try to break the change.
    - A finding counts only when a run shows it.
  - **Plan**: what's missing, what wasn't asked for, and what's built wrong.
    - Each finding quotes the plan's line.
  - **Rules**: where it breaks the project's written rules, comments included.
    - Each finding names the rule.
    - Skip what the project's tooling already enforces.
- No findings is a valid result.
- Fix what is found.

## 8. Hand on

- Follow `../agent-verify/SKILL.md`.
  - It proves the change, opens the pull request and tells the user the outcome.

## While building

- Keep going until the work is done. 
  - Stop only when blocked, or for a decision that can't be undone.
  - Make the decisions that can be undone, and list them at the end.
- A bug or missing feature found on the way is noted as a follow-up, unless the change can't work without it.
- When the user corrects you, fix it, then make the mistake impossible: a type, a lint rule or a test before a written rule.

## Tests

- A test states what someone using the code can see, through its public interface.
- It fails when that behaviour breaks, and passes when only the insides change.
- The expected value comes from the requirement, never worked out the way the code does it.
- Never weaken a test to fit the code.

## Code

- Make the smallest change that meets the goal.
- Check data where it enters the program, and trust the types inside.
- Don't comment the project's own code. Rename, extract or type until it needs no comment.
  - Keep a comment only for:
    - a licence header,
    - behaviour forced by a dependency, platform, vendor or protocol,
    - a doc comment that defines a public contract,
    - a link to an issue that explains a constraint code can't express,
    - in tests, a caption above a step that says what it checks.
- Never switch off a lint or type rule that guards correctness.
