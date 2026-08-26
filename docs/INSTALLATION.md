# Installation

## Python demo

```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
# macOS/Linux
source .venv/bin/activate
pip install -r requirements.txt
streamlit run app.py
```

## Tests

```bash
pytest -q
```

## SQL Server

1. Create an empty database.
2. Run `sql/01_schema.sql`.
3. Import the CSVs from `data/sample/` using your preferred ETL/load method.
4. Run `sql/02_views.sql`.
5. Use `sql/03_kpi_queries.sql` for validation and examples.

No credentials are included in this repository.
