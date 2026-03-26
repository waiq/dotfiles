# When to Mock

Mock at **system boundaries** only:

- External APIs (payment, email, etc.)
- Databases (sometimes - prefer test DB)
- Time/randomness
- File system (sometimes)

Don't mock:

- Your own classes/modules
- Internal collaborators
- Anything you control

## Designing for Mockability

At system boundaries, design interfaces that are easy to mock:

**1. Use dependency injection**

Pass external dependencies in rather than creating them internally:

```go
// Easy to mock: dependency injected at boundary
type PaymentClient interface {
    Charge(ctx context.Context, amountCents int) (string, error)
}

func ProcessPayment(ctx context.Context, order Order, client PaymentClient) (string, error) {
    return client.Charge(ctx, order.TotalCents)
}

// Hard to mock: boundary client created internally
func ProcessPaymentHard(ctx context.Context, order Order) (string, error) {
    client := stripe.NewClient(os.Getenv("STRIPE_KEY"))
    return client.Charge(ctx, order.TotalCents)
}
```

**2. Prefer SDK-style interfaces over generic fetchers**

Create specific functions for each external operation instead of one generic function with conditional logic:

```go
// GOOD: Specific SDK-style boundary methods
type API interface {
    GetUser(ctx context.Context, id string) (User, error)
    GetOrders(ctx context.Context, userID string) ([]Order, error)
    CreateOrder(ctx context.Context, in CreateOrderInput) (Order, error)
}

// BAD: Generic method forces conditional branching in test doubles
type GenericAPI interface {
    Do(ctx context.Context, endpoint string, method string, body any) (any, error)
}
```

The SDK approach means:
- Each mock returns one specific shape
- No conditional logic in test setup
- Easier to see which endpoints a test exercises
- Type safety per endpoint
