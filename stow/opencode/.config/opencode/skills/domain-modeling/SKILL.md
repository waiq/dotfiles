---
name: domain-modeling
description: Build and sharpen a project's domain model. Use when discussing codebase terminology, editing CONTEXT.md, or recording ADRs.
---

# Domain Modeling

Actively build and sharpen the project's domain model as you design. This skill is for changing the model, not merely reading existing vocabulary.

## File Structure

Most repos have a single context:

```text
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── internal/
```

If `CONTEXT-MAP.md` exists at the root, the repo has multiple contexts:

```text
/
├── CONTEXT-MAP.md
├── docs/adr/
└── internal/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

Create files lazily. If no `CONTEXT.md` exists, create one only when the first term is resolved. If no `docs/adr/` exists, create it only when the first ADR is needed.

## During The Session

### Challenge Against The Glossary

When the user uses a term that conflicts with `CONTEXT.md`, call it out immediately.

### Sharpen Fuzzy Language

When language is vague or overloaded, propose a precise canonical term.

### Discuss Concrete Scenarios

Use concrete scenarios to stress-test relationships between terms and force precision.

### Cross-Reference With Code

When the user states how something works, check whether the code agrees. If code contradicts the domain story, surface the mismatch.

### Update CONTEXT.md Inline

When a term is resolved, update `CONTEXT.md` immediately. Use [CONTEXT-FORMAT.md](CONTEXT-FORMAT.md).

`CONTEXT.md` is a glossary. Do not turn it into a spec, scratch pad, or repository for implementation decisions.

### Offer ADRs Sparingly

Offer an ADR only when all three are true:

1. The decision is hard to reverse.
2. A future reader would be surprised without context.
3. The decision came from a real trade-off.

Use [ADR-FORMAT.md](ADR-FORMAT.md).
