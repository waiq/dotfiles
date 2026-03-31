---
name: obsidian-notesmith
description: Research topics and produce high-quality, segmented Obsidian notes with citations, diagrams, and study-friendly structure.
license: MIT
compatibility: opencode
metadata:
  audience: learners, researchers, builders
  mode: research-to-notes
  depends_on: lesson, learn-101
---

## Purpose

- Turn research into durable "second brain" notes, not one-off summaries.
- Produce notes that are easy to read later and ready for reuse.
- Keep outputs segmented: MOC + source + literature + user-authored evergreen notes.

## Command Surface

- `obsidian start <topic>`
- `obsidian research <topic>`
- `obsidian summarize <source|topic>`
- `obsidian distill <topic>`
- `obsidian export <topic>`
- `obsidian recap <topic>`

## Core Contract

1. Never output a single giant note for multi-source work.
2. Every factual claim must include a source reference.
3. Evergreen notes are user-authored only; assistant must never write evergreen bodies.
4. Key links must include link context (`because ...`).
5. Add at least one diagram-ready section for complex topics.

## Output Layout Contract

Default output root (inside user vault):

- `10 - MOCs/`
- `20 - Sources/`
- `30 - Evergreen/`
- `03 - Resources/<topic>/` (optional topic digest)

Required output per researched topic:

1. `MOC - <Topic>.md`
2. `SRC - <Topic> - <AuthorOrOrg> - <YYYY>.md` (one per source)
3. `LIT - <Topic> - Synthesis.md` (cross-source synthesis)
4. `EVR-SEEDS - <Topic>.md` (assistant-generated prompts for user evergreen writing)
5. `DIGEST - <Topic>.md` (optional quick read)
6. `CONSUME - <Topic>.md` (mandatory reading and action protocol)

## Template Source Order (mandatory)

- Prefer vault-native PARA templates first:
  - `99 - Templates/TPL - MOC.md`
  - `99 - Templates/TPL - Source Note.md`
  - `99 - Templates/TPL - Research Consumption.md`
  - `99 - Templates/TPL - Evergreen Note.md`
  - topic-specific templates in `99 - Templates/` when present
- Only use skill-bundled templates as fallback when a vault template for that note type does not exist.
- If both exist and differ, vault template is authoritative.

## File Naming Rules

- Use prefixes: `MOC`, `SRC`, `LIT`, `EVR-SEEDS`, `EVR`, `DIGEST`, `CONSUME`.
- Use title case words separated by spaces.
- Include year in source note names where possible.

## Properties Contract (mandatory)

- Every generated note must start with YAML frontmatter (`---` block).
- Never create or update notes without properties.
- Common required properties (all note types):
  - `title`
  - `aliases`
  - `tags`
  - `created`
  - `updated`
- Type-required properties:
  - `SRC`: `source_type`, `source_url`, `author`, `published`, `confidence`
  - `LIT`: `sources`, `confidence`
  - `EVR-SEEDS`: `sources`, `confidence`
  - `DIGEST`: `confidence`
- Hard rule: if any generated note is missing required properties, fix properties first, then proceed.

## Pipelines

### `obsidian start <topic>`

1. Create topic scaffold from templates.
2. Generate a starter MOC with sections for sources, concepts, and open questions.
3. Create a research queue with source placeholders.

### `obsidian research <topic>`

1. Collect and triage high-quality sources.
2. For each source, create a `SRC` note with:
   - summary
   - key claims
   - evidence level
   - extracted quotes
   - links to related notes
3. Update MOC source index.

### `obsidian summarize <source|topic>`

1. Produce concise summary in plain language.
2. Separate source claims from interpretation.
3. Add "what to remember in 30 seconds" section.

### `obsidian distill <topic>`

1. Merge source notes into one `LIT` synthesis.
2. Generate `EVR-SEEDS` prompts (one claim candidate each) for user writing.
3. Add explicit links and rationale (`because ...`).
4. Add Mermaid-ready diagrams where they reduce complexity.

