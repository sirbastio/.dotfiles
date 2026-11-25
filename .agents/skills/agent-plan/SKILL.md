---
name: agent-plan
description: Turn a task into a plan the user has agreed to, before anything is built.
disable-model-invocation: true
---

# Plan

## 1. Settle the decisions

- If the questions haven't been asked in this conversation, follow `../scope/SKILL.md` first.
- If it stops at "small and obvious", stop too.

## 2. Write the plan

Put it in the reply, in the project's own terms. Describe behaviour and decisions, without file paths or code.

- **Goal**: one or two sentences.
- **What changes**: as someone using the thing would meet it.
- **Acceptance checks**: each one is a concrete scenario on the real thing and what must be seen. A passing test suite is not that proof.
  - Each is one the agent can run itself. Name any that only the user can do.
- **Left out**: what this plan doesn't cover.
- **Decided**: the user's answers and what the throwaways showed.
- **Unproven**: what the plan still assumes.
- **To record**: the decisions and new terms that belong in the project's decision record and glossary, where it keeps them. The build writes them.

## 3. Confirm and publish

- End by asking the user to confirm the plan.
- Once they do, publish it as an issue in the project's issue tracker, so a new session can read it.
- If the project has no issue tracker, save it as a file in the project and say where.
  - The file is deleted when the work lands.

If the work won't fit in one session, also ask whether to split it into issues, and on yes follow `../split/SKILL.md`.
