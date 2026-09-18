# HTML Report Format

The architecture review is rendered as a single self-contained HTML file in the OS temp directory. Tailwind and Mermaid both come from CDNs. Mermaid handles graph-shaped diagrams reliably; hand-built divs and inline SVG handle editorial visuals such as mass diagrams, cross-sections, and call-graph collapse.

## Scaffold

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review for {{repo name}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: #dc2626; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans">
    <main class="max-w-5xl mx-auto px-6 py-12 space-y-12">
      <header>...</header>
      <section id="candidates" class="space-y-10">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

## Header

Include repo name, date, and a compact legend: solid box = module, dashed line = seam, red arrow = leakage, thick dark box = deep module. No introduction paragraph. Go straight into the candidates.

## Candidate Card

The diagrams carry the weight. Prose is sparse, plain, and uses the glossary terms from `codebase-design`.

Each candidate is one `<article>`:

- **Title**: short, names the deepening, for example `Deepen invoice capture behind one package interface`.
- **Badge row**: recommendation strength plus dependency category: `in-process`, `local-substitutable`, `ports & adapters`, or `mock`.
- **Files**: monospaced list.
- **Before / After diagram**: the centrepiece.
- **Problem**: one sentence.
- **Solution**: one sentence.
- **Wins**: bullets, six words or fewer where possible.
- **ADR callout**: one line if applicable.

No paragraphs of explanation. If the diagram needs a paragraph to be understood, redraw the diagram.

## Diagram Patterns

### Mermaid Graph

Use Mermaid `flowchart` or `graph` when the point is call flow or dependency leakage. Prefer Go package/module labels.

```html
<div class="rounded-lg border border-slate-200 bg-white p-4">
  <pre class="mermaid">
    flowchart LR
      A[cmd/api invoiceHandler] --> B[internal/invoice validateDraft]
      B --> C[internal/postgres InvoiceStore]
      C -.leak.-> D[internal/pricing HTTPClient]
      classDef leak stroke:#dc2626,stroke-width:2px;
      class C,D leak
  </pre>
</div>
```

### Hand-Built Boxes And Arrows

Use `<div>` boxes and inline SVG arrows when Mermaid layout fights the point. This works well for Go packages where the after diagram should show one thick-bordered package interface and faded internal helpers.

### Cross-Section

Stack horizontal bands to show layered shallowness. Before: handler, validator, mapper, repository, client, and retry helper each expose caller knowledge. After: one deep module, for example `invoice.Capturer`, absorbs the orchestration.

### Mass Diagram

Two rectangles per module: one for interface surface area, one for implementation. Before: interface rectangle is nearly as tall as implementation. After: interface is short and implementation is tall.

### Call-Graph Collapse

Before: a tree of Go functions rendered as nested boxes. After: the same tree collapsed into one exported interface method, with internal calls faded inside the package.

## Go-Flavoured Phrasings

- `invoice.Capturer` is shallow: the interface exposes nearly every orchestration step.
- `pricing.Client` leaks across the seam into handler tests.
- Deepen: one interface, one table-test surface.
- Two adapters justify the seam: HTTP in production, in-memory in tests.
- Locality: retry and idempotency bugs concentrate in `internal/invoice`.
- Leverage: one package interface, many handlers.

Use exactly: module, interface, implementation, depth, deep, shallow, seam, adapter, leverage, locality.

Avoid substitutions: component, service, API, boundary, layer, wrapper.
