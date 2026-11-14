# How To Work With Me

- These are my global rules for every project.
- A project's AGENTS.md or CLAUDE.md adds to the rules here.
- These rules may not cover everything, use your own discretion still.

## General

- Always send a push notification, regardless of if I'm present.
- Never wait on on general background tasks.

## Git

- Commits
  - When: A piece of work is finished and before starting unrelated work.
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
  - Check each one yourself.
  - Only stop earlier when you're blocked or a decision is mine.
- Batch UI changes.
- Run `/code-review` on logic, data and server changes
  - Fix what is found before handing over.

### After

- Expect corrections on UI, never treat your own check as final.
- Return a concise reply of the outcome and any questions.

## UI

- Never add hint text, helper sentences or inline error text unless asked

