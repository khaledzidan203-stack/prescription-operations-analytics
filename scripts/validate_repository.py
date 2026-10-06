from __future__ import annotations

import csv
import hashlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

PROTECTED_ANALYTICS_CORE = {
    "app.py": "16885753b57bd3d02c600538d33f1e5b6a9b9225",
    "src/analytics.py": "8920fa3025baac422f5a86ff2fb55eb75613e840",
    "src/data_quality.py": "dcf15adb22019ff2e2649fbc15fd9779eaf088a7",
    "data/sample/branches.csv": "74c146aeb8f9180a03f8ca1c67fb1b1d0e46cf51",
    "data/sample/items.csv": "23ec7f8c1c9c82c3d74607c9914a45ec71f2edef",
    "data/sample/record_items.csv": "7a6909e06453bf730f749431a3f4790ec1137110",
    "data/sample/records.csv": "b963e5b2f5e86aff6f36fdba21cbc3141b28c834",
    "data/sample/shortages.csv": "24203901ea252586c0569309dad4df976f4559ba",
    "sql/01_schema.sql": "45c02a704d0a292e7c7039bd1a5185832ae18731",
    "sql/02_views.sql": "c86ad7d9d12402467fcc69f0e355de27025f9f16",
    "sql/03_kpi_queries.sql": "5980d06f0f2754fc797b687714c168126df78b22",
}

REQUIRED_FILES = [
    "README.md",
    "PROJECT_NOTES.md",
    "docs/README.md",
    "docs/PROJECT_INDEX.md",
    "docs/CASE_STUDY.md",
    "docs/TECHNICAL_WALKTHROUGH.md",
    "docs/PROJECT_EVIDENCE_MAP.md",
    "docs/ANALYTICS_DATASET_BOUNDARY.md",
    "docs/FINAL_RELEASE_VALIDATION.md",
    "docs/ENVIRONMENT_BASELINE.md",
    "docs/assets/Prescription Operations Analytics Dashboard.png",
    "powerbi/README.md",
    "powerbi/DATA_MODEL.md",
    "powerbi/MEASURES.md",
    "tests/test_sample_baseline.py",
]


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def git_blob_sha(path: Path) -> str:
    data = path.read_bytes()
    header = f"blob {len(data)}\0".encode("utf-8")
    return hashlib.sha1(header + data).hexdigest()


def read_csv(name: str) -> list[dict[str, str]]:
    with (ROOT / name).open(encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def validate_protected_core() -> None:
    for rel, expected in PROTECTED_ANALYTICS_CORE.items():
        path = ROOT / rel
        require(path.is_file(), f"Missing protected analytical artifact: {rel}")
        actual = git_blob_sha(path)
        require(actual == expected, f"Protected analytical artifact changed: {rel}")


def validate_analytics_baseline() -> None:
    records = read_csv("data/sample/records.csv")
    items = read_csv("data/sample/record_items.csv")
    shortages = read_csv("data/sample/shortages.csv")
    branches = read_csv("data/sample/branches.csv")
    item_master = read_csv("data/sample/items.csv")

    require(len(records) == 500, "Expected 500 records")
    require(len(items) == 1185, "Expected 1,185 record-item rows")
    require(len(shortages) == 49, "Expected 49 shortage rows")
    require(len(branches) == 8, "Expected 8 branches")
    require(len(item_master) == 12, "Expected 12 item-master rows")
    require(len({r["record_id"] for r in records}) == 500, "record_id must remain unique")
    require(len({r["customer_key"] for r in records}) == 253, "Synthetic customer-key baseline changed")

    done = sum(r["final_status"] == "Done" for r in records)
    not_yet = sum(r["final_status"] == "Not Yet" for r in records)
    delivered = sum(r["delivery_status"] == "Delivered" for r in records)
    na_value = sum(r["known_value_sar"] == "" for r in records)
    known_value = sum(float(r["known_value_sar"]) for r in records if r["known_value_sar"] != "")
    shortage_qty = sum(int(r["required_qty"]) for r in shortages)
    shortage_records = len({r["record_id"] for r in shortages})

    require(done == 372, "Done baseline changed")
    require(not_yet == 128, "Not Yet baseline changed")
    require(delivered == 158, "Delivered baseline changed")
    require(na_value == 47, "Value N/A baseline changed")
    require(abs(known_value - 82760.75) < 1e-8, "Known value baseline changed")
    require(shortage_qty == 126, "Shortage quantity baseline changed")
    require(shortage_records == 24, "Shortage affected-record baseline changed")

    channel_counts: dict[str, int] = {}
    for row in records:
        channel_counts[row["channel"]] = channel_counts.get(row["channel"], 0) + 1

    require(
        channel_counts == {"Standard": 310, "Call-Back": 109, "Pickup": 81},
        f"Channel baseline changed: {channel_counts}",
    )


def validate_presentation_and_boundaries() -> None:
    for rel in REQUIRED_FILES:
        require((ROOT / rel).exists(), f"Missing required project artifact: {rel}")

    require(not (ROOT / "PORTFOLIO_NOTES.md").exists(), "Old portfolio notes file should be removed")

    readme = (ROOT / "README.md").read_text(encoding="utf-8")
    require("Featured Portfolio" not in readme, "Old cross-project portfolio block remains")
    require("Primary roles demonstrated" not in readme, "Role-targeting wording remains")
    require(
        "Prescription%20Operations%20Analytics%20Dashboard.png" in readme,
        "README hero image link missing",
    )
    require("## The two-layer design" in readme, "Analytics/governance boundary missing from README")

    app = (ROOT / "app.py").read_text(encoding="utf-8")
    require("Synthetic Portfolio Demo" not in app, "Old Streamlit portfolio-demo label remains")
    require("Synthetic Operations Intelligence" in app, "Neutral Streamlit title missing")

    pbi = (ROOT / "powerbi/README.md").read_text(encoding="utf-8")
    require("design blueprint only" in pbi.lower(), "Power BI runtime boundary missing")
    for source in ["records.csv", "record_items.csv", "shortages.csv", "branches.csv", "items.csv"]:
        require(source in pbi, f"Power BI blueprint missing analytics source: {source}")

    image = ROOT / "docs/assets/Prescription Operations Analytics Dashboard.png"
    require(image.stat().st_size <= 2 * 1024 * 1024, "Approved presentation image exceeds 2 MB")
    require(image.suffix.lower() == ".png", "Approved presentation asset must remain PNG")


def main() -> None:
    validate_protected_core()
    validate_analytics_baseline()
    validate_presentation_and_boundaries()

    print("PASS | protected analytics core")
    print("PASS | committed synthetic analytics baseline")
    print("PASS | analytics / governance model boundary")
    print("PASS | Power BI blueprint boundary")
    print("PASS | presentation and evidence contract")
    print("REPOSITORY VALIDATION PASS")


if __name__ == "__main__":
    main()
