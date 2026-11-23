# How To Work With Me

- These are default global agent rules for every project.
- A project's rules (AGENTS.md or CLAUDE.md) adds and/or overwrites to the rules here.
- These rules may not cover everything, use your own discretion still.

## General

- Never wait on general background tasks.
- Decisions
  - Can be undone: Decide, and tell me what you chose in the hand-over.
  - Can't be undone: Ask.

## Git

- Commits
  - When: By default only when asked or needed.
  - How: Only commit changes you made. Preserve existing uncommitted changes.

- Pushing, PRs & Merging: Ask.

- Branches
  - Creating: Ask.
  - Switching: Only when creating a new branch for work, ask otherwise.
  - Deleting: Local and merged, go ahead. Unmerged or remote, ask.

- Worktrees
  - Creating: Go ahead.
  - When: Parallel work that will write code.
  - How: Each worktree gets its own branch.
  - On Finish: Tell me the branch.
  - Deleting: Once its branch is merged/abandoned. Confirm on uncommitted changes.

## Building

### Before

- List acceptance checks, then start.
  - Use my finish condition if I gave one.
  - Skip small tweaks and how the UI looks.
- List out any access or secrets you'll need beforehand.

### Working

- Keep going until every acceptance check holds.
  - Check each one on the real thing. Batch UI changes.
  - Only stop earlier when you're blocked or a decision can't be undone.
- Run `/code-review` on logic, data and server changes
  - Fix what is found before handing over.
- Corrections
  - Fix it, then make the mistake impossible.
  - Prefer a type, lint rule or test over a new written rule.

### After

- Expect corrections on UI, never treat your own check as final.
- Return a concise reply of the outcome, what you decided and any questions.
