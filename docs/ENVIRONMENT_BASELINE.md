# Environment Baseline

## Python analytics

Primary packages:

- Python 3.12 in CI
- pandas
- pytest

## Interactive application

The Streamlit application additionally uses:

- Streamlit
- Plotly

Install the full application environment with:

```bash
pip install -r requirements.txt
```

Run:

```bash
streamlit run app.py
```

## SQL

The SQL folder contains SQL Server-compatible DDL, analytical views and KPI queries.

GitHub Actions does not provision SQL Server.

## Power BI

The Power BI folder contains documentation and suggested measures only.

No PBIP/PBIR/TMDL/PBIX runtime file is committed.

## Governance layer

Publication-safety validation runs through pytest and PowerShell GitHub Actions workflows.
