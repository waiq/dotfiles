---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test thinking, resolve design branches, or pick an architecture direction.
---

# Grilling

Interview the user until you reach shared understanding. Map the topic as a **design tree**: every decision branches into decisions that depend on it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: questions you can ask now without guessing at answers you have not heard yet.

Ask the whole frontier in one round. Number each question and include your recommended answer. Then wait for the user's answers before asking the next round.

## Round Format

```md
**Q1 - <question title>**

<Question body, options, and trade-offs.>

Recommended answer: <your recommendation>

---

**Q2 - <question title>**

<Question body, options, and trade-offs.>

Recommended answer: <your recommendation>
```

Each answered round reshapes the tree. Settled decisions push the frontier outward and unblock later questions. A question whose answer depends on another open question belongs to a later round, not the current one.

Finding facts is the agent's job, not the user's. When a frontier question needs filesystem or codebase facts, use tools or a sub-agent to find them. Do not ask the user for anything you can inspect yourself.

The decisions are the user's. Put decisions to them and wait.

The session is done when the frontier is empty: every branch has been visited and nothing important remains assumed. Do not act on the result until the user confirms shared understanding.
