---
name: pr
description: Write a pull request's description and open it. Use whenever a pull request is opened or its description is written or rewritten.
---

# Pull Request

Every rule here is a default. The project's own rules win, and so do the headings of its pull request template.

## 1. Keep it short

- Write it for the user to read in a minute: 40 lines at most, not counting the collapsed block in step 3.
- Drop a heading with nothing under it, and say nothing twice.
- Use the project's own terms, from its glossary where it has one.
- If the change can't be told in that space, say so and say where it could be split.

## 2. Say what changed and why

- Link the plan's issue where there is one.
- Show what changed as the smallest picture that does it (pseudocode, a call tree, a component tree, a file tree or a diagram) or as a few bullets, never both.
  - Where it alters something that was already there, mark the picture as a diff.
- Name an alternative that was turned down only where the reader would ask about it.
- Say the risk in a line or two: whether it can be undone, and what it could break.

## 3. Show the evidence

- For each check run on the real thing, one line: what was done and what was seen, with the screenshot, video or output.
  - Leave out the project's own checks, which CI shows.
  - Show the before beside the after where one was captured.
  - Name the commit the evidence was captured at.
- When a check was not run here, say before any evidence that the change is not verified, and how many checks are left.
  - Put each one's steps and what must be seen in a collapsed `<details>` block.

## 4. Open it

- Push and open the pull request, ready and not as a draft.
- On GitHub, upload each screenshot or video with `gh pr create --attach <file>`, and reference it in the description as `![what it shows](./<file>)` beside its line.
  - Then run `sh ./pr-image-width.sh <pr>` from this skill's folder, which sets how wide each image shows. It defaults to 260, which suits a phone screen; pass about 600 for a desktop window.
  - Put a before and an after in one table row.
  - Cut a video to the seconds that show the check.
- Never merge.
