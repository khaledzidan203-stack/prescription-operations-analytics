"""Validation for the small workflow-oriented synthetic datasets."""
from __future__ import annotations

import csv
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
DATA = ROOT / "sample-data"


def read_csv(name: str):
    with (DATA / name).open(encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def test_required_synthetic_files_parse():
    names = {
        "pharmacies.synthetic.csv",
        "prescriptions.synthetic.csv",
        "items.synthetic.csv",
        "missing-items.synthetic.csv",
        "transfers.synthetic.csv",
    }
    assert all(read_csv(name) for name in names)


def test_explicit_synthetic_identifier_patterns():
    pharmacies = read_csv("pharmacies.synthetic.csv")
    prescriptions = read_csv("prescriptions.synthetic.csv")
    items = read_csv("items.synthetic.csv")

    assert all(re.fullmatch(r"DEMO-PH-ID-\d{3}", row["pharmacy_id"]) for row in pharmacies)
    assert all(re.fullmatch(r"DEMO-PH-\d{3}", row["pharmacy_code"]) for row in pharmacies)
    assert all(re.fullmatch(r"DEMO-RX-\d{6}", row["prescription_id"]) for row in prescriptions)
    assert all(re.fullmatch(r"SYN-NID-\d{6}", row["synthetic_national_id"]) for row in prescriptions)
    assert all(re.fullmatch(r"Synthetic Patient \d{3}", row["patient_name"]) for row in prescriptions)
    assert all(row["item_id"].startswith("DEMO-ITEM-ID-") for row in items)


def test_no_ten_digit_identity_like_values():
    for path in DATA.glob("*.csv"):
        assert re.search(
            r"(?<![A-Za-z0-9])\d{10}(?![A-Za-z0-9])",
            path.read_text(encoding="utf-8"),
        ) is None


def test_references_and_positive_quantities():
    pharmacies = {row["pharmacy_id"] for row in read_csv("pharmacies.synthetic.csv")}
    prescriptions = {row["prescription_id"] for row in read_csv("prescriptions.synthetic.csv")}
    items = {row["item_id"] for row in read_csv("items.synthetic.csv")}

    for row in read_csv("prescriptions.synthetic.csv"):
        assert row["pharmacy_id"] in pharmacies

    for row in read_csv("missing-items.synthetic.csv"):
        assert row["prescription_id"] in prescriptions
        assert row["pharmacy_id"] in pharmacies
        assert row["item_id"] in items
        assert int(row["required_quantity"]) > 0

    for row in read_csv("transfers.synthetic.csv"):
        assert row["original_prescription_id"] in prescriptions
        assert row["source_prescription_id"] in prescriptions
        assert not row["destination_prescription_id"] or row["destination_prescription_id"] in prescriptions
        assert row["from_pharmacy_id"] in pharmacies
        assert row["to_pharmacy_id"] in pharmacies
        assert row["from_pharmacy_id"] != row["to_pharmacy_id"]


def test_workflow_value_semantics():
    rows = read_csv("prescriptions.synthetic.csv")
    run_x = [row for row in rows if row["record_type"] == "Run-X e-RXs"]
    pick_up = [row for row in rows if row["record_type"] == "Pick-up e-RXs"]

    assert any(row["final_status"] == "Done" and float(row["known_value_sar"]) > 200 for row in run_x)
    assert any(row["final_status"] == "Not Yet" and row["known_value_sar"] == "" for row in run_x)
    assert any(row["final_status"] == "Not Yet" and row["known_value_sar"] == "200.00" for row in run_x)
    assert any(row["final_status"] == "Done" and float(row["known_value_sar"]) <= 200 for row in pick_up)
    assert any(row["final_status"] == "Not Yet" and row["known_value_sar"] == "" for row in pick_up)
