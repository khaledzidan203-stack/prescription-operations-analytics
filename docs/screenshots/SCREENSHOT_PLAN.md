# Synthetic Screenshot Plan

No screenshot from the private application may be reused. Each future image must
be produced from a public-safe demo or documentation mockup using synthetic data.

| # | Screenshot | Intended evidence | Required synthetic content |
|---|---|---|---|
| 1 | Executive/project overview | Problem, domains, architecture | Generic product title and diagrams |
| 2 | Pharmacy dashboard | Pharmacy-scoped KPIs and trends | `DEMO-PH-*` only |
| 3 | Admin dashboard | Network scope and workflow sections | Synthetic pharmacies/cities |
| 4 | WL processing | Group, sequence, decision, items | Synthetic prescription and patient keys |
| 5 | Run-X | Items, decision, SAR threshold validation | Synthetic value cases above/equal/below 200 |
| 6 | Pick-up | Independent final-decision flow | No SAR threshold visualization |
| 7 | Upcoming/Due/Overdue | Saudi calendar queue definitions | Synthetic Next Fill dates |
| 8 | Missing Items | Searchable Pharmacy shortage queue | Demo items and quantities |
| 9 | Procurement | Requirement grouping and batch history | Synthetic batch and Pharmacy codes |
| 10 | Delivery | Request and Admin pull flow | Synthetic request IDs |
| 11 | Transfers | Pending/received/cancelled lineage | Demo source/destination pharmacies |
| 12 | Notifications | Unread state and operational target | Generic event messages |
| 13 | Internal Chat | Direct and broadcast conversation UX | Synthetic users/messages |
| 14 | Attachment sharing | Private file metadata and controls | Harmless generated demo file |
| 15 | Analytics dashboard | SQL/Python/Power BI companion | Existing synthetic analytics data |

## Current safe screenshots

- `screenshots/admin_dashboard.png`
- `screenshots/branch_dashboard.png`

These existing images were generated from the original synthetic analytics
dataset. They remain useful as the Operational Analytics Companion preview but do
not represent the private ASP.NET Core UI.

## Acceptance checklist

- No real names, IDs, Pharmacy codes, messages, coordinates, or prescription data.
- No company branding without explicit approval.
- No browser address bar with internal hostname.
- No Windows path, database name, or server detail.
- Image corresponds to documented public synthetic data.
- Manual privacy review completed before commit.
