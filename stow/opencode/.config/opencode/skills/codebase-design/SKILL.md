---
name: codebase-design
description: Shared vocabulary for designing deep modules. Use when designing or improving a module interface, finding seams, improving testability, or when another skill needs architecture vocabulary.
---

# Codebase Design

Design **deep modules**: a lot of behaviour behind a small interface, placed at a clean seam, testable through that interface. The aim is leverage for callers, locality for maintainers, and better test surfaces.

## Glossary

Use these terms exactly. Do not substitute `component`, `service`, `API`, or `boundary` when the precise term is module, interface, or seam.

**Module**: anything with an interface and an implementation. In Go this may be a package, type, function, or vertical slice. Avoid: unit, component, service.

**Interface**: everything a caller must know to use the module correctly: exported methods/functions, parameter contracts, invariants, ordering constraints, error modes, required configuration, and performance characteristics. Avoid: API, signature.

**Implementation**: what sits inside a module. Distinct from **adapter**: a Postgres repository and an in-memory fake can both be adapters with very different implementations.

**Depth**: leverage at the interface. A module is **deep** when a large amount of behaviour sits behind a small interface. It is **shallow** when the interface is nearly as complex as the implementation.

**Seam**: a place where behaviour can change without editing the caller. The seam is where the module's interface lives. Avoid: boundary.

**Adapter**: a concrete thing that satisfies an interface at a seam. In Go this is often a struct with methods, such as `PostgresInvoiceStore` or `InMemoryInvoiceStore`.

**Leverage**: more capability per unit of interface learned. One implementation pays back across many call sites and tests.

**Locality**: change, bugs, knowledge, and verification concentrate in one place rather than spreading across callers.

## Deep Vs Shallow

Deep module:

```text
┌─────────────────────┐
│   Small Interface   │  Few exported methods, simple params
├─────────────────────┤
│                     │
│ Deep Implementation │  Complex logic hidden inside
│                     │
└─────────────────────┘
```

Shallow module:

```text
┌─────────────────────────────────┐
│       Large Interface           │  Many methods, complex setup
├─────────────────────────────────┤
│       Thin Implementation       │  Mostly passes through
└─────────────────────────────────┘
```

When designing an interface, ask:

- Can I reduce the number of exported methods?
- Can I simplify the parameters?
- Can I hide more orchestration inside?

## Principles

- **Depth is a property of the interface, not the implementation.** A deep module can have internal seams, but callers should not pay for them.
- **The deletion test.** Imagine deleting the module. If complexity vanishes, it was a pass-through. If complexity reappears across callers, it was earning its keep.
- **The interface is the test surface.** Callers and tests cross the same seam. If tests must reach past the interface, the module probably has the wrong shape.
- **One adapter means a hypothetical seam. Two adapters means a real one.** Do not introduce a seam unless something actually varies across it.

## Designing For Testability In Go

Accept dependencies instead of creating them internally:

```go
type PaymentGateway interface {
    Charge(ctx context.Context, payment Payment) error
}

func ProcessOrder(ctx context.Context, order Order, gateway PaymentGateway) error {
    return gateway.Charge(ctx, order.Payment)
}
```

Avoid hiding dependencies inside the function:

```go
func ProcessOrder(ctx context.Context, order Order) error {
    gateway := stripe.NewGateway(os.Getenv("STRIPE_KEY"))
    return gateway.Charge(ctx, order.Payment)
}
```

Return results instead of mutating distant state:

```go
func CalculateDiscount(cart Cart) (Discount, error) {
    // Caller receives an explicit result.
}
```

Prefer a small package interface that table tests can exercise:

```go
type Capturer interface {
    Capture(ctx context.Context, draft InvoiceDraft) (Invoice, error)
}
```

## Relationships

- A **module** has an **interface**.
- **Depth** is measured against the **interface**.
- A **seam** is where the **interface** lives.
- An **adapter** sits at a **seam** and satisfies the **interface**.
- **Depth** produces **leverage** for callers and **locality** for maintainers.

## Rejected Framings

- **Depth as implementation-lines divided by interface-lines**: rewards padding the implementation. Use depth-as-leverage instead.
- **Interface as only the Go `interface` keyword**: too narrow. Interface here includes everything a caller must know.
- **Boundary**: overloaded. Say **seam** or **interface**.

## Going Deeper

- See [DEEPENING.md](DEEPENING.md) for dependency categories and seam discipline.
- See [DESIGN-IT-TWICE.md](DESIGN-IT-TWICE.md) for exploring several alternative interfaces.
