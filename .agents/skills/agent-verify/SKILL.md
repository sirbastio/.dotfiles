---
name: agent-verify
description: Prove a change works on the real thing, then open its pull request with the evidence.
disable-model-invocation: true
---

# Verify

Every rule here is a default. The project's own rules win, and a step the project has nothing for is skipped.

Tests and the project's checks belong to Build. This is proof on the real thing.

## 1. List the checks

- Use the plan's acceptance checks.
  - With no plan, write the checks from the diff before running anything.
- Add a check for each state the change touches.
  - On a screen: empty, filled, long text, error, and the keyboard open where there's a text field.
- Each check is a scenario and what must be seen.
  - It names the data it needs.
  - It must be able to fail on this change.

## 2. See what can run here

- Sort each check: 
  - This machine can run it.
  - It needs a tool this machine lacks, such as a simulator or a browser.
- If the project has a verify skill (`verify-<project>`), read it first, and launch, drive and capture its way.
  - With none, say so at the end and name `../verify-setup/SKILL.md`.
- Confirm it's running this change before driving it.

## 3. Pick the checker

- Give the checks that can run here to a fresh sub-agent.
  - It gets the checks, and nothing of how the change was built.
  - On a small change, check them yourself.
- A check that can't run here goes to step 6 as "not run here".

## 4. Run each check

- Match the check to the change.
  - A command: run it.
  - A screen: walk the flow.
  - Saved data: read the stored value back.
- Take the path a user takes, never an internal shortcut.
- Capture the action and its result, not only the final screen.
  - Capture any side effect too.
  - Take a screenshot, or record a video where the check is about how something moves or a flow of several steps.
  - Where the change alters what was already there, capture the before as well.
- Script the check when you can, so it can be run again.
- For a bug, rerun the original reproduction.

## 5. Judge each one

- Each check held, failed or was not run here.
- When one fails, suspect how you looked before the code.
  - If the project's verify skill was wrong, fix it in the same change.
  - Then fix it the way `../agent-build/SKILL.md` builds, and run every check again.
- When two fixes for the same check have failed, write down what both assumed and test that before a third.
  - If it still fails, stop and report, without a pull request.
- Never weaken a check to make it pass.

## 6. Open the pull request

- Stop only what you started, and keep the evidence.
- When the change alters a screen, a command, or anything the project's verify skill names, update that skill and its feature map in the same change.
- Once no check has failed, open the pull request the way `../pr/SKILL.md` does, where the project uses them.
  - Push and open it without asking: starting this skill is the go-ahead.
- Tell the user the outcome, what you decided, and what isn't done.
  - With no pull request, the evidence goes in the reply.
