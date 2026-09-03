"""Validation for the generalized synthetic portfolio datasets."""
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
        "sites.synthetic.csv",
        "operational-records.synthetic.csv",
        "items.synthetic.csv",
        "exceptions.synthetic.csv",
        "transfer-events.synthetic.csv",
    }
    assert all(read_csv(name) for name in names)


def test_explicit_synthetic_identifier_patterns():
    sites = read_csv("sites.synthetic.csv")
    records = read_csv("operational-records.synthetic.csv")
    items = read_csv("items.synthetic.csv")

    assert all(re.fullmatch(r"DEMO-SITE-\d{3}", row["site_id"]) for row in sites)
    assert all(re.fullmatch(r"SITE-\d{3}", row["site_code"]) for row in sites)
    assert all(re.fullmatch(r"DEMO-REC-\d{6}", row["record_id"]) for row in records)
    assert all(re.fullmatch(r"SYN-SUB-\d{6}", row["synthetic_subject_id"]) for row in records)
    assert all(re.fullmatch(r"Synthetic Subject \d{3}", row["synthetic_subject_name"]) for row in records)
    assert all(row["item_id"].startswith("DEMO-ITEM-ID-") for row in items)


def test_no_ten_digit_identity_like_values():
    for path in DATA.glob("*.csv"):
        assert re.search(
            r"(?<![A-Za-z0-9])\d{10}(?![A-Za-z0-9])",
            path.read_text(encoding="utf-8"),
        ) is None


def test_references_and_positive_quantities():
    sites = {row["site_id"] for row in read_csv("sites.synthetic.csv")}
    records = {row["record_id"] for row in read_csv("operational-records.synthetic.csv")}
    items = {row["item_id"] for row in read_csv("items.synthetic.csv")}

    for row in read_csv("operational-records.synthetic.csv"):
        assert row["site_id"] in sites

    for row in read_csv("exceptions.synthetic.csv"):
        assert row["record_id"] in records
        assert row["site_id"] in sites
        assert row["item_id"] in items
        assert int(row["required_quantity"]) > 0

    for row in read_csv("transfer-events.synthetic.csv"):
        assert row["record_id"] in records
        assert row["source_site_id"] in sites
        assert row["destination_site_id"] in sites
        assert row["source_site_id"] != row["destination_site_id"]


def test_workflow_value_semantics():
    rows = read_csv("operational-records.synthetic.csv")
    beta = [row for row in rows if row["workflow_category"] == "Workflow Beta"]
    gamma = [row for row in rows if row["workflow_category"] == "Workflow Gamma"]

    assert any(row["status"] == "Completed" and row["known_value"] for row in beta)
    assert any(row["status"] == "Deferred" and row["known_value"] == "" for row in beta)
    assert any(row["status"] == "Completed" and row["known_value"] for row in gamma)
    assert any(row["status"] == "Deferred" and row["known_value"] == "" for row in gamma)
