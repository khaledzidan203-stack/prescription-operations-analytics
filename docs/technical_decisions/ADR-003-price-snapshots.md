# ADR-003: Historical Unit-Price Snapshots

## Context

Item Master prices change, but completed prescriptions and later dispenses must
remain financially interpretable as they were recorded.

## Decision

Store UnitPriceSnapshot on prescription/operational item rows and calculate line
totals from quantity multiplied by that snapshot.

## Why

- Prevent retrospective repricing.
- Keep exports, details, and analytics reconcilable.
- Allow Item Master to evolve independently from history.

## Alternatives

- Always join to current Item Master price.
- Maintain only a separate temporal price table.
- Store only prescription total.

## Trade-offs

Snapshot data is duplicated and item replacement needs explicit server mapping.

## Consequences

Retaining an item preserves its snapshot; new/replaced items receive a new
server-resolved snapshot. Duplicate/New Dispense copies source snapshots.
