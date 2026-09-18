---
name: improve-codebase-architecture
description: Scan a codebase for deepening opportunities. Use for periodic architecture surveys, no-good-seam findings, hard-to-test areas, or when architecture drift is broader than one PR.
---

# Improve Codebase Architecture

Surface architectural friction and propose **deepening opportunities**: refactors that turn shallow modules into deep ones. The aim is testability, AI-navigability, and a codebase where change concentrates behind useful interfaces.

This skill is a survey and decision-prep tool. It does not implement the refactor. It finds candidates, shows the trade-offs, and then routes the selected candidate into the user's workflow.

## Workflow Fit

- Use this skill for periodic maintenance or when a bug/review reveals there is no good seam to test through.
- Use `codebase-design` for the architecture vocabulary: **module**, **interface**, **depth**, **seam**, **adapter**, **leverage**, and **locality**.
- Use `domain-modeling` when terms or ADRs crystallize during the discussion.
- After the user chooses a candidate, use `grilling` or `grill-with-docs` to walk the decision tree.
- Feed settled work into `to-spec`, then `to-tickets`, then `implement`, then `code-review`.

## Go Example Policy

Prefer Go examples when explaining candidates: packages, exported interfaces, adapters, handlers, repositories, table tests, `context.Context`, and in-memory test adapters. If the active repository is clearly not Go, use that repository's language instead.

## Process

### 1. Explore

Scope before scanning. Deepening a module pays off only where future changes are likely, so put extra weight on recently changed code.

- If the user named a module, package, subsystem, or pain point, use that scope.
- Otherwise, inspect recent commit history with `git log --oneline` to identify hot spots. If changes are scattered, widen the scan.

Read domain guidance before judging seams:

- `CONTEXT.md` or `CONTEXT-MAP.md`, if present.
- Relevant ADRs under `docs/adr/`, if present.

Explore organically and note where you experience friction:

- Where does understanding one concept require bouncing between many small modules?
- Where are modules **shallow**, with an interface nearly as complex as the implementation?
- Where have functions been extracted only for testability, while bugs still hide in caller orchestration?
- Where do tightly coupled modules leak across their seams?
- Which parts are untested or hard to test through the current interface?

Apply the **deletion test** to suspected shallow modules: would deleting the module concentrate complexity, or just move it? A module earns its place when deleting it would spread complexity across callers.

### 2. Present Candidates As An HTML Report

Write a self-contained HTML file to the OS temp directory so nothing lands in the repo. Resolve the temp dir from `$TMPDIR`, falling back to `/tmp`, and write to `<tmpdir>/architecture-review-<timestamp>.html`. Open it with `xdg-open <path>` on Linux and report the absolute path.

The report uses Tailwind via CDN for layout and Mermaid via CDN for graph-shaped diagrams. Mix Mermaid with hand-crafted CSS/SVG visuals. Each candidate gets a before/after visualization.

For each candidate, render a card with:

- **Files**: files/packages involved.
- **Problem**: why the current architecture causes friction.
- **Solution**: what would change.
- **Benefits**: locality, leverage, and test improvement.
- **Before / After diagram**: side-by-side visualization.
- **Recommendation strength**: `Strong`, `Worth exploring`, or `Speculative`.

End with **Top recommendation**: the candidate to tackle first and why.

Use `CONTEXT.md` vocabulary for the domain and `codebase-design` vocabulary for architecture. If `CONTEXT.md` defines `Invoice`, talk about the `Invoice` ingestion module, not an incidental package name.

If a candidate contradicts an existing ADR, only surface it when the friction is real enough to justify reopening the decision. Mark it clearly in the card.

See [HTML-REPORT.md](HTML-REPORT.md) for the full scaffold, diagram patterns, and Go-flavoured examples.

Do not propose final interfaces yet. After opening the report, ask: "Which of these would you like to explore?"

### 3. Grilling Loop

Once the user chooses a candidate, call the Skill tool with `grilling` to walk the decision tree: constraints, dependencies, seam placement, what sits behind the interface, adapters, tests, and migration path.

Side effects happen inline as decisions crystallize. Call the Skill tool with `domain-modeling` when:

- A deepened module needs a domain term that is missing from `CONTEXT.md`.
- A fuzzy term becomes precise enough to record.
- The user rejects a candidate for a durable reason that future reviews should not re-suggest.

When the selected direction becomes implementation work, route it to `grill-with-docs` or `to-spec` rather than starting the refactor directly.
