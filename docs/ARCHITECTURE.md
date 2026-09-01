# Architecture

> **Operational Analytics Companion.** This document describes the original
> synthetic Python/SQL/Power BI layer. The verified transactional architecture is
> documented in [`architecture/application-architecture.md`](architecture/application-architecture.md).

## Portfolio architecture

```text
Synthetic CSV files
      ↓
Python validation / normalization
      ↓
Reusable analytics functions
      ↓
Streamlit + Plotly demo

CSV files ──→ Power BI semantic model
CSV files ──→ SQL Server schema/views/queries
```

## Enterprise design demonstrated conceptually

The portfolio is derived from a centralized multi-branch application pattern in which a secured web application writes to a central relational database and analytical dashboards aggregate server-side. The public repo intentionally does not reproduce private production code or infrastructure configuration.

The companion channel labels remain generalized for reproducibility:

- `Standard` is a WL-like analytical channel.
- `Call-Back` is a Run-X-like analytical channel.
- `Pickup` is a Pick-up-like analytical channel.

They are analytical proxies, not a copy of the transactional EF Core schema.

## Design principles

- Single source of truth for status and identifiers
- Server/database-friendly aggregations
- Clear separation of data model, calculation engine, and presentation
- Historical snapshots for values that can change over time
- Privacy-safe public dataset
