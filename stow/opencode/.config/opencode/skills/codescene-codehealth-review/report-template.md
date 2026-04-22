# Code Health Review Report

## Scope
- Mode: `<project|branch|changes|pull_request>`
- Target: `<repo + refs/files>`
- Profile: `<bare_minimum|clean_code_collective|pay_down_tech_debt|custom>`
- Depth: `<quick|standard|deep>`

## Verdict
- Merge recommendation: `<safe|safe_with_conditions|not_safe_yet>`
- Profile compliance: `<pass|partial|fail>`
- Main risk theme: `<1-line>`

## Gate Summary
- `critical_health_rules`: `<pass|warn|fail>` - `<1-line reason>`
- `new_code_health`: `<pass|warn|fail>` - `<1-line reason>`
- `hotspot_decline`: `<pass|warn|fail>` - `<1-line reason>`
- `advisory_health_rules`: `<pass|warn|fail>` - `<1-line reason>`
- `refactoring_goals`: `<pass|warn|fail>` - `<1-line reason>`
- `supervise_goals`: `<pass|warn|fail>` - `<1-line reason>`
- `codeowners_for_critical_code`: `<pass|warn|fail>` - `<1-line reason>`

## Top Findings (prioritized)
1. `[<severity>] <title>`
   - Gate: `<gate>`
   - Evidence: `<path[:line]>`
   - Why now: `<impact if ignored>`
   - Minimal change: `<smallest safe refactor>`
   - Expected health gain: `<maintainability gain>`
   - Verification: `<command/check>`

2. `[<severity>] <title>`
   - Gate: `<gate>`
   - Evidence: `<path[:line]>`
   - Why now: `<impact if ignored>`
   - Minimal change: `<smallest safe refactor>`
   - Expected health gain: `<maintainability gain>`
   - Verification: `<command/check>`

## Quick Wins (<= 1 day)
- `<small refactor with high signal>`
- `<small refactor with high signal>`

## Structural Improvements (1-2 sprints)
- `<larger boundary/module simplification>`
- `<ownership/coupling reduction step>`

## Suggested Execution Plan
1. `<first highest ROI change>`
2. `<second change>`
3. `<recheck/report command>`

## Assumptions and Confidence
- Assumptions: `<missing context explicitly listed>`
- Confidence: `<high|medium|low>`
