# ADR-002: Application-Level Pharmacy Isolation

## Context

Pharmacy users require strict ownership, while Admin users need explicit global
queries across all pharmacies.

## Decision

Derive PharmacyId from the authenticated ApplicationUser and apply ownership
predicates in Pharmacy PageModels/services. Do not trust client identifiers.

## Why

- Ownership remains explicit at each operational boundary.
- Admin global scope does not require disabling an implicit tenant filter.
- Existing Razor Page handlers can return not-found/forbidden consistently.

## Alternatives

- EF Global Query Filters.
- Tenant-aware repository abstraction.
- Separate database/schema per Pharmacy.

## Trade-offs

Application-level enforcement creates omission risk when adding a new query.
Reviews and cross-Pharmacy tests must treat the predicate as an invariant.

## Consequences

Every Pharmacy-owned query, mutation, export, counter, and detail route must show
where its server-derived Pharmacy scope is applied.
