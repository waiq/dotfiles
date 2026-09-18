---
name: code-review
description: code-review checks a diff against repo standards and the originating spec/ticket as separate axes. Use for branch, PR, ticket, or since-ref review; optionally delegate CodeScene code-health review for larger diffs.
---

# Code Review

## Purpose

Review whether a change is built right and whether it is the right change. Keep those axes separate:

- Standards: repo conventions, maintainability, code smells, test quality.
- Spec: compliance with the originating spec or ticket.

Do not blend the two into one verdict. A change can pass one axis and fail the other.

## Inputs

Require a fixed point or ask for one. Examples:

- `main`
- `HEAD~3`
- A branch name.
- A commit SHA.

Verify the ref resolves and the diff is non-empty before reviewing.

Find the originating spec/ticket in this order:

1. Path supplied by the user.
2. Ticket/spec references in commit messages or branch name.
3. `${VAULT_AGENTS_ROOT}/<repo-name>/issues/<feature-slug>/spec.md` and matching tickets.
4. Ask the user.

If no spec exists, say so and skip the Spec axis rather than inventing requirements.

## Review Process

- Inspect repo guidance: global AGENTS, repo AGENTS, README, CONTRIBUTING, coding standards, tests.
- Inspect the diff from the fixed point.
- Inspect the originating spec/ticket and acceptance criteria.
- Report findings first, ordered by severity within each axis.
- Cite file/line references for code findings and spec/ticket lines for requirement findings.
- Do not spawn recursive `code-review` calls.

## Optional CodeScene Pass

Keep this skill separate from `codescene-codehealth-review`, but delegate or recommend that skill when:

- The diff is large.
- The touched area is a hotspot.
- The review is maintainability-heavy.
- The change has broad refactor or architecture impact.

The CodeScene pass complements Standards; it does not replace Spec review.

## Output Shape

```markdown
## Standards
- <severity>: <finding with file:line and rule/smell>

## Spec
- <severity>: <finding with ticket/spec citation>

## Worst Per Axis
- Standards: <worst issue or none>
- Spec: <worst issue or none/no spec available>

## Verification Gaps
- <Checks not run or uncertainty.>
```

If there are no findings, state that explicitly and name residual risks or testing gaps.
