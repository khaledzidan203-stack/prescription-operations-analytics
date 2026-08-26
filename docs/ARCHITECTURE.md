# Architecture

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

## Design principles

- Single source of truth for status and identifiers
- Server/database-friendly aggregations
- Clear separation of data model, calculation engine, and presentation
- Historical snapshots for values that can change over time
- Privacy-safe public dataset
