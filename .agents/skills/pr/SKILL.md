---
name: pr
description: Write a pull request's description and open it. Use whenever a pull request is opened or its description is written or rewritten.
---

# Pull Request

- Every rule here is a default. The project's own rules win.
- The reader didn't write the change and reads many of these. They need two things fast:
  - What is left for them to do.
  - What the change does. 
- The rest is there to look up.

## 1. Open with what is left for the reader

- The first line, above every heading, is one of:
  - `**Left for you: <n> checks.**` and why they couldn't be run here.
  - `**Nothing left for you.**` when every check ran.
- Under it, one `- [ ]` task per thing only the reader can do: a check not run here, or a decision waiting on them.
  - Write each as what to do, then what must be seen. Never collapse these.
- Then one line, `Not checked:`, for anything nobody checked and the reader can't either.
- Say none of this again further down. This block is the only place a gap is named.

## 2. Say what changed and why

- Fill the project's pull request template, in its order. 
  - With none: What changed, Why, Verified, Risk.
  - Drop a heading with nothing under it.
- What changed: one sentence, then one picture or up to five bullets, never both.
  - The picture is the smallest that does it: a before and after table, pseudocode, a call tree, a component tree, a file tree or a diagram.
  - Where it alters something that was already there, mark it as a diff.
- Why: the problem, in a sentence or two. Link the plan's issue where there is one.
- Risk: whether it can be undone, and the worst thing it could break. Two lines.
- A bullet is one short line. Use the project's own terms, from its glossary where it has one.

## 3. Fold the evidence away

- Under the verification heading, one line stays open: 
  - How many checks held, on what, at which commit.
  - Beside it, the one screenshot, video or before and after that shows the change best.
- Everything else goes in one collapsed `<details>` block: per check, what was done and what was seen, with its capture.
  - Show the before beside the after where one was captured.
  - Leave out the project's own checks, which CI shows.

## 4. Leave out

- How the work went: what was tried, reviewed, rerun or fixed on the way.
- Files, docs and tests touched. The diff lists them.
- A choice the reader wouldn't overturn. One they might goes under Why, in a line.
- A risk that only restates what changed.

## 5. Check it

- Write the description to a file and run `sh ./pr-check.sh <file>` from this skill's folder. Fix it until it passes.
  - It fails a description that doesn't open with step 1's line, or runs past 250 words outside the collapsed block.
  - If the change can't be told in that space, say so and say where it could be split.

## 6. Open it

- Push and open the pull request, ready and not as a draft.
- If the branch already has an open pull request, push to it and rewrite its description with `gh pr edit`, never a new pull request or a comment.
  - Keep what a reviewer added, and replace evidence from an older commit.
  - If it's a draft, mark it ready.
- Never merge.

## 7. Attach the captures

- On GitHub, upload each screenshot or video with `--attach <file>` on `gh pr create` or `gh pr edit`.
  - Reference it in the description as `![what it shows](./<file>)` beside its line.
- Then run `sh ./pr-image-width.sh <pr>` from this skill's folder, which sets how wide each image shows.
  - It defaults to 260, which suits a phone screen. Pass about 600 for a desktop window.
- Put a before and an after in one table row.
- Cut a video to the seconds that show the check.
