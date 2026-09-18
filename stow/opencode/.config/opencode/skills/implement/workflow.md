# Workflow Convention

This file defines the shared local issue convention for `grill-with-docs`, `to-spec`, `to-tickets`, `implement`, and `code-review`.

## Root

Use the vault agents area by default:

```text
${VAULT_AGENTS_ROOT:-${VAULT_PATH:-$HOME/vaults/Brains}/agents}
```

Feature work lives at:

```text
<agents-root>/<repo-name>/issues/<feature-slug>/
```

For this workflow, vault-backed issues are the default for all projects unless a future project explicitly chooses a different tracker.

## Feature Folder

```text
spec.md
issues/01-<ticket-slug>.md
issues/02-<ticket-slug>.md
adr/ADR-<topic>.md
glossary.md
activity.md
```

Use project-level docs for durable domain knowledge:

```text
<agents-root>/<repo-name>/glossary.md
<agents-root>/<repo-name>/adr/ADR-<topic>.md
```

Use global docs only for cross-project agent/workflow knowledge:

```text
<agents-root>/global/glossary.md
<agents-root>/global/adr/ADR-<topic>.md
```

## Ticket Status

- `ready`: all blockers are done and nobody has claimed it.
- `claimed`: an agent/user has reserved it but has not started code changes.
- `in-progress`: code/doc changes are underway.
- `blocked`: progress needs user input or another ticket/change.
- `review`: implementation is done and awaiting review.
- `done`: accepted, verified, and no further work remains for that ticket.

## Claiming Rules

- Claim exactly one frontier ticket per implementation run.
- A frontier ticket has no blockers, or all blockers are `done`.
- Set `Claimed by` before editing code.
- Set `Claimed at` with the current timestamp.
- If a claim is stale, do not overwrite it silently; ask or record why takeover is safe.
- Multiple agents may work in one feature folder, but not on the same claimed ticket.

## Activity Log

Each feature folder should have `activity.md` with newest entries first:

```markdown
# Activity

- <timestamp> - <actor> - <action, verification, or blocker>
```

Record ticket creation, claims, status changes, verification commands, skipped checks, and review outcomes.
