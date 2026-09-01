# ADR-007: Server-Side Query Filtering

## Context

Operational pages need search, dates, status filters, pagination, counters, and
exports over SQL-backed data. Client-side filtering would load excess data and
could create inconsistent security or KPI results.

## Decision

Compose filters as EF Core `IQueryable` predicates and execute them on SQL Server.
Exports reuse the filtered query but intentionally omit pagination.

## Why

- SQL Server remains the source of truth.
- Pharmacy isolation is applied before materialization.
- Pagination controls memory and response size.
- Shared helpers align pages, counters, and dashboards.

## Alternatives

- Load all rows and filter in JavaScript.
- Duplicate query logic in every handler.
- Maintain separate reporting data for each operational page.

## Trade-offs

Complex LINQ projections can become large and require performance review. Excel
exports still need explicit scalability limits for very large result sets.

## Consequences

GET export handlers receive current filters, rebuild the same authorized query,
ignore page number, and return a server-generated FileResult.
