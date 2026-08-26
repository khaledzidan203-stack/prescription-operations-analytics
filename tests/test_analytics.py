import pandas as pd
from src.analytics import kpi_summary, channel_summary
from src.data_quality import validate_records

def sample():
    return pd.DataFrame([
        {"record_id":"R1","customer_key":"C1","branch_id":"B1","city":"X","channel":"Standard","received_date":"2026-01-01","final_status":"Done","delivery_status":"Delivered","known_value_sar":100.0},
        {"record_id":"R2","customer_key":"C2","branch_id":"B1","city":"X","channel":"Pickup","received_date":"2026-01-02","final_status":"Not Yet","delivery_status":"N/A","known_value_sar":None},
    ])

def test_kpis_keep_na_distinct_from_zero():
    k=kpi_summary(sample())
    assert k["total_records"]==2
    assert k["value_na_records"]==1
    assert k["known_value_sar"]==100.0

def test_channel_summary():
    out=channel_summary(sample())
    assert set(out.channel)=={"Standard","Pickup"}

def test_quality_passes():
    assert validate_records(sample())==[]
