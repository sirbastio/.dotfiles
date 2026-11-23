# Split: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub.
- **Phillipe**: asked for while the skill was being written.
- **Claude**: wording or a choice made while drafting, from neither set of skills.

| Step | Idea | Source |
|---|---|---|
| Opening line | Work from the plan in the conversation, or the plan or issue the user names | Matt: `to-tickets` |
| 1. Cut the slices | Thin slices that each go end to end | Matt: `to-tickets` |
| | Each fits in one fresh session | Matt: `to-tickets` |
| | Each can be checked alone, with its own acceptance checks | Matt: `to-tickets`. poteto: `principle-sequence-verifiable-units` |
| | Each names the slices that must land first | Matt: `to-tickets` |
| | A slice that names none can start at once | Matt: `to-tickets` |
| | Slices that don't wait on each other can be built at the same time | poteto: "Multi-phase plan" playbook. Matt: `to-tickets` |
| | Described as behaviour, no file paths or code | Matt: `to-tickets` |
| | A clean-up is its own slice and goes first | Matt: `to-tickets` |
| 2. Confirm | Show the slices with what each waits on, and ask the user to confirm | Matt: `to-tickets` |
| 3. Create the issues | One issue per slice, under the plan's issue | Matt: `to-tickets` |
| | Named as the "issue tracker", not "where tasks are tracked" | Phillipe |
| | Create a slice after the ones it waits on | Matt: `to-tickets` |
| | Use the tracker's own "blocked by" link | Matt: `to-tickets` |
| | Leave the plan's issue as it is | Matt: `to-tickets` |
| | No issue tracker: add the slices to the plan's file | Claude |

The skill ends when the issues exist.
