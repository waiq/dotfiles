# Design It Twice

When the user wants alternative interfaces for a chosen deepening candidate, use this parallel sub-agent pattern. The first idea is rarely the best.

Uses the vocabulary in [SKILL.md](SKILL.md): **module**, **interface**, **seam**, **adapter**, **leverage**.

## Process

### 1. Frame The Problem Space

Before spawning sub-agents, write a user-facing explanation of the chosen candidate:

- Constraints any new interface must satisfy.
- Dependencies and their categories from [DEEPENING.md](DEEPENING.md).
- A rough Go sketch to make constraints concrete, not to propose the final design.

Example sketch:

```go
type InvoiceCapturer interface {
    Capture(ctx context.Context, draft InvoiceDraft) (Invoice, error)
}
```

Show this to the user, then proceed to Step 2. The user can read while sub-agents work in parallel.

### 2. Spawn Sub-Agents

Spawn at least three sub-agents in parallel. Each must produce a radically different interface for the deepened module.

Give each agent a different design constraint:

- Agent 1: minimize the interface, ideally 1-3 entry points.
- Agent 2: maximize flexibility for known use cases.
- Agent 3: optimize for the most common caller.
- Agent 4, when applicable: design around ports and adapters for cross-seam dependencies.

Include `codebase-design` vocabulary and `CONTEXT.md` vocabulary in each brief.

Each sub-agent outputs:

1. Interface: types, methods, params, invariants, ordering, and error modes.
2. Go usage example showing callers using it.
3. What the implementation hides behind the seam.
4. Dependency strategy and adapters.
5. Trade-offs: where leverage is high and where it is thin.

### 3. Present And Compare

Present designs sequentially, then compare by **depth**, **locality**, and **seam placement**.

End with a strong recommendation. If a hybrid is best, propose it.
