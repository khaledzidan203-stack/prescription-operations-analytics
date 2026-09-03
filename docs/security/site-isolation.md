# Site Isolation

## Invariant

Every site-owned query or mutation derives `SiteId` from the authenticated user context rather than trusting client-provided ownership fields.

```csharp
var user = await userManager.GetUserAsync(User);
if (user?.SiteId is null)
    return Forbid();

var siteId = user.SiteId.Value;
var ownedRecord = await db.Records
    .SingleOrDefaultAsync(x => x.Id == id && x.SiteId == siteId);
```

The snippet is a generic portfolio example.

## Inputs That Are Never Ownership Authorities

- Query-string `SiteId`
- Route `SiteId`
- Posted form `SiteId`
- Hidden fields
- JavaScript values
- Displayed site code or name

These values may be used as filters only after the backend establishes the authorized scope.

## Where the Pattern Applies

- Synthetic intake records
- Workflow Alpha/Beta/Gamma records
- Exception queues
- Generic fulfilment events
- Transfer events
- Site dashboard metrics
- Recipient-scoped notifications and collaboration

## Architecture Note

The portfolio demonstrates explicit backend ownership predicates. A different production architecture could use scoped repositories, tenant-aware contexts, or other standard multi-tenant patterns.

## Testing Guidance

1. Owned record succeeds when the demo state allows the operation.
2. Another site's record is not exposed.
3. Posted ownership values cannot change scope.
4. Exports contain only authorized synthetic records.
5. Counters use the same site predicate as their drill-down pages.

## Publication Boundary

This document describes a standard authorization pattern and must not include real organization identifiers, role names, access exceptions, internal security topology, or private implementation details.