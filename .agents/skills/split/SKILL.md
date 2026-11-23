---
name: split
description: Cut a confirmed plan into issues that can each be built and checked on their own.
disable-model-invocation: true
---

# Split

Work from the plan in this conversation, or from the plan or issue the user names.

## 1. Cut the slices

Cut the work into thin slices that each go end to end.

- Each slice fits in one fresh session.
- Each can be checked on its own, and has its own acceptance checks.
- Each names the slices that must land first.
  - A slice that names none can start at once
  - Slices that don't wait on each other can be built at the same time.
- Each is described as behaviour, without file paths or code.
- A clean-up that makes the change easier is its own slice, and goes first.

## 2. Confirm

- Show the slices with what each one waits on
- Ask the user to confirm them.

## 3. Create the issues

Create one issue per slice in the project's issue tracker, each under the plan's issue.

- Create a slice after the slices it waits on, so it can point at them.
- Use the tracker's own "blocked by" link where it has one.
- Leave the plan's issue as it is.

If the project has no issue tracker, add the slices to the plan's file.
