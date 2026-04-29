# Documentation Standards Matrix

## Content Strategy

| Rule | Required | Recommended | Avoid |
| --- | --- | --- | --- |
| Audience clarity | Name target reader | Add assumptions/prereqs | Writing for everyone |
| Outcome clarity | State what reader can do after reading | Add success criteria | Vague purpose |
| Doc purpose | One Diataxis type per doc | Link to adjacent doc types | Mixing tutorial + reference in one page |
| Example strategy | Include minimal runnable example when task-oriented | Lead with example then explain | Long abstract prose before any example |
| Modularity | Split deep topics into linked pages | Create index/MOC for navigation | Monolithic wall-of-text pages |

## Structure and Layout

| Rule | Required | Recommended | Avoid |
| --- | --- | --- | --- |
| Heading model | Single H1, then H2+ hierarchy | Unique, descriptive headings | Multiple H1s or skipped hierarchy |
| Intro | 1-3 sentence intro | Include audience and outcome in intro | No context at page start |
| TOC | Include for longer docs | Place after intro | TOC before context paragraph |
| Sections | Keep sections focused and scannable | Short paragraphs and bullet grouping | Dense unbroken paragraphs |
| Metadata | YAML front matter for durable docs | Add tags/owner/updated fields | Missing ownership/update metadata |

## Markdown Style

| Rule | Required | Recommended | Avoid |
| --- | --- | --- | --- |
| Syntax | Prefer Markdown over raw HTML | Keep syntax simple | HTML hacks for layout |
| Lists | Consistent list style and indentation | Lazy numbering for long ordered lists | Mixed marker styles without reason |
| Code blocks | Fenced blocks with language tag | Keep snippets minimal and runnable | Indented unlabeled code blocks |
| Links | Descriptive link text | Use reference links for long repeated URLs | "click here" anchor text |
| Tables | Use only for genuinely tabular data | Keep cells compact | Large prose-heavy tables |

## Readability and Clarity

| Rule | Required | Recommended | Avoid |
| --- | --- | --- | --- |
| Language | Clear direct sentences | Define terms in glossary once | Ambiguous pronouns/modifiers |
| Scanability | Strong section labels | Add callouts for gotchas | Buried critical warnings |
| Consistency | Keep terminology and formatting stable | Add style notes where needed | Inconsistent naming for same concept |
| Accessibility | Meaningful alt text for images | Prefer text plus diagram when useful | Image-only instructions |
| Maintenance | Add last-reviewed metadata | Add owner and review cadence | Stale pages with no review signal |

## Quality Gates

Required before final output:

1. Diataxis type declared and consistent.
2. Audience and outcome explicit.
3. Heading hierarchy valid.
4. Links descriptive and valid format.
5. Example present when task-oriented.
6. Metadata/front matter present for substantive docs.
7. Checklist passes and rubric score reported.
