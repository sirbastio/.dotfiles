---
name: verify
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
- Each check is a scenario and what must be seen.
  - It must be able to fail on this change.

## 2. See what can run here

- Sort each check: 
  - This machine can run it.
  - It needs a tool this machine lacks, such as a simulator or a browser.
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
- For a bug, rerun the original reproduction.

## 5. Judge each one

- Each check held, failed or was not run here.
- When one fails, suspect how you looked before the code.
  - Then fix it the way Build builds, and run every check again.

## 6. Open the pull request

- Stop only what you started, and keep the evidence.
- Once no check has failed, push and open the pull request, where the project uses them.
  - Say what changed and why.
  - For each check, say what was done and what was seen, with the screenshot or output.
  - For each check not run here, write the steps to follow and what must be seen, and say the change is not verified.
  - Never merge.
- Tell the user the outcome, what you decided, and what isn't done.
  - With no pull request, the evidence goes in the reply.
