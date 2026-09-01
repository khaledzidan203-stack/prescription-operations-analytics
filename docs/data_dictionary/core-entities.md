# Core Entity Data Dictionary

| Entity | Purpose and business grain | Important fields | Key relationships | Security ownership | Historical behavior |
|---|---|---|---|---|---|
| `Pharmacy` | One network Pharmacy | Code, name, city, active flag | Users, incoming records, prescriptions | Admin manages; Pharmacy user derives scope through membership | Identity retained even when inactive |
| `ApplicationUser` | One authenticated account | Identity ID, PharmacyId, active flag, must-change-password | Optional Pharmacy, notifications, chat | Identity/role plus Pharmacy association | Created time and account controls retained |
| `IncomingPrescriptionRecord` | One imported/routed operational row | RecordType, normalized identity keys, status, timestamps | Import batch, Pharmacy, items, workflow result | Pharmacy-owned after routing; Admin network scope | Processed rows remain for import lineage |
| `PrescriptionGroup` | One longitudinal WL prescription identity | Pharmacy, prescription number, national identity key | Multiple Prescriptions | Pharmacy-owned | Stable across sequential dispenses |
| `Prescription` | One WL dispense/workflow occurrence | Sequence, Wasfaty state, NextFillAtUtc, delivery state, RowVersion | Group, items, shortages, delivery, transfers | Pharmacy-owned | Delivered record is retained/read-only |
| `PrescriptionItem` | One line within one WL dispense | Item reference, code/name, quantity, UnitPriceSnapshot, sort order | Prescription and optional Item Master | Inherits Prescription Pharmacy | Snapshot prevents retrospective repricing |
| `MissingItem` | One unresolved item requirement for one prescription | Item, quantity, status/timing context | Prescription, optional procurement line | Inherits Prescription Pharmacy | May be snapshotted into Procurement |
| `RunXRecord` | One completed Run-X decision | Decision, reason, completion time | Incoming record, Pharmacy, additional info | Pharmacy-owned | Final decision and item snapshot history retained |
| `PickUpRecord` | One completed Pick-up decision | Decision, reason, completion time | Incoming record, Pharmacy, additional info | Pharmacy-owned | Final decision and item snapshot history retained |
| `AdminDeliveryRequest` | One prescription submitted to Admin delivery queue | Prescription, Pharmacy, status, pull batch | Prescription, Pharmacy, optional batch | Pharmacy creates owned request; Admin processes globally | Request-to-batch membership retained |
| `PrescriptionTransfer` | One transfer hop | Type, status, original/source/destination IDs, Pharmacy lineage, RowVersion | Prescriptions and three Pharmacy roles | Sender/receiver determined server-side | Chain lineage and receipt/return timestamps retained |
| `ProcurementBatch` | One Admin pull decision | Batch number, creation/export context | Many procurement lines | Admin only | Immutable operational batch identity |
| `AppNotification` | One user-targeted signal | Recipient, event type, message, URL, dedup key, read time | ApplicationUser | Recipient-only read/open | Remains as event communication history |
| `ChatConversation` | One direct collaboration thread | Type, direct key, activity time | Participants and messages | Participant membership | Conversation/message history retained |
| `ChatMessage` | One message in a conversation | Sender, body, UTC time, broadcast group | Conversation, attachments, optional location | Participant-authorized | Metadata and private attachment references retained |

## Terminology note

Public sample data uses synthetic identifiers and may flatten some relationships
for analytics. The operational entity grains above remain the authoritative
architecture concepts.
