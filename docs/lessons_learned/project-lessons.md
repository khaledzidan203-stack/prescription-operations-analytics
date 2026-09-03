# Project Lessons Learned

## 1. Define grain before measures

A KPI is only reliable when the underlying record grain is explicit. Record counts, line counts, exception counts, and transfer-event counts must not be mixed silently.

## 2. Unknown is different from zero

A missing value can mean the value is unavailable, not that its true value is zero. Preserving BLANK/NULL semantics prevents misleading aggregates.

## 3. Historical snapshots protect reporting

When current reference values can change, storing a historical snapshot with the fact preserves reproducible reporting.

## 4. Authorization belongs on the backend

Client-provided ownership fields are filters, not authorities. Site scope should be derived from authenticated context.

## 5. Shared definitions reduce dashboard drift

Cards, detail pages, exports, SQL queries, Python calculations, and Power BI measures should use documented definitions and consistent predicates.

## 6. Data quality is part of analytics

Duplicate keys, invalid quantities, inconsistent dates, orphan references, impossible statuses, and missing values should be visible and testable.

## 7. Configurable rules are safer portfolio examples

Public demonstrations should use configurable fictional thresholds and date windows instead of encoding real organization policies.

## 8. Synthetic data should be independently designed

Replacing names alone is not sufficient. Public data should use fictional identifiers, dates, values, distributions, categories, and relationships so it cannot reconstruct a private dataset or operating model.

## 9. Publication safety requires both automation and review

Automated scans catch forbidden literals and file types, while manual review is still required for business-process inference, screenshots, diagrams, and mosaic risk.

## 10. Portfolio value does not require proprietary detail

Strong evidence can come from clean modeling, SQL, Python, DAX, testing, validation, documentation, security patterns, and reproducible synthetic examples without exposing confidential terminology or workflows.
