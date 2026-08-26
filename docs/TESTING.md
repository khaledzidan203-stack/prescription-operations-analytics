# Testing Strategy

- Unit tests verify KPI totals and N/A treatment.
- Data-quality checks verify required columns, unique IDs, controlled statuses, and non-negative values.
- SQL/Python/Power BI formulas are documented to make cross-layer reconciliation possible.
- Synthetic data uses a fixed random seed for reproducibility.

Run:

```bash
pytest -q
```
