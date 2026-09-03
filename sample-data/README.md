# Synthetic Workflow Sample Data

Every file in this directory is hand-constructed portfolio data. No row was exported from an operational database, workbook, screenshot, or application.

## Identifier Convention

- Sites: `DEMO-SITE-*`
- Records: `DEMO-REC-*`
- Synthetic subjects: `SYN-SUB-*`
- Items: `DEMO-ITEM-*`
- Transfers and exceptions: `DEMO-*`

All names, identifiers, locations, values, dates, quantities, and states exist only to demonstrate generic analytics scenarios.

## Files

| File | Grain | Demonstrated cases |
|---|---|---|
| `sites.synthetic.csv` | One synthetic site | Active/inactive site dimension |
| `operational-records.synthetic.csv` | One synthetic workflow record | Workflow Alpha/Beta/Gamma, status, known/N/A value |
| `items.synthetic.csv` | One synthetic item row | Generic item attributes and reference value |
| `exceptions.synthetic.csv` | One synthetic exception row | Open/closed exception states |
| `transfer-events.synthetic.csv` | One synthetic transfer event | Generic source/destination lineage |

The larger `data/sample/` dataset remains a synthetic analytics companion dataset.

## Privacy Rule

Public synthetic data must not reproduce real company terminology, identifiers, distributions, thresholds, timing windows, workflow mappings, or operating procedures.

## Restrictions

Do not replace these files with production exports. New rows must pass the repository's synthetic-data and publication-safety tests.
