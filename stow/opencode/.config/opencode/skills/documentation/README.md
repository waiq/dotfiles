# Documentation Skill Adoption Guide

## What This Adds

- A default documentation workflow with Diataxis classification.
- Shared templates for consistent, readable docs.
- A pass/fail checklist and 0-100 rubric for quality control.

## How To Use

1. Invoke `documentation` skill for doc-producing tasks.
2. Pick doc type (`tutorial`, `how-to`, `reference`, `explanation`).
3. Start from matching template in `templates/`.
4. Run `checklist.md` and score with `rubric.md`.
5. If score < 85, fix top issues before finalizing.

## Migration Path

1. Apply to all net-new docs immediately.
2. Update high-traffic legacy docs first.
3. Update remaining legacy docs opportunistically during edits.

## Maintenance Cadence

- Review standards monthly.
- Re-run sample validation after major guideline changes.
- Keep owner metadata up to date on substantial docs.

## Owner

- Default owner: repo maintainers for `opencode` config package.
