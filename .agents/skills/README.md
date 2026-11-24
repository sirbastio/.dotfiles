# How the skills fit together

Seven skills, one per stage of a change. Each is started by hand with a slash command, and each can lead into the next.

Boxes are skills. Rounded shapes are you, or something handed to you.

- Purple outline: the agent works with you.
- Green outline: the agent works alone.
- Dashed orange outline: used only sometimes.

```mermaid
flowchart TD
    idea([You have an idea or a task])
    plan["<b>agent-plan</b><br/>write the plan, you confirm it,<br/>publish it as an issue"]
    question["<b>question</b><br/>settle every decision with you"]
    solo([Or on its own, when you only<br/>want a task talked through])
    small([Small and obvious:<br/>no plan needed])
    split["<b>split</b><br/>cut the plan into issues<br/>that each fit one session"]
    build["<b>agent-build</b><br/>build in small tested units,<br/>then review the code"]
    verify["<b>agent-verify</b><br/>prove it on the real thing,<br/>then open the pull request"]
    pr([Pull request with the evidence])
    review["<b>agent-review</b><br/>run the checks Verify couldn't,<br/>give a verdict"]
    merge([You merge, or take further action])
    setup["<b>verify-setup</b><br/>once per project: write the skill<br/>that says how to verify it"]

    idea --> plan
    plan -->|asks the questions first| question
    question -->|decisions settled| plan
    question -->|one sensible approach| small
    solo -.-> question
    small --> build
    plan -->|fits one session| build
    plan -->|too big| split
    split -->|one issue per session| build
    build --> verify
    verify -->|a check failed| build
    verify -->|no check failed| pr
    pr -->|every check ran| merge
    pr -->|checks not run here,<br/>or you want a second look| review
    review --> merge
    setup -.-> verify

    classDef you fill:none,stroke:#888780,stroke-width:1px
    classDef withYou fill:none,stroke:#7F77DD,stroke-width:2px
    classDef alone fill:none,stroke:#1D9E75,stroke-width:2px
    classDef sometimes fill:none,stroke:#D85A30,stroke-width:2px,stroke-dasharray:5 4
    class idea,solo,small,pr,merge you
    class plan,question,split withYou
    class build,verify alone
    class review,setup sometimes
```

| Skill | Starts from | What it does | Hands on to |
| --- | --- | --- | --- |
| `agent-plan` | An idea or a task. This is the usual way in | Runs `question` first, then writes the plan with its acceptance checks, asks you to confirm, and publishes it as an issue | `agent-build`, or `split` when the work won't fit one session |
| `question` | `agent-plan`, or you, when you only want a task talked through | Restates the goal, traces the code, and asks you in rounds until nothing is assumed | Back to `agent-plan`, or straight to building when the change is small and obvious |
| `split` | A confirmed plan | Cuts it into thin slices, one issue each, with what each waits on | `agent-build`, once per issue |
| `agent-build` | A plan or an issue | Builds one tested unit at a time, reads the whole diff, runs the project's checks, and has the code reviewed | `agent-verify` |
| `agent-verify` | A built change | Runs each acceptance check on the real thing, and goes back to building when one fails | A pull request with the evidence, the checks it couldn't run, and the risk |
| `agent-review` | An open pull request, in a session that didn't build it | Runs the checks Verify couldn't, looks past the list, and fixes a small slip or sends a wrong approach back | A verdict. You merge |
| `verify-setup` | A project with no written way to verify it | Writes a `verify-<project>` skill and a feature map, then proves them once | Every later `agent-verify` in that project |

You stay in the loop through `question`, `agent-plan` and `split`. From `agent-build` to the pull request the agent works alone, and stops only when blocked or for a decision that can't be undone. `agent-review` is optional: use it when checks couldn't be run, or when you want a second look.

Each skill's folder has a `SOURCES.md` that says where every idea in it came from.
