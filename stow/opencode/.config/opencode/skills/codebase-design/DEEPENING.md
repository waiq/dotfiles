# Deepening

How to deepen a cluster of shallow modules safely, given its dependencies. Assumes the vocabulary in [SKILL.md](SKILL.md): **module**, **interface**, **seam**, **adapter**.

## Dependency Categories

### 1. In-Process

Pure computation, in-memory state, no I/O. Always deepenable: merge the modules and test through the new interface directly. No adapter needed.

### 2. Local-Substitutable

Dependencies that have local test stand-ins, such as an in-memory filesystem, SQLite, or a test Postgres container. Deepenable if the stand-in exists. The seam can stay internal; callers do not need a port at the external interface.

### 3. Remote But Owned

Your own services across a network seam. Define a port at the seam. The deep module owns the logic; transport is injected as an adapter. Tests use an in-memory adapter. Production uses HTTP, gRPC, or queue adapters.

Recommendation shape:

> Define a port at the seam, implement an HTTP adapter for production and an in-memory adapter for tests, so the logic sits in one deep module even though deployment crosses a network.

### 4. True External

Third-party services you do not control. The deepened module takes the external dependency as an injected port; tests provide a fake or mock adapter.

## Seam Discipline

- One adapter means a hypothetical seam. Two adapters means a real one.
- A deep module can have internal seams used by its own tests.
- Do not expose internal seams through the external interface just because tests use them.

## Testing Strategy: Replace, Don't Layer

- Delete old unit tests on shallow modules once tests at the deepened module's interface exist.
- Write new tests at the deepened module's interface.
- Assert observable outcomes, not internal state.
- Tests should survive internal refactors.

## Go Testing Shape

```go
func TestCapturer_Capture(t *testing.T) {
    tests := []struct {
        name string
        draft InvoiceDraft
        want  Invoice
        err   error
    }{
        {name: "captures valid invoice", draft: validDraft(), want: validInvoice()},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            store := NewInMemoryInvoiceStore()
            capturer := NewCapturer(store, FixedClock{})

            got, err := capturer.Capture(context.Background(), tt.draft)
            if !errors.Is(err, tt.err) {
                t.Fatalf("Capture() error = %v, want %v", err, tt.err)
            }
            if diff := cmp.Diff(tt.want, got); diff != "" {
                t.Fatalf("Capture() mismatch (-want +got):\n%s", diff)
            }
        })
    }
}
```
