# Entity Relationships

This ERD is intentionally curated. It shows major business relationships without
reproducing the complete private EF Core model.

```mermaid
erDiagram
    PHARMACY ||--o{ APPLICATION_USER : owns
    PHARMACY ||--o{ INCOMING_RECORD : receives
    IMPORT_BATCH ||--o{ INCOMING_RECORD : contains
    INCOMING_RECORD ||--o{ INCOMING_RECORD_ITEM : has
    INCOMING_RECORD ||--o| PRESCRIPTION : starts_WL
    INCOMING_RECORD ||--o| RUN_X_RECORD : completes_as
    INCOMING_RECORD ||--o| PICK_UP_RECORD : completes_as

    PHARMACY ||--o{ PRESCRIPTION_GROUP : owns
    PRESCRIPTION_GROUP ||--o{ PRESCRIPTION : sequences
    PRESCRIPTION ||--o{ PRESCRIPTION_ITEM : contains
    PRESCRIPTION ||--o{ MISSING_ITEM : requires
    PRESCRIPTION ||--o{ DELIVERY_REQUEST : requests

    PROCUREMENT_BATCH ||--o{ PROCUREMENT_LINE : snapshots
    MISSING_ITEM ||--o| PROCUREMENT_LINE : pulled_as
    PHARMACY ||--o{ PROCUREMENT_LINE : attributed_to

    PRESCRIPTION ||--o{ PRESCRIPTION_TRANSFER : original_reference
    PRESCRIPTION ||--o{ PRESCRIPTION_TRANSFER : source_reference
    PRESCRIPTION ||--o{ PRESCRIPTION_TRANSFER : destination_reference
    PHARMACY ||--o{ PRESCRIPTION_TRANSFER : sends_or_receives

    APPLICATION_USER ||--o{ NOTIFICATION : receives
    CHAT_CONVERSATION ||--o{ CHAT_PARTICIPANT : authorizes
    APPLICATION_USER ||--o{ CHAT_PARTICIPANT : participates
    CHAT_CONVERSATION ||--o{ CHAT_MESSAGE : contains
    CHAT_MESSAGE ||--o{ CHAT_ATTACHMENT : has
    CHAT_MESSAGE ||--o| CHAT_LOCATION : has
```

## Important cardinality observations

- One logical Prescription Group can have multiple sequential dispenses.
- One incoming record completes into only its appropriate workflow record.
- One prescription may have many item/missing/delivery/transfer-related rows.
- A procurement line references one Missing Item snapshot and one Pharmacy.
- A user accesses a chat conversation only through participant membership.

## Ownership

Pharmacy ownership exists directly on core operational entities or is reachable
through a required relationship. Pharmacy handlers still apply explicit scoped
predicates; relationship existence alone is not authorization.
