---
name: tdd
description: Test-driven development with red-green-refactor loop. Use when user wants to build features or fix bugs using TDD, mentions "red-green-refactor", wants integration tests, or asks for test-first development.
---

# Test-Driven Development

## Philosophy

**Core principle**: Tests should verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't.

**Good tests** are integration-style: they exercise real code paths through public APIs. They describe _what_ the system does, not _how_ it does it. A good test reads like a specification - "user can checkout with valid cart" tells you exactly what capability exists. These tests survive refactors because they don't care about internal structure.

**Bad tests** are coupled to implementation. They mock internal collaborators, test private methods, or verify through external means (like querying a database directly instead of using the interface). The warning sign: your test breaks when you refactor, but behavior hasn't changed. If you rename an internal function and tests fail, those tests were testing implementation, not behavior.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

## Anti-Pattern: Horizontal Slices

**DO NOT write all tests first, then all implementation.** This is "horizontal slicing" - treating RED as "write all tests" and GREEN as "write all code."

This produces **crap tests**:

- Tests written in bulk test _imagined_ behavior, not _actual_ behavior
- You end up testing the _shape_ of things (data structures, function signatures) rather than user-facing behavior
- Tests become insensitive to real changes - they pass when behavior breaks, fail when behavior is fine
- You outrun your headlights, committing to test structure before understanding the implementation

**Correct approach**: Vertical slices via tracer bullets. One test → one implementation → repeat. Each test responds to what you learned from the previous cycle. Because you just wrote the code, you know exactly what behavior matters and how to verify it.

```go
// WRONG: horizontal slicing (all tests, then all code)
func TestCheckout_Success(t *testing.T)        { /* ... */ }
func TestCheckout_DeclinedCard(t *testing.T)   { /* ... */ }
func TestCheckout_EmptyCart(t *testing.T)      { /* ... */ }
func TestCheckout_ExpiredCoupon(t *testing.T)  { /* ... */ }

// ...later in one big jump...
func (s *Service) Checkout(ctx context.Context, cartID string) (Receipt, error) {
    // huge implementation written after all tests
}

// RIGHT: vertical slices (one behavior at a time)
// 1) RED: TestCheckout_Success fails
// 2) GREEN: minimal Checkout logic for success path
// 3) RED: TestCheckout_DeclinedCard fails
// 4) GREEN: minimal decline handling
```

## Workflow

### 1. Planning

Before writing any code:

- [ ] Confirm with user what interface changes are needed
- [ ] Confirm with user which behaviors to test (prioritize)
- [ ] Identify opportunities for [deep modules](deep-modules.md) (small interface, deep implementation)
- [ ] Design interfaces for [testability](interface-design.md)
- [ ] List the behaviors to test (not implementation steps)
- [ ] Get user approval on the plan

Ask: "What should the public interface look like? Which behaviors are most important to test?"

**You can't test everything.** Confirm with the user exactly which behaviors matter most. Focus testing effort on critical paths and complex logic, not every possible edge case.

### 2. Tracer Bullet

Write ONE test that confirms ONE thing about the system:

```go
// checkout/service_test.go
package checkout_test

func TestCheckout_WithValidCart_ReturnsPaidReceipt(t *testing.T) {
    gateway := newStubGateway(func(totalCents int) (string, error) {
        return "txn-123", nil
    })
    svc := checkout.NewService(gateway)

    receipt, err := svc.Checkout(context.Background(), checkout.Cart{ID: "cart-1", TotalCents: 2500})
    if err != nil {
        t.Fatalf("Checkout() error = %v", err)
    }
    if receipt.Status != "paid" {
        t.Fatalf("status = %q, want %q", receipt.Status, "paid")
    }
}

// RED: this test fails first.
// GREEN: add the smallest amount of real code to make it pass.
```

This is your tracer bullet - proves the path works end-to-end.

### 3. Incremental Loop

For each remaining behavior:

```go
// Cycle 1
// RED:   TestCheckout_WithValidCart_ReturnsPaidReceipt
// GREEN: implement happy path only

// Cycle 2
// RED:   TestCheckout_WithDeclinedCard_ReturnsPaymentFailed
// GREEN: map gateway decline to public error/result

// Cycle 3
// RED:   TestCheckout_WithEmptyCart_ReturnsValidationError
// GREEN: add minimal cart validation
```

Rules:

- One test at a time
- Only enough code to pass current test
- Don't anticipate future tests
- Keep tests focused on observable behavior

### 4. Refactor

After all tests pass, look for [refactor candidates](refactoring.md):

- [ ] Extract duplication
- [ ] Deepen modules (move complexity behind simple interfaces)
- [ ] Apply SOLID principles where natural
- [ ] Consider what new code reveals about existing code
- [ ] Run tests after each refactor step

**Never refactor while RED.** Get to GREEN first.

## Checklist Per Cycle

```
[ ] Test describes behavior, not implementation
[ ] Test uses public interface only
[ ] Test would survive internal refactor
[ ] Code is minimal for this test
[ ] No speculative features added
```
