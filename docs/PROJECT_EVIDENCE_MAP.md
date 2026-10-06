# Project Evidence Map

| Claim | Primary evidence | Evidence type |
|---|---|---|
| 500 analytics records | `data/sample/records.csv`, regression tests | Committed data + automated test |
| 1,185 item lines | `data/sample/record_items.csv`, regression tests | Committed data + automated test |
| 49 shortage rows | `data/sample/shortages.csv`, regression tests | Committed data + automated test |
| 8 fictional branches | `data/sample/branches.csv` | Committed dimension |
| 12 synthetic items | `data/sample/items.csv` | Committed dimension |
| 372 Done / 128 Not Yet | analytics regression tests | Automated baseline |
| 74.4% completion rate | `src/analytics.py`, regression tests | Source + test |
| SAR 82,760.75 known value | analytics regression tests | Automated baseline |
| 47 unknown-value records | analytics regression tests | Automated baseline |
| 158 Delivered records | analytics regression tests | Automated baseline |
| 126 shortage units / 24 affected records | shortage data + regression tests | Data + test |
| Standard 310 / Call-Back 109 / Pickup 81 | channel summary regression test | Automated baseline |
| Interactive analytical application | `app.py` | Implemented Streamlit source |
| SQL analytical companion | `sql/01_schema.sql`, `02_views.sql`, `03_kpi_queries.sql` | Implemented SQL source |
| Power BI runtime implementation | No PBIP/PBIR/TMDL/PBIX committed | **Not claimed** |
| Power BI analytical design | `powerbi/` | Blueprint only |
| Generic workflow governance model | `sample-data/`, detailed workflow/security docs | Separate synthetic design layer |
| Publication-safety automation | publication tests + PowerShell scan + GitHub Actions | Automated controls |
| Real operational screenshots | None committed | **Not claimed** |

## Evidence rule

The overview image is a presentation schematic. Runtime and numerical claims are tied to committed synthetic data, executable source, SQL artifacts and automated tests.

The `data/sample/` analytics companion and the `sample-data/` generic governance model must not be described as one physical dataset.
