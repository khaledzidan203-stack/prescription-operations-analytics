# Pharmacy Isolation

## Invariant

Every Pharmacy-owned query or mutation must derive `PharmacyId` from the
authenticated `ApplicationUser`.

```csharp
var user = await userManager.GetUserAsync(User);
if (user?.PharmacyId is null)
    return Forbid();

var pharmacyId = user.PharmacyId.Value;
var ownedRecord = await db.Records
    .SingleOrDefaultAsync(x => x.Id == id && x.PharmacyId == pharmacyId);
```

The snippet is illustrative; curated examples are available under `examples/`.

## Inputs that are never ownership authorities

- Query-string `PharmacyId`.
- Route `PharmacyId`.
- Posted form `PharmacyId`.
- Hidden fields.
- JavaScript values.
- Displayed Pharmacy code or name.

These values may be used as filters only after the backend has established the
authorized scope. An ID that does not exist inside that scope behaves as not found
or forbidden.

## Where the rule applies

- Incoming Records and New Records.
- Prescription search, details, form, and duplicate.
- Upcoming, Due, and Overdue queues.
- Missing Items and Item Summary.
- Delivery Requests and delivery-only processing.
- Transfer creation, acceptance, return, and history.
- Run-X and Pick-up forms, histories, and details.
- Pharmacy Dashboard and counters.
- Pharmacy notifications and chat recipient context.

## Architectural observation

Isolation is enforced through PageModels, services, and scoped query helpers. The
EF model does not use Global Query Filters for Pharmacy ownership.

This was a conscious practical design because Admin needs explicit network-wide
queries. The trade-off is that every new Pharmacy query must include the ownership
predicate, and code review/testing must detect omissions. A future architecture
could add a scoped repository or tenant-aware DbContext, but implicit filters
would need carefully controlled Admin bypass semantics.

## Testing guidance

For each Pharmacy handler, test:

1. Owned ID succeeds when workflow state is eligible.
2. Another Pharmacy's ID returns no data or forbids the action.
3. Posted Pharmacy values cannot change ownership.
4. Exports contain only the authenticated Pharmacy's matching records.
5. Counters use the same Pharmacy predicate as their target page.