### `obsidian export <topic>`

1. Verify all required files exist.
2. Run strict properties check first:
   - `python3 .config/opencode/skills/obsidian-notesmith/scripts/validate_frontmatter.py --vault <vault_path> --topic "<Topic>"`
3. Run quality gates (below), including strict properties/frontmatter validation.
4. Return output tree and quick reading order.

### `obsidian recap <topic>`

1. Build short recap from MOC + LIT + user evergreen notes (or EVR seeds if evergreen not written yet).
2. Output key takeaways, open questions, next study path.

## Summarization Rules

- Keep three layers:
  - `TL;DR` (3-5 bullets)
  - `Deep summary` (structured sections)
  - `Actionable takeaways` (how to use this)
- Flag uncertainty clearly (`low/medium/high confidence`).
- Preserve citations in all layers.

## Research Rules

- Prefer primary sources when possible.
- Capture publication date and author/org.
- Note contradictory findings explicitly.
- Distinguish evidence from opinion.

## Diagram Rules

Use Mermaid blocks in notes for:

- Concept maps
- Process flows
- Timeline events
- Compare/contrast matrices

Diagram constraints:

- Keep labels short.
- Max 12 nodes per diagram.
- Add one sentence under each diagram explaining how to read it.

## Quality Gates (must pass)

1. **Structure**: required files exist and are linked from MOC.
2. **Properties**: every generated note has YAML frontmatter and all required properties for its type.
3. **Readability**: each note has clear headings and short paragraphs.
4. **Citations**: all factual claims trace to sources.
5. **Synthesis**: at least one `LIT` and one `EVR-SEEDS` note for deep dives.
6. **Linking**: every `EVR-SEEDS` candidate links to at least two related notes.
7. **Diagrams**: at least one useful diagram for non-trivial topics.
8. **Consumption**: a `CONSUME` note exists with fixed start order and a 30-minute study loop.

## Consumption Contract (always)

For every research task, produce a `CONSUME - <Topic>.md` note with this fixed flow:

1. Start with `DIGEST` (2-5 minutes).
2. Read `LIT` synthesis (8-12 minutes).
3. Read top 3 evergreen notes you wrote (or top 3 EVR seeds if not written yet) (8-12 minutes).
4. Pick one practical action and schedule it.
5. Capture 3 retention bullets in user words.

This flow is mandatory to keep research reusable and consistent across topics.

## State To Track

- topic
- topic_slug
- mode (`quick`|`standard`|`deep`)
- sources
- current_stage
- generated_files
- unresolved_questions
- confidence
- next_action
- notes_path

## Integration with `learn-101` and `lesson`

- During `101` runs, trigger `obsidian summarize` at each lesson checkpoint.
- After each `lesson` concept, create/update one evergreen seed; user writes the evergreen note.
- End-of-lesson handoff format:
  - Concept learned
  - Verification result
  - Source refs
  - Evergreen seed created/updated
  - Evergreen note written by user (yes/no)
  - Next link target in MOC

## Dry-Run Spec (example)

Input:

- `obsidian research "Second Brain"`

Expected files:

- `10 - MOCs/MOC - Second Brain.md`
- `20 - Sources/SRC - PARA Method - Forte - 2023.md`
- `20 - Sources/SRC - Zettelkasten Introduction - 2020.md`
- `20 - Sources/LIT - Second Brain - Synthesis.md`
- `30 - Evergreen/EVR-SEEDS - Second Brain.md`
- `03 - Resources/Second Brain/DIGEST - Second Brain.md`
- `03 - Resources/Second Brain/CONSUME - Second Brain.md`

## Success Criteria

- Topic outputs are segmented and navigable.
- Notes are readable after weeks/months without rework.
- Claims are source-grounded and synthesis is explicit.
- User can learn fast from recap + diagrams + user-authored evergreen network.

## Evergreen Ownership Rule

- Assistant can propose evergreen seeds, prompts, and outlines.
- Assistant must not write final evergreen note content.
- User writes evergreen notes in their own words.
