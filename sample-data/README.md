# Synthetic Workflow Sample Data

Every file in this directory is hand-constructed portfolio data. No row was
exported from an operational database, workbook, screenshot, or application.

## Identifier convention

- Pharmacies: `DEMO-PH-*`
- Prescriptions: `DEMO-RX-*`
- Synthetic identity values: `SYN-NID-*`
- Patients: `Synthetic Patient *`
- Items: `DEMO-ITEM-*`
- Transfers and Missing Items: `DEMO-*`

The identity values are intentionally non-numeric and cannot be interpreted as
valid national identifiers. Names, cities, prices, dates, quantities, and states
exist only to demonstrate documented workflow cases.

## Files

| File | Grain | Demonstrated cases |
|---|---|---|
| `pharmacies.synthetic.csv` | One synthetic Pharmacy | Active/inactive and city dimensions |
| `prescriptions.synthetic.csv` | One synthetic workflow record | WL, Run-X, Pick-up, Done/Not Yet, known/N/A value |
| `items.synthetic.csv` | One synthetic Item Master row | Generic name and current price reference |
| `missing-items.synthetic.csv` | One synthetic shortage row | Open/closed and procurement linkage |
| `transfers.synthetic.csv` | One synthetic transfer hop | Pre-dispense, delivery, return, and transfer states |

The larger existing `data/sample/` dataset remains the Operational Analytics
Companion dataset. These smaller files are designed for documentation and safety
tests.

## Restrictions

Do not replace these files with production exports. New rows must pass:

```powershell
pwsh -File scripts/validate-synthetic-data.ps1
```
