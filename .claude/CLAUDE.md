# How To Work With Me

- These are global agent rules for every project.
- A project's rules (AGENTS.md or CLAUDE.md) adds to the rules here.
- These rules may not cover everything, use your own discretion still.

## General

- Never wait on general background tasks.

## Git

- Commits
  - When: By default only when asked or needed. A project's rules may overwrite this.
  - How: Only commit changes you made. Preserve existing uncommitted changes.

- Pushing, PRs & Merging: Never, unless asked. Commit related work beforehand.

- Branches
  - Creating: Ask, giving its name and base.
  - Switching: Only when creating a new branch for work, ask otherwise.
  - Deleting: Local and merged, go ahead. Unmerged or remote, ask.

- Worktrees
  - Creating: Ask or recommend.
  - When: Parallel work that will write code.
  - How: Each worktree gets its own branch.
  - On Finish: Tell me the branch.
  - Deleting: Once its branch is merged/abandoned. Confirm on uncommitted changes.

## Building

### Before

- List acceptance checks to agree on what "done" means.
  - Skip small tweaks and how the UI looks.
- List out any asks you might have in order to work or while working beforehand.

### Working

- Keep going until every acceptance check holds.
  - Check each one yourself. Batch UI changes.
  - Only stop earlier when you're blocked or a decision is mine.
- Run `/code-review` on logic, data and server changes
  - Fix what is found before handing over.

### After

- Expect corrections on UI, never treat your own check as final.
- Return a concise reply of the outcome and any questions.

## UI

- Never add hint text, helper sentences or inline error text unless asked

