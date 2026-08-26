# Data Dictionary

## records.csv

| Column | Type | Description |
|---|---|---|
| record_id | text | synthetic unique record key |
| customer_key | text | synthetic non-identifying customer key |
| branch_id | text | branch dimension key |
| city | text | generalized synthetic city |
| channel | text | Standard / Call-Back / Pickup |
| received_date | date | date record entered workflow |
| final_status | text | Done / Not Yet |
| not_yet_reason | text | generalized reason when not complete |
| next_action_date | date | optional next operational date |
| delivery_status | text | Pending / Delivered / Transferred / N/A |
| known_value_sar | decimal nullable | known record value; blank means N/A |
| completed_date | date nullable | date completed |

## record_items.csv

| Column | Type | Description |
|---|---|---|
| record_id | text | parent record |
| item_id | text | synthetic item key |
| item_name | text | synthetic item label |
| quantity | integer | positive quantity |
| unit_price_snapshot | decimal | historical price at record time |
| line_total | decimal | quantity × snapshot price |
| sort_order | integer | display order |

## shortages.csv

| Column | Type | Description |
| shortage_id | text | unique shortage row |
| record_id | text | affected record |
| branch_id | text | responsible branch |
| item_id | text | required item |
| item_name | text | synthetic item label |
| required_qty | integer | quantity required |
| needed_by_date | date | operational need date |
| status | text | Open/Closed; sample uses Open |
