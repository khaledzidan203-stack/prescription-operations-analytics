# Core Entity Data Dictionary

The public data model uses fictional entity names. They are designed to demonstrate data-modeling concepts without reproducing a real organization's schema.

| Entity | Purpose and grain | Important fields | Key relationships | Historical behavior |
|---|---|---|---|---|
| `Site` | One synthetic operating location | SiteCode, SiteName, Region, IsActive | Users, records | Identity retained when inactive |
| `ApplicationUser` | One authenticated demo account | UserId, SiteId, IsActive | Optional Site | Account history retained |
| `IncomingRecord` | One synthetic imported record | WorkflowCategory, BusinessKey, Status, CreatedAt | ImportBatch, Site | Intake lineage retained |
| `OperationalRecord` | One workflow occurrence | RecordId, WorkflowCategory, Status, ScheduledAt, RowVersion | Site, lines, exceptions, transfers | Historical state retained |
| `RecordLine` | One line attached to a record | ItemId, Quantity, ValueSnapshot, SortOrder | OperationalRecord, Item | Snapshot protects historical reporting |
| `ExceptionRecord` | One unresolved synthetic requirement | ItemId, RequiredQty, Status | OperationalRecord | Can be included in analytical snapshots |
| `ResourceSnapshot` | One historical requirement snapshot | SnapshotId, CreatedAt | Many snapshot lines | Immutable analytical history |
| `FulfilmentEvent` | One generic fulfilment event | RecordId, Status, RequestedAt, CompletedAt | OperationalRecord | Event history retained |
| `TransferEvent` | One generic transfer movement | SourceSiteId, DestinationSiteId, Status, RowVersion | OperationalRecord and Sites | Lineage retained |
| `Notification` | One user-targeted signal | RecipientId, EventType, IsRead, CreatedAt | ApplicationUser | Communication history retained |
| `Conversation` | One generic collaboration thread | ConversationId, Type, LastActivityAt | Participants, messages | Thread history retained |
| `Message` | One message in a conversation | SenderId, Body, CreatedAt | Conversation | Message history retained |
| `AuditEvent` | One auditable mutation | ActorId, EventType, EntityId, CreatedAt | Generic entities | Immutable audit trail |

## Modeling Notes

- Public workflow categories are `Workflow Alpha`, `Workflow Beta`, and `Workflow Gamma`.
- Unknown values remain nullable rather than being coerced to zero.
- Historical snapshots are used only to demonstrate reproducible reporting.
- Site-scoped entities inherit ownership from the authenticated demo context.

## Publication Boundary

Do not replace these generic entities with real table names, internal acronyms, employer-specific statuses, production identifiers, or mappings to a private schema.