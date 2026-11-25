---
name: agent-review
description: Review an open pull request another session built, by running the checks it couldn't and giving a verdict.
disable-model-invocation: true
---

# Review

Every rule here is a default. The project's own rules win, and a step the project has nothing for is skipped.

Run this in a session that didn't build the change.

## 1. Read the pull request

- Read its description, the plan it came from, and the diff.
- Get on its branch.
- Its evidence covers the code at the commit it names. Note what changed since.

## 2. Run what Verify couldn't

- Work down the checks not run, the way `../agent-verify/SKILL.md` runs and judges a check.
- Rerun any check whose code changed since its evidence.
- A check this machine can't run either stays "not run here".

## 3. Look past the list

- Open each changed screen or command once more, and try what the checks don't name.
- A finding counts only when a run shows it.
- Review the code again only if the user asks, the way step 7 of `../agent-build/SKILL.md` does.

## 4. Fix or send back

- A small slip or a proven bug: fix it on the branch the way `../agent-build/SKILL.md` builds, and rerun the checks it touches.
- A wrong approach, or anything that changes behaviour: leave it unfixed and comment on the pull request.
- A finding about security, data or sign-in: ask the user.

## 5. Give the verdict

- Update the description: tick what held, and note what was seen where it didn't.
- Give the verdict: pass, pass with notes, or fail.
- List what only the user can judge: how a screen looks, and checks still not run.
- Never merge.
