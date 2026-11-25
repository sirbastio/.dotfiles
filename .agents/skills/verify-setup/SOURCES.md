# Verify set-up: where each idea came from

The steps of `SKILL.md` in order, and the source of each idea.

- **Matt**: Matt Pocock's skills, `mattpocock/skills` on GitHub. He has nothing on this.
- **poteto**: Pstack, `harness/pstack` in `cursor/plugins` on GitHub. Almost all of it is her `create-verification-skill`, written "create" below.
- **Phillipe**: asked for while the skill was being written, or carried from prepr: its `AGENTS.md` and `docs/feature-map.md`.
- **Claude**: wording or a choice made while drafting, from neither set of skills.

| Step | Idea | Source |
|---|---|---|
| Opening line | The facts go in the project, the method stays in Verify | Phillipe |
| 1. Read the project | Answer from the repo, ask the user only what it can't show | poteto: create ("Interview the repo, not the user") |
| | Surface: what a user touches | poteto: create (Surface) |
| | Pick the primary surface and note the rest | poteto: create (Surface) |
| | Run: how it starts and what it needs | poteto: create (Run) |
| | Drive: how an agent interacts | poteto: create (Drive) |
| | Find things by label, never by position | poteto: create ("stable handles") |
| | If insufficient, the usual tool for the platform | poteto: create (Drive) |
| | Check it against the platform's current docs first | Phillipe: prepr's `AGENTS.md` (read the versioned docs before touching an Expo API) |
| | Observe: what evidence can be captured and how | poteto: create (Observe) |
| | Isolate: whether two copies can run at once | poteto: create (Isolate) |
| | If it doesn't start, fix that first or report it | poteto: create |
| 2. Write the skill | A skill in the project, not a doc | Phillipe. poteto: create writes `verify-<app>` the same way |
| | In the folder the project keeps its skills in | Phillipe |
| | Written for an agent that has never seen the project | poteto: create ("read cold, mid-task, by an agent that has never seen the app") |
| | On a machine that isn't this one; nothing from private or machine-local instructions | Phillipe: reflect on prepr's set-up run, where tmux, a simulator model and "one Metro at a time" leaked in from `CLAUDE.local.md` |
| | It holds facts and commands; when to use them is Verify's | Phillipe: same run, where "reuse it" and "ask before stopping it" were written into the project skill |
| | With no skills folder, ask the user where | Claude |
| | Its description names the project, the surface and when to use it | poteto: create ("without frontmatter the skill never registers") |
| | Left open to the agent, so Verify can follow it | Claude |
| | Launch: the exact command and how to tell it's ready | poteto: create (Launch) |
| | Ready means it can be used, not only that it answers | poteto: create (Launch: "Ready means usable, not just that a process answers") |
| | The data a fresh run starts with, and how to load it | poteto: create (Launch: "from an empty data dir, including any migrations and seed data") |
| | Check: how to tell it's running this change | poteto: create (Doctor). Loose: hers is wider (process, port, version, auth), narrowed to match Verify's step 2 |
| | Drive: real commands, not examples | poteto: create (Drive) |
| | A script it ships can be run, and the skill shows how | poteto: create (Helpers) |
| | Evidence: what to capture | poteto: create (Evidence) |
| | Kept in a temporary folder outside the repo, unless the project names a place | Phillipe: same run, where evidence was saved inside the checkout |
| | Clean up: how to stop what a run started | poteto: create (Cleanup) |
| | Limits: what can't run at once, what a cloud machine lacks | Claude, so Verify's step 2 has something to sort by. Phillipe: the build may be in the cloud |
| 3. Map the features | Keep the map the project already has | Claude |
| | The skill points to it and never repeats it | Phillipe: same run, where features, screens and icons were listed in the skill and would go stale |
| | With none, one file in the skill's folder | Phillipe: prepr's feature map. poteto uses one file per feature |
| | The main three to five features to start | poteto: create ("Seed the feature map") |
| | From the user's side: what it is, every way to reach it, what proves it works | poteto: create ("a proof that drives one convenient entry point is incomplete when the map lists others") |
| | The traps that waste a run | poteto: create feature-map example ("Gotchas") |
| 4. Prove it | Follow only what was written, on one feature | poteto: create ("Prove the generated skill before handing it over") |
| | Once for each way to launch; a way not run is marked unproven | Phillipe: same run, where the native build was written from the README and never run |
| | Confirm the evidence is still there after clean-up | poteto: create |
| | Fix what failed and run it again | poteto: create |
| | Clean up after a failed attempt too | poteto: create ("so broken attempts don't strand processes and ports") |
| | Tell the user what was written and what still can't be driven | Claude |

Left out, and why:

| Idea | Source | Why |
|---|---|---|
| A second skill that re-checks the whole map, daily | poteto: `maintain-verification-skill` | One line in Verify instead: update the map in the same change |
| One file per feature with four fixed headings | poteto: create feature-map example | One file to start. A project can split it later |
| A small command-line driver agents call | poteto: guide 06 | Built when agents keep improvising the same steps, not at set-up |
| Never drive a copy this run didn't start | poteto: create feature-map example | Phillipe reuses the one running Metro and simulator |
| Commit the skill with the project | poteto: guide 06 | Phillipe cut it. Commits follow the project's own rules |
| Naming what a stand-in for the real target didn't prove | poteto: create | Left to the agent |
| Formal proofs and state charts | poteto: `create-formal-verification-skill`, `statechart` | A different kind of proof |

The skill ends when its own instructions have been followed once and the user has been told.
