"""Analytics functions for the synthetic portfolio dataset."""
from __future__ import annotations
import pandas as pd

def load_data(data_dir="data/sample"):
    records = pd.read_csv(f"{data_dir}/records.csv", parse_dates=["received_date","next_action_date","completed_date"])
    items = pd.read_csv(f"{data_dir}/record_items.csv")
    shortages = pd.read_csv(f"{data_dir}/shortages.csv", parse_dates=["needed_by_date"])
    branches = pd.read_csv(f"{data_dir}/branches.csv")
    return records, items, shortages, branches

def kpi_summary(records: pd.DataFrame) -> dict:
    total = len(records)
    done = int((records.final_status == "Done").sum())
    not_yet = int((records.final_status == "Not Yet").sum())
    known = pd.to_numeric(records.known_value_sar, errors="coerce")
    delivered = int((records.delivery_status == "Delivered").sum())
    return {
        "total_records": total,
        "done_records": done,
        "not_yet_records": not_yet,
        "completion_rate": done / total if total else 0,
        "known_value_sar": float(known.sum(skipna=True)),
        "value_na_records": int(known.isna().sum()),
        "delivered_records": delivered,
    }

def channel_summary(records: pd.DataFrame) -> pd.DataFrame:
    x = records.copy()
    x["known_value_sar"] = pd.to_numeric(x["known_value_sar"], errors="coerce")
    out = x.groupby("channel", dropna=False).agg(
        records=("record_id","count"),
        done=("final_status", lambda s: int((s=="Done").sum())),
        known_value_sar=("known_value_sar","sum"),
        value_na=("known_value_sar", lambda s: int(s.isna().sum())),
    ).reset_index()
    out["completion_rate"] = out["done"] / out["records"]
    return out

def monthly_trend(records: pd.DataFrame) -> pd.DataFrame:
    x = records.copy()
    x["month"] = pd.to_datetime(x.received_date).dt.to_period("M").astype(str)
    out = x.groupby(["month","channel"]).size().rename("records").reset_index()
    return out.sort_values(["month","channel"])

def shortage_summary(shortages: pd.DataFrame) -> pd.DataFrame:
    if shortages.empty:
        return pd.DataFrame(columns=["item_id","item_name","branch_id","required_qty","records_affected"])
    return shortages.groupby(["item_id","item_name","branch_id"], as_index=False).agg(
        required_qty=("required_qty","sum"), records_affected=("record_id","nunique")
    ).sort_values(["required_qty","records_affected"], ascending=False)
