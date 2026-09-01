# Project Lessons Learned

## 1. Large PageModels increase maintenance risk

Workflow-heavy pages can grow into thousands of lines when query construction,
validation, state transitions, audit, notification, and export logic coexist.
Focused services and query helpers reduce this risk, but future work should keep
extracting stable business policies from PageModels.

## 2. Pharmacy isolation must be systematic

A navigation restriction is not security. Every read, mutation, export, download,
counter, and details handler must derive PharmacyId from the authenticated user.
One omitted predicate can become a cross-tenant exposure.

## 3. Workflow strings create typo risk

Controlled constants and normalization reduced drift across historical values and
UI labels, but string states still require discipline. Enums/value objects could
improve compile-time safety if migration and reporting compatibility are planned.

## 4. Shared query helpers prevent inconsistent counts

Scheduling and Missing Items showed that pages, navigation badges, dashboard cards,
and exports can disagree when each reimplements a predicate. One composable query
definition improves both correctness and reviewability.

## 5. Historical snapshots protect meaning

Using current Item Master price for an old prescription silently changes history.
Unit-price and operational batch snapshots preserve the business decision that was
actually recorded.

## 6. Runtime tests catch issues compilation cannot

A successful build did not detect every Razor handler, redirect, form-routing, or
TempData serialization problem. Focused runtime smoke tests remain necessary after
build and migration consistency checks.

## 7. GET handler routing matters for exports

An Excel service can be correct while the browser never invokes it. Export forms
must preserve filter parameters, use the intended Razor handler and HTTP method,
and keep pagination out of the exported query.

## 8. TempData serializer compatibility is a runtime concern

Default TempData serialization supports a limited set of types. Values that must
survive a redirect should use supported primitives—often a string with explicit
parsing—rather than nullable numeric properties that fail at startup/runtime.

## 9. Private storage is safer than the public web root

Attachment authorization is much easier to reason about when no static URL can
bypass it. Metadata-in-SQL plus private files and authorized streaming creates a
clearer security boundary.

## 10. SQL constraints should reinforce application validation

Application messages provide good UX, but races and direct database writes still
exist. Unique indexes, check constraints, and RowVersion protect invariants at the
source of truth.

## 11. Counters must match page queries

An action counter is trustworthy only when it uses the same ownership, status,
archive, and date predicates as the page it opens.

## 12. N/A must not collapse into zero

An empty item set means the value is unknown, not that the prescription is worth
SAR 0. Maintaining nullable semantics across C#, SQL, Python, and Power BI avoids
misclassification and misleading averages.

## 13. Similar workflows still need separate rules

Run-X and Pick-up share item editing and final decisions, but only Run-X has the
SAR 200 eligibility rule. Reuse should centralize mechanics without merging
business policies.

## 14. Source-of-truth semantics should be documented

Clear statements about SQL authority, UTC storage, Saudi business dates, server
ownership, and snapshot behavior make later features safer and reduce accidental
local-only solutions.

## 15. Public portfolios need a separate engineering boundary

A production-style repository should not be pushed directly. A separate clone,
curated allowlist, synthetic data, scans, and manual diff review preserve both
technical depth and confidentiality.
