"""Portfolio publication-safety tests; no private source is required."""
from __future__ import annotations

import re
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parents[2]

FORBIDDEN_EXTENSIONS = {
    ".db", ".sqlite", ".mdf", ".ldf", ".bak", ".backup",
    ".pfx", ".p12", ".key", ".pem", ".zip", ".7z", ".xlsx", ".xls",
}

FORBIDDEN_DIRECTORIES = {
    "App_Data", "ChatAttachments", "bin", "obj", "Release",
    "Source_Archive", "logs", "private", "secrets",
}

REQUIRED_DOCS = {
    "README.md",
    "PUBLICATION_ALLOWLIST.md",
    "PUBLICATION_DENYLIST.md",
    "SANITIZATION_MANIFEST.md",
    "docs/README.md",
    "docs/architecture/system-context.md",
    "docs/architecture/application-architecture.md",
    "docs/workflows/workflow-alpha.md",
    "docs/workflows/workflow-beta.md",
    "docs/workflows/workflow-gamma.md",
    "docs/workflows/scheduling-analytics.md",
    "docs/workflows/exception-resource-analytics.md",
    "docs/workflows/fulfilment-analytics.md",
    "docs/workflows/transfer-lineage.md",
    "docs/security/site-isolation.md",
    "docs/data_model/domain-model.md",
    "docs/kpi_dictionary/operational-kpis.md",
    "docs/validation/data-quality-rules.md",
}

PRIVATE_TERMS = {
    "Wasfaty",
    "Run-X",
    "Pick-up e-RXs",
    "WL e-RXs",
    "PrescriptionGroup",
    "WasfatyCentral",
}


def repository_files():
    return [path for path in ROOT.rglob("*") if path.is_file() and ".git" not in path.parts]


def test_prohibited_files_and_directories_are_absent():
    findings = []
    for path in repository_files():
        relative = path.relative_to(ROOT)
        if path.suffix.lower() in FORBIDDEN_EXTENSIONS:
            findings.append(f"extension:{relative.as_posix()}")
        if FORBIDDEN_DIRECTORIES.intersection(relative.parts):
            findings.append(f"directory:{relative.as_posix()}")
        if path.stat().st_size > 1024 * 1024:
            findings.append(f"oversized:{relative.as_posix()}")
    assert findings == []


def test_required_documentation_exists():
    missing = sorted(path for path in REQUIRED_DOCS if not (ROOT / path).is_file())
    assert missing == []


def test_public_text_has_no_high_risk_literals():
    patterns = {
        "numeric_identity": re.compile(r"(?<![A-Za-z0-9])\d{10}(?![A-Za-z0-9])"),
        "phone": re.compile(r"(?<!\d)05\d{8}(?!\d)"),
        "internal_host": re.compile(r"\bDESKTOP-[A-Z0-9-]+\b|\bYOUR_SQL_SERVER\b", re.I),
    }
    text_suffixes = {".md", ".txt", ".csv", ".json", ".yml", ".yaml", ".py", ".sql", ".cs"}
    findings = []
    for path in repository_files():
        relative = path.relative_to(ROOT)
        if relative.parts and relative.parts[0] == "scripts":
            continue
        if relative.parts[:2] == ("tests", "publication-safety"):
            continue
        if path.suffix.lower() not in text_suffixes:
            continue
        content = path.read_text(encoding="utf-8")
        for rule, pattern in patterns.items():
            if pattern.search(content):
                findings.append(f"{rule}:{relative.as_posix()}")
        lowered = content.lower()
        for term in PRIVATE_TERMS:
            if term.lower() in lowered:
                findings.append(f"private-term:{term}:{relative.as_posix()}")
    assert findings == []


def test_relative_markdown_links_resolve():
    link_pattern = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
    findings = []
    for path in ROOT.rglob("*.md"):
        relative = path.relative_to(ROOT)
        if relative.as_posix() == "docs/INITIAL_PORTFOLIO_README.md":
            continue
        content = path.read_text(encoding="utf-8")
        for raw_target in link_pattern.findall(content):
            target = raw_target.strip().split()[0].strip("<>")
            if target.startswith(("http://", "https://", "mailto:", "#")):
                continue
            target = unquote(target.split("#", 1)[0])
            if not target:
                continue
            resolved = (path.parent / target).resolve()
            if not resolved.exists():
                findings.append(f"{relative.as_posix()} -> {target}")
    assert findings == []
