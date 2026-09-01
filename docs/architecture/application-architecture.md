# Application Architecture

## Architectural style

The operational application is a server-rendered ASP.NET Core Razor Pages modular
monolith. Business domains share one application and EF Core context while using
PageModels, focused services, and query helpers to keep recurring rules aligned.

```text
Browser
  -> Razor Pages and forms
  -> PageModels
  -> Domain-oriented services / query helpers
  -> ApplicationDbContext (EF Core)
  -> SQL Server
```

## Layer responsibilities

### Razor Pages

- Render role-specific pages and forms.
- Bind input and display validation results.
- Use Razor antiforgery behavior for state-changing form posts.
- Never act as the ownership source for Pharmacy identifiers.

### PageModels

- Enforce `[Authorize]` and resolve the authenticated user.
- Derive the user's Pharmacy ownership.
- Orchestrate queries and workflow commands.
- Reload authoritative server state before mutation.
- Return `FileResult` for authorized exports and downloads.

### Services and query helpers

- Centralize schedule predicates, search, Missing Items, item preparation,
  history, dashboards, notifications, chat, Excel generation, and counters.
- Reduce drift between pages, dashboards, and navigation badges.
- Encapsulate reusable validation rather than trusting client-side state.

### EF Core and SQL Server

- Model relationships, indexes, check constraints, and row-version concurrency.
- Provide transactional boundaries for multi-entity workflow changes.
- Preserve UTC timestamps and historical snapshots.
- Enforce active incoming uniqueness at the database layer.

## Cross-cutting components

- ASP.NET Core Identity with `Admin` and `Pharmacy` roles.
- AuditLog entries for critical operations.
- Saudi business-time conversion around UTC persistence.
- ClosedXML-based import/export boundaries.
- Private attachment storage with database metadata.
- Notifications and internal chat.

## Transaction and concurrency strategy

Commands that change multiple entities use an EF transaction where atomicity is
required. `RowVersion` protects prescriptions and transfers from conflicting
updates. Database unique indexes and check constraints reinforce application
validation for race conditions and direct database integrity.

## Deliberate limitation

The current tenant-isolation approach is application-layer filtering, not EF
Global Query Filters. This keeps Admin network queries explicit, but requires
consistent server-side ownership checks in every Pharmacy PageModel and service.
