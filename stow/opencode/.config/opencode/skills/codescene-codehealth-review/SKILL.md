---
name: codescene-codehealth-review
description: Review a project, branch, or change-set with CodeScene-aligned code-health gates and produce actionable refactoring suggestions.
---

# Skill: codescene-codehealth-review

Purpose: run a maintainability-first review aligned to CodeScene PR quality gates and return a practical report with prioritized code-health improvements.

## When to use

- User asks for a review of a project/branch/changes and wants concrete suggestions.
- User asks for CodeScene-like quality feedback locally before PR.
- User asks for maintainability/code-health improvements instead of style-only feedback.

## Inputs

- `review_mode`: `project`, `branch`, `changes`, or `pull_request`.
- `target`: repo path and optional refs/files (`main...HEAD`, staged files, list of paths).
- `risk_profile`: `bare_minimum`, `clean_code_collective`, `pay_down_tech_debt`, or `custom`.
- `context`: architecture constraints, deadlines, ownership, legacy zones.
- `output_depth`: `quick`, `standard`, `deep`.

## Core gates (CodeScene-aligned)

For each changed hotspot/function/file, evaluate these gates:

1. `critical_health_rules`
   - Look for severe understandability risks: low cohesion, deeply nested logic, brain/god functions, long parameter lists, mixed abstraction levels.
2. `new_code_health`
   - Ensure new/modified code does not introduce obvious maintainability debt.
3. `hotspot_decline`
   - In high-churn areas, reject complexity growth without compensating simplification.
4. `advisory_health_rules`
   - Flag softer maintainability problems: naming ambiguity, poor boundaries, weak encapsulation, avoidable duplication.
5. `refactoring_goals`
   - Check if intended simplifications/refactoring targets are advanced or blocked.
6. `supervise_goals`
   - Track risky areas intentionally under supervision; call out drift.
7. `codeowners_for_critical_code`
   - Note ownership/knowledge risk when critical code changed without clear steward context.

## Behavioral lens (required)

Do not do snapshot-only critique. Combine code shape + change context:

- change size and concentration,
- churn/hotspot likelihood,
- cross-module coupling impact,
- knowledge concentration/ownership risk.

If commit history is available, use it to prioritize findings in frequently changed areas first.

## Review protocol

1. Identify scope (`project`/`branch`/`changes`) and collect diffs.
2. Prioritize hotspots and large/complex deltas.
3. Score each finding with:
   - `severity`: `critical`, `high`, `medium`, `low`
   - `confidence`: `high`, `medium`, `low`
   - `gate`: one of the seven gates above
4. For each finding, propose a fix with smallest safe refactor first.
5. End with a practical 1-2 sprint improvement plan.

## Suggestion quality bar

Every suggestion must include:

- `why_now`: risk if left unchanged,
- `minimal_change`: smallest meaningful patch direction,
- `expected_health_gain`: what becomes easier to read/change/test,
- `verification`: one concrete command/check.

Avoid vague advice like "improve readability" without a specific edit path.

## Output contract

Use the template in `report-template.md`.

Always include:

- overall health verdict by selected profile,
- top 3-7 findings (ordered by impact),
- quick wins vs structural refactors,
- explicit "safe to merge?" with conditions.

## Prompt set

Use `prompt-set.md` for ready-to-run prompts by mode:

- project baseline review,
- branch diff review,
- staged/uncommitted changes review,
- post-review recheck.

## Guardrails

- Prefer maintainability and risk reduction over style preferences.
- Keep advice compatible with current architecture unless user asks for redesign.
- If missing context blocks confidence, state assumptions explicitly.
- Call out where findings should be promoted to global guidance if reusable across repos.
