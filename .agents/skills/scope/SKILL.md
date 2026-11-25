---
name: scope
description: Ask the user about a task or idea until every decision is settled.
disable-model-invocation: true
---

# Scope

Facts are yours to find. Decisions are the user's.

## 1. Restate the goal

- Say the goal in your own words, and the smallest change that meets it.
- If the task isn't worth doing, or something smaller would meet the goal, say so.

## 2. Trace what the change touches

- Trace the code the change touches, and why it is the way it is: its history, and the project's decision record where it keeps one.
- Weigh each past decision the change touches:
  - Say why it was made, and whether that reason still holds for this task.
  - Where it no longer holds, put changing it to the user in step 6, with your recommendation.
- Send each lookup to a sub-agent with a fresh context, and keep only its findings, so this conversation stays for the decisions.

## 3. Small and obvious: stop here

- If the change touches one or two files and has only one sensible approach, say so and stop.

## 4. Settle by running where possible

- If running something can settle a question, run it.
- Build it as a throwaway in a scratch folder outside the project.
- Say what you ran and what it showed.

## 5. Compare approaches

- When more than one approach is sensible, sketch two that differ.
  - Where the change doesn't fit the design as it is, make one sketch the design you'd build if this had been required from the start.
- Recommend one, and say what each gives and costs.
- Put the choice to the user in step 6.

## 6. Ask for the decisions

A decision is what the product should do, a preference, or anything that can't be undone.

- Ask in rounds.
  - A round holds every question that can be answered now.
  - A question that depends on an answer still open, or on a lookup still running, waits for a later round. Ask the rest now.
- Ask for any access or secrets the build will need, so the build never stops for them.
- Number each question and give your recommended answer, worded so "yes" accepts it.
- Wait for the answers, then ask the next round.
- Done when every decision the work rests on has the user's answer and none is assumed.

## 7. Hand over

- List what was decided and what the throwaways showed.
- If Plan started these questions, go back to it.
  - Otherwise ask the user whether to write the plan, and on yes follow `../agent-plan/SKILL.md`.
