# Component Map

## Operational components

| Component | Responsibility | Main persistence |
|---|---|---|
| Identity and Pharmacy management | Users, roles, activation, mandatory password change, Pharmacy association | Identity tables, Pharmacy |
| Incoming Records | Excel import, routing, validation, rejected rows, active uniqueness | Import batch and incoming record entities |
| WL workflow | Groups, sequential dispenses, decisions, items, Solver, Preparation, scheduling | Prescription domain |
| Run-X workflow | Items, value eligibility, final decision, operational history | Incoming items and Run-X records |
| Pick-up workflow | Items and final decision without threshold | Incoming items and Pick-up records |
| Missing Items | Pharmacy queue, filters, details, item aggregation | MissingItem |
| Procurement | Requirement selection, batch snapshots, exports, history | Procurement batch and lines |
| Delivery | Pharmacy requests, Admin queue, pull batches, exports | Delivery requests, pull batches, events |
| Transfers | Pre-dispense, delivery, return, receipt, lineage | PrescriptionTransfer and related prescriptions |
| Notifications | Recipient queues, unread state, target URL, deduplication | AppNotification |
| Internal Chat | Direct conversations, broadcast, messages, locations | Conversation, participant, message entities |
| Attachment storage | Validation, private file persistence, authorized download | File storage plus SQL metadata |
| Audit | Critical mutation history | AuditLog |
| Analytics | Pharmacy and Admin KPIs, trends, item and workflow drilldowns | Server-side EF queries |

## Representative reusable services

| Service/helper category | Pattern demonstrated |
|---|---|
| Dashboard services | Scoped aggregation and KPI projection |
| Schedule query helper | One definition for Upcoming/Due/Overdue |
| Prescription search helper | Reusable search/date/status predicates |
| Missing Items helpers | Active/unpulled requirements and item aggregation |
| Operational item service | Server-resolved items, validation, historical snapshots |
| Operational history service | Run-X/Pick-up filters, nullable value semantics, pagination |
| Notification service | Recipient selection, unread state, deduplication |
| Chat service | Participant authorization and message orchestration |
| Attachment storage service | Type/signature/size/path validation |
| Excel services | Multi-sheet exports and controlled report generation |

## UI and navigation

The Page hierarchy separates Admin and Pharmacy areas. Navigation counters are
backed by services using the same authoritative predicates as action queues.
Shared Razor partials provide consistent operational history, item editing, and
details presentation.
