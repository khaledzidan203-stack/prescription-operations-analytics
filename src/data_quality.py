"""Simple data-quality checks used by the demo and tests."""
import pandas as pd

REQUIRED_RECORD_COLUMNS = {
    "record_id","customer_key","branch_id","city","channel","received_date",
    "final_status","delivery_status","known_value_sar"
}

def validate_records(df: pd.DataFrame) -> list[str]:
    issues=[]
    missing=REQUIRED_RECORD_COLUMNS-set(df.columns)
    if missing: issues.append(f"Missing columns: {sorted(missing)}")
    if "record_id" in df and df.record_id.duplicated().any(): issues.append("Duplicate record_id values")
    if "final_status" in df and not set(df.final_status.dropna()).issubset({"Done","Not Yet"}): issues.append("Unexpected final_status value")
    if "known_value_sar" in df:
        vals=pd.to_numeric(df.known_value_sar, errors="coerce")
        if (vals.dropna()<0).any(): issues.append("Negative known_value_sar")
    return issues
