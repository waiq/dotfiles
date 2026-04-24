# Code Health Review Report

## Scope
- Mode: `<project|branch|changes|pull_request>`
- Target: `<repo + refs/files>`
- Profile: `<bare_minimum|clean_code_collective|pay_down_tech_debt|custom>`
- Depth: `<quick|standard|deep>`
- Deep-dive hotspots: `<N>`
- Test-code exclusion: `<default:on | custom override>` + `<patterns/assumptions>`

## Verdict
- Merge recommendation: `<safe|safe_with_conditions|not_safe_yet>`
- Profile compliance: `<pass|partial|fail>`
- Main risk theme: `<1-line>`
- Safe to merge?: `<yes|yes_with_conditions|no>` + `<conditions>`

## Code Health KPIs (proxy)
- Hotspot Health (weighted): `<green|yellow|red + short rationale>`
- Repository Health (weighted/sample): `<green|yellow|red + short rationale>`
- Decline signals: `<stable|predicted_decline|declining>`

## Hotspot Scan Map (phase 1)
| Rank | File | Hotspot weight | Health | Decline | Primary smells |
|---|---|---|---|---|---|
| 1 | `<path>` | `<high|medium|low>` | `<green|yellow|red>` | `<stable|predicted_decline|declining>` | `<smell list>` |
| 2 | `<path>` | `<high|medium|low>` | `<green|yellow|red>` | `<stable|predicted_decline|declining>` | `<smell list>` |
| 3 | `<path>` | `<high|medium|low>` | `<green|yellow|red>` | `<stable|predicted_decline|declining>` | `<smell list>` |

## Gate Summary
- `critical_health_rules`: `<pass|warn|fail>` - `<1-line reason>`
- `new_code_health`: `<pass|warn|fail>` - `<1-line reason>`
- `hotspot_decline`: `<pass|warn|fail>` - `<1-line reason>`
- `advisory_health_rules`: `<pass|warn|fail>` - `<1-line reason>`
- `refactoring_goals`: `<pass|warn|fail>` - `<1-line reason>`
- `supervise_goals`: `<pass|warn|fail>` - `<1-line reason>`
- `codeowners_for_critical_code`: `<pass|warn|fail>` - `<1-line reason>`

## Deep-Dive Dossiers (phase 2)
### Hotspot `<rank>`: `<path>`
- Health status: `<green|yellow|red>`
- Hotspot weight: `<high|medium|low>`
- Decline status: `<stable|predicted_decline|declining>`
- Smell families:
  - Module smells: `<list>`
  - Function smells: `<list>`
  - Implementation smells: `<list>`
- Ownership risk: `<low|medium|high>`
- Refactor ROI: `<low|medium|high>`
- Smallest safe refactor sequence:
  1. `<step 1>`
  2. `<step 2>`
  3. `<step 3>`
- Verification: `<command/check>`

## Top Findings (prioritized)
1. `[<severity>] <title>`
   - Gate: `<gate>`
   - Confidence: `<high|medium|low>`
   - Evidence: `<path[:line]>`
   - Why now: `<impact if ignored>`
   - Minimal change: `<smallest safe refactor>`
   - Expected health gain: `<maintainability gain>`
   - Verification: `<command/check>`

2. `[<severity>] <title>`
   - Gate: `<gate>`
   - Confidence: `<high|medium|low>`
   - Evidence: `<path[:line]>`
   - Why now: `<impact if ignored>`
   - Minimal change: `<smallest safe refactor>`
   - Expected health gain: `<maintainability gain>`
   - Verification: `<command/check>`

## Rule Customization and Directives
- `.codescene/code-health-rules.json`: `<not found|found + impact summary>`
- `@codescene(disable...)` directives: `<none|found + rationale coverage>`

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
