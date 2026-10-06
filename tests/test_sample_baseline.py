from __future__ import annotations

import math

from src.analytics import (
    channel_summary,
    kpi_summary,
    load_data,
    monthly_trend,
    shortage_summary,
)
from src.data_quality import validate_records


def test_committed_analytics_sample_baseline():
    records, items, shortages, branches = load_data()

    assert len(records) == 500
    assert len(items) == 1185
    assert len(shortages) == 49
    assert len(branches) == 8

    assert records["record_id"].nunique() == 500
    assert records["customer_key"].nunique() == 253
    assert items["item_id"].nunique() == 12
    assert validate_records(records) == []


def test_committed_kpi_baseline_and_na_semantics():
    records, *_ = load_data()
    k = kpi_summary(records)

    assert k["total_records"] == 500
    assert k["done_records"] == 372
    assert k["not_yet_records"] == 128
    assert math.isclose(k["completion_rate"], 0.744, abs_tol=1e-12)
    assert math.isclose(k["known_value_sar"], 82760.75, abs_tol=1e-8)
    assert k["value_na_records"] == 47
    assert k["delivered_records"] == 158


def test_channel_summary_reconciles_to_overall_totals():
    records, *_ = load_data()
    out = channel_summary(records).set_index("channel")

    assert out.loc["Standard", "records"] == 310
    assert out.loc["Call-Back", "records"] == 109
    assert out.loc["Pickup", "records"] == 81

    assert out.loc["Standard", "done"] == 236
    assert out.loc["Call-Back", "done"] == 73
    assert out.loc["Pickup", "done"] == 63

    assert int(out["records"].sum()) == 500
    assert int(out["done"].sum()) == 372
    assert int(out["value_na"].sum()) == 47
    assert math.isclose(float(out["known_value_sar"].sum()), 82760.75, abs_tol=1e-8)


def test_monthly_trend_preserves_record_count():
    records, *_ = load_data()
    out = monthly_trend(records)

    assert set(out["month"]) == {"2026-05", "2026-06", "2026-07", "2026-08"}
    assert set(out["channel"]) == {"Standard", "Call-Back", "Pickup"}
    assert int(out["records"].sum()) == 500


def test_shortage_summary_preserves_quantity_and_distinct_records():
    _, _, shortages, _ = load_data()
    out = shortage_summary(shortages)

    assert int(out["required_qty"].sum()) == 126
    assert shortages["record_id"].nunique() == 24

    top = out.iloc[0]
    assert top["item_id"] == "I0003"
    assert top["branch_id"] == "B003"
    assert int(top["required_qty"]) == 10
    assert int(top["records_affected"]) == 3
