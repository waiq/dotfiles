# ADR Format

ADRs live in `docs/adr/` and use sequential numbering: `0001-slug.md`, `0002-slug.md`, and so on.

Create `docs/adr/` lazily, only when the first ADR is needed.

## Template

```md
# {Short title of the decision}

{1-3 sentences: what is the context, what did we decide, and why.}
```

An ADR can be a single paragraph. The value is recording that a decision was made and why.

## Optional Sections

Only include these when they add value:

- Status frontmatter: `proposed`, `accepted`, `deprecated`, or `superseded by ADR-NNNN`.
- Considered Options.
- Consequences.

## Numbering

Scan `docs/adr/` for the highest existing number and increment by one.

## When To Offer An ADR

All three must be true:

1. Hard to reverse.
2. Surprising without context.
3. The result of a real trade-off.

Examples:

- Architectural shape: monorepo, event-sourced write model, projected read model.
- Integration patterns: domain events instead of synchronous HTTP.
- Technology choices that carry lock-in: database, message bus, auth provider, deployment target.
- Deliberate deviations from the obvious path.
- Constraints not visible in code.
