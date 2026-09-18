---
name: to-tickets
description: to-tickets splits an approved spec or settled plan into Obsidian-backed vertical-slice tickets with blockers and claim metadata. Use before multi-session implementation.
---

# To Tickets

## Purpose

Break a spec or settled plan into agent-sized execution tickets. Each ticket must be a vertical tracer bullet: a narrow path through all affected layers that can be verified independently.

This skill publishes work for:

```text
grill-with-docs -> to-spec -> to-tickets -> implement -> code-review
```

## Storage

Follow [workflow.md](workflow.md). By default, write tickets under:

```text
${VAULT_AGENTS_ROOT:-${VAULT_PATH:-$HOME/vaults/Brains}/agents}/<repo-name>/issues/<feature-slug>/issues/
```

Use dependency-order filenames:

```text
01-<slug>.md
02-<slug>.md
```

Update the feature `activity.md` after writing tickets.

## Ticket Design Rules

- Prefer vertical slices over layers.
- Each ticket should fit one fresh agent context.
- Each ticket must answer: what can I demo when this is done?
- Keep blockers explicit and minimal.
- Put prefactoring first when it makes the main change easier.
- Avoid file-path-heavy tickets; name boundaries and behavior instead.
- For wide mechanical refactors, use expand -> migrate batches -> contract instead of forcing vertical slices.

## Before Publishing

Present the proposed ticket list to the user first:

- Number and title.
- Demo path.
- Blocked by.
- Acceptance criteria.
- Why this is a vertical slice.

Do not write ticket files until the breakdown is approved or the user has already delegated execution under an approved plan.

## Ticket Template

```markdown
# <NN>. <Ticket Title>

## Metadata
- Status: ready|claimed|in-progress|blocked|review|done
- Claimed by: <agent/session/user or blank>
- Claimed at: <timestamp or blank>
- Blocked by: <ticket ids or none>
- Spec: ../spec.md

## Goal
<One independently useful outcome.>

## Demo Path
<What can be shown when this lands.>

## Scope
- <Included work.>

## Out Of Scope
- <Work explicitly left to other tickets.>

## Test Seam
- <Package API, HTTP handler, repository interface, command boundary, CLI boundary, or other agreed seam.>

## Acceptance Criteria
- [ ] <Criterion that should fail before implementation.>

## Notes
<Relevant decisions, ADRs, glossary entries, or risks.>
```

## Frontier Rule

A ticket is ready to claim when every ticket listed in `Blocked by` is `done`. Multiple agents may work the same feature folder, but each must claim exactly one frontier ticket and update the metadata before editing code.
