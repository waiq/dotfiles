# Good and Bad Tests

## Good Tests

**Integration-style**: Test through real interfaces, not mocks of internal parts.

```go
// GOOD: Tests observable behavior through public API
func TestCheckout_WithValidCart_ReturnsConfirmed(t *testing.T) {
    svc := checkout.NewService(newStubGateway(func(totalCents int) (string, error) {
        return "txn-123", nil
    }))

    cart := checkout.Cart{ID: "cart-1", TotalCents: 4200}
    result, err := svc.Checkout(context.Background(), cart)
    if err != nil {
        t.Fatalf("Checkout() error = %v", err)
    }
    if result.Status != "confirmed" {
        t.Fatalf("status = %q, want %q", result.Status, "confirmed")
    }
}
```

Characteristics:

- Tests behavior users/callers care about
- Uses public API only
- Survives internal refactors
- Describes WHAT, not HOW
- One logical assertion per test

## Bad Tests

**Implementation-detail tests**: Coupled to internal structure.

```go
// BAD: Tests implementation details
func TestCheckout_CallsGatewayChargeWithCartTotal(t *testing.T) {
    gateway := &spyGateway{}
    svc := checkout.NewService(gateway)

    _, _ = svc.Checkout(context.Background(), checkout.Cart{ID: "cart-1", TotalCents: 4200})

    if gateway.lastChargeAmount != 4200 {
        t.Fatalf("charge amount = %d, want %d", gateway.lastChargeAmount, 4200)
    }
}
```

Red flags:

- Mocking internal collaborators
- Testing private methods
- Asserting on call counts/order
- Test breaks when refactoring without behavior change
- Test name describes HOW not WHAT
- Verifying through external means instead of interface

```go
// BAD: Bypasses interface to verify
func TestCreateUser_SavesToDatabase(t *testing.T) {
    repo := newTestRepo(t)
    svc := users.NewService(repo)

    _, _ = svc.CreateUser(context.Background(), users.CreateInput{Name: "Alice"})

    row := repo.RawQueryOne(t, "SELECT name FROM users WHERE name = ?", "Alice")
    if row == nil {
        t.Fatal("expected row")
    }
}

// GOOD: Verifies through interface
func TestCreateUser_MakesUserRetrievable(t *testing.T) {
    repo := newTestRepo(t)
    svc := users.NewService(repo)

    user, err := svc.CreateUser(context.Background(), users.CreateInput{Name: "Alice"})
    if err != nil {
        t.Fatalf("CreateUser() error = %v", err)
    }

    retrieved, err := svc.GetUser(context.Background(), user.ID)
    if err != nil {
        t.Fatalf("GetUser() error = %v", err)
    }
    if retrieved.Name != "Alice" {
        t.Fatalf("name = %q, want %q", retrieved.Name, "Alice")
    }
}
```
