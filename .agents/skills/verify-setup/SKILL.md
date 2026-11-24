---
name: verify-setup
description: Write a project skill that launches, drives and proves the project, so any agent can verify a change in it.
disable-model-invocation: true
---

# Verify Setup

The facts go in the project. The method stays in `../verify/SKILL.md`.

## 1. Read the project

Answer from the codebase/repo. Ask the user only what it can't show.

- **Surface**: What a user touches. There can be several, pick the primary and note the rest.
- **Run**: How it starts, and what it needs.
- **Drive**: How an agent interacts. Find things by label, never by position.
  - If insufficient, pick the usual tool for the platform.
  - Check it against the platform's current docs beforehand.
- **Observe**: What evidence can be captured and how.
- **Isolate**: Whether two copies can run at once.

If it doesn't start as it is, fix that first or report it.

## 2. Write the skill

Write a skill named `verify-<project>` in the folder the project keeps its skills in.

- Write it for an agent that has never seen the project.
- With no skills folder, ask the user where.
- Its description names the project, the surface, and when to use it.
- Leave it open to the agent, so Verify can follow it.

It holds:

- **Launch**: the exact command, and how to tell it's ready.
  - Ready means it can be used, not only that it answers.
  - The data a fresh run starts with, and how to load it.
- **Check**: how to tell it's running this change.
- **Drive**: real commands from this project, not examples.
  - A script it ships can be run, and the skill shows how to run it.
- **Evidence**: what to capture and where it's kept.
- **Clean up**: how to stop what a run started.
- **Limits**: what can't run at once, and what needs a tool a cloud machine lacks.

## 3. Map the features

- Keep the map the project already has, and point to it from the skill.
  - With none, write one file in the skill's folder covering the main three to five features to start.
- Each feature is described from the user's side:
  - what it is,
  - every way to reach it,
  - what proves it works,
  - the traps that waste a run.

## 4. Prove it

- Follow only what was written: launch, drive one feature, capture the evidence, clean up.
- Confirm the evidence is still there after the clean-up.
- Fix what failed and run it again.
  - Clean up after a failed attempt too.
- Tell the user what was written and what still can't be driven.
