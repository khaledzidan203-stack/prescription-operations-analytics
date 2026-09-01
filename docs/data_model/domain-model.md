# Domain Model

## Modeling approach

The operational model separates logical prescription identity, one dispense
workflow, item-level history, network coordination, and collaboration. This keeps
business grains explicit and avoids using one overloaded table for unrelated
workflows.

## Domain groups

### Identity and tenancy

- `Pharmacy` is the operational ownership boundary.
- `ApplicationUser` optionally belongs to one Pharmacy and carries active/password
  control flags in addition to Identity fields.

### Incoming Records

- `IncomingImportBatch` represents one validated Excel upload.
- `IncomingPrescriptionRecord` is one routed row awaiting or completing a workflow.
- Additional information, rejected rows, and operational items retain structured
  row-level context.
- An SQL active logical key prevents duplicate New/In Progress records.

### WL prescriptions

- `PrescriptionGroup` is the longitudinal logical prescription.
- `Prescription` is one dispense sequence and its workflow state.
- `PrescriptionItem` stores quantity and historical price snapshot.
- Additional information, Missing Items, Solver invoices, and delivery events
  belong to a specific dispense.

### Run-X and Pick-up

- Each final record links one-to-one to its incoming record and Pharmacy.
- Both use incoming operational items, while their decision rules remain separate.
- Empty items produce nullable/unknown value semantics.

### Delivery, transfer, and procurement

- `AdminDeliveryRequest` links an eligible prescription to an Admin action queue.
- Pull batches group delivery requests for an operational export.
- `PrescriptionTransfer` preserves original/source/destination lineage.
- Procurement batches and lines snapshot selected Missing Item requirements.

### Collaboration and governance

- Notifications belong to recipients and track unread/open state.
- Chat conversations have participants and messages; messages may have attachments
  and one location.
- AuditLog records critical workflow mutations with UTC timestamps and technical
  identifiers.

## Persistence principles

- SQL Server is the source of truth.
- UTC is stored; Saudi business dates are calculated explicitly.
- Client-supplied identity, ownership, price, and workflow state are revalidated.
- Check constraints, unique indexes, and row versions reinforce application logic.
