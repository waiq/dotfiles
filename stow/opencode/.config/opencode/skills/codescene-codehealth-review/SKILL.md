---
name: codescene-codehealth-review
description: Review a project, branch, or change-set with CodeScene-aligned code-health gates and produce actionable refactoring suggestions.
---

# Skill: codescene-codehealth-review

Purpose: run a Code Health-first review aligned to CodeScene concepts. First locate maintainability risk hotspots, then deep-dive only in top hotspots with actionable refactor paths.

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
- `deep_dive_hotspots`: optional number of hotspots to deep-dive after scan (default: 3).

## Code Health-first model (required)

Prioritize findings using Code Health semantics before subjective review comments:

1. Build a hotspot risk map from change context and history:
   - churn/hotspot likelihood,
   - file size / concentration,
   - smell density,
   - cross-module coupling impact,
   - knowledge concentration/ownership risk.
2. Classify findings with Code Health smell families:
   - `module_smells`: low cohesion, brain class/god class, size, congestion,
   - `function_smells`: brain method, complex method, large method, DRY,
   - `implementation_smells`: nested complexity, bumpy road, complex conditionals.
3. Track decline signal with explicit threshold semantics:
   - `predicted_decline`: early negative trend,
   - `declining`: meaningful decline (use ~0.1 health-equivalent threshold proxy).
4. Use weighted prioritization:
   - prioritize by `severity * churn_weight * loc_weight * decline_weight`.

## Review protocol

Always run in two phases:

1. **Scan phase (project-wide or target-wide)**
   - Exclude test-only code from analytics by default (scan ranking, hotspot weights, and deep-dive selection).
   - Apply language-agnostic test-code exclusion heuristics:
     - common test directories: `test/`, `tests/`, `__tests__/`, `spec/`, `specs/`, `e2e/`, `integration-tests/`, `testdata/`;
     - common test/spec file naming: `*_test.*`, `test_*.*`, `*.test.*`, `*.spec.*`, `*Spec.*`;
     - common test-only docs/config around test harnesses when they are not runtime code.
   - If patterns are ambiguous, state assumptions explicitly and keep exclusion conservative.
   - Rank hotspots first.
   - Output top hotspots with risk drivers and provisional status (`green|yellow|red` proxy).
2. **Deep-dive phase (top hotspots only)**
   - Default top 3 hotspots unless user specifies otherwise.
   - For each hotspot, produce a Code Health dossier with smallest safe refactor sequence.
   - Do not deep-dive low-priority files unless user asks.
   - Do not deep-dive test-only files unless user explicitly requests test-code review.
3. **Gate decision phase**
   - Provide merge decision and explicit conditions tied to critical rules.

## Core gates (CodeScene-aligned)

For each deep-dived hotspot/function/file, evaluate these gates:

1. `critical_health_rules`
   - severe understandability risks (low cohesion, nested complexity, brain/god functions, mixed abstraction levels).
2. `new_code_health`
   - new/modified code must not add maintainability debt.
3. `hotspot_decline`
   - in high-churn code, complexity growth requires compensating simplification.
4. `advisory_health_rules`
   - naming ambiguity, weak boundaries, avoidable duplication, weak encapsulation.
5. `refactoring_goals`
   - expected simplification goals advanced or blocked.
6. `supervise_goals`
   - supervised risk areas drifting or improving.
7. `codeowners_for_critical_code`
   - stewardship and knowledge-spread risk.

## Suggestion quality bar

Every suggestion must include:

- `why_now`: risk if left unchanged,
- `minimal_change`: smallest meaningful patch direction,
- `expected_health_gain`: what becomes easier to read/change/test,
- `verification`: one concrete command/check.

Every deep-dive hotspot must also include:

- `decline_status`: `stable|predicted_decline|declining`,
- `hotspot_weight`: `high|medium|low` with rationale,
- `refactor_roi`: `high|medium|low`.

Avoid vague advice like "improve readability" without a specific edit path.

## CodeScene rule customizations (required)

- If `.codescene/code-health-rules.json` exists, reflect custom rule weights/scopes in the report.
- Detect and report `@codescene(disable...)` directives where visible.
- Never recommend disabling critical rules as a default strategy.

## Output contract

Use the template in `report-template.md`.

Always include:

- overall health verdict by selected profile,
- scan map + deep-dive dossiers for top hotspots,
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
