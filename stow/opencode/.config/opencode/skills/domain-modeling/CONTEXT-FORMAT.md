# CONTEXT.md Format

## Structure

```md
# {Context Name}

{One or two sentence description of what this context is and why it exists.}

## Language

**Order**:
{A one or two sentence description of the term}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request

**Customer**:
A person or organization that places orders.
_Avoid_: Client, buyer, account
```

## Rules

- Be opinionated. Pick one canonical word and list rejected synonyms under `_Avoid_`.
- Keep definitions tight: one or two sentences.
- Include only terms specific to this project's context.
- Group terms under subheadings when natural clusters emerge.

## Single Vs Multi-Context Repos

Single context: one `CONTEXT.md` at the repo root.

Multiple contexts: a root `CONTEXT-MAP.md` lists contexts and relationships:

```md
# Context Map

## Contexts

- [Ordering](./internal/ordering/CONTEXT.md): receives and tracks customer orders
- [Billing](./internal/billing/CONTEXT.md): generates invoices and processes payments
- [Fulfillment](./internal/fulfillment/CONTEXT.md): manages warehouse picking and shipping

## Relationships

- **Ordering -> Fulfillment**: Ordering emits `OrderPlaced` events; Fulfillment consumes them to start picking
- **Fulfillment -> Billing**: Fulfillment emits `ShipmentDispatched` events; Billing consumes them to generate invoices
- **Ordering <-> Billing**: Shared types for `CustomerID` and `Money`
```

Infer which structure applies:

- If `CONTEXT-MAP.md` exists, read it to find contexts.
- If only root `CONTEXT.md` exists, use single context.
- If neither exists, create root `CONTEXT.md` lazily when the first term is resolved.
