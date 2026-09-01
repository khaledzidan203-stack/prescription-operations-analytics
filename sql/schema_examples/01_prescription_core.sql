-- Portfolio-safe illustrative SQL derived from the project architecture.
-- Generic subset only; this is not a production schema export.

CREATE TABLE dbo.DemoPharmacy (
    PharmacyId int IDENTITY PRIMARY KEY,
    PharmacyCode varchar(30) NOT NULL UNIQUE,
    DisplayName nvarchar(120) NOT NULL,
    IsActive bit NOT NULL DEFAULT 1
);

CREATE TABLE dbo.DemoPrescriptionGroup (
    GroupId bigint IDENTITY PRIMARY KEY,
    PharmacyId int NOT NULL,
    SyntheticIdentityKey varchar(40) NOT NULL,
    RecordNumber varchar(100) NOT NULL,
    CONSTRAINT FK_DemoGroup_Pharmacy FOREIGN KEY (PharmacyId)
        REFERENCES dbo.DemoPharmacy(PharmacyId),
    CONSTRAINT UQ_DemoGroup_Logical UNIQUE
        (PharmacyId, SyntheticIdentityKey, RecordNumber)
);

CREATE TABLE dbo.DemoPrescription (
    PrescriptionId bigint IDENTITY PRIMARY KEY,
    GroupId bigint NOT NULL,
    PharmacyId int NOT NULL,
    DispenseSequence int NOT NULL CHECK (DispenseSequence > 0),
    WorkflowStatus varchar(30) NOT NULL,
    NextFillAtUtc datetime2 NULL,
    RowVersion rowversion NOT NULL,
    CONSTRAINT FK_DemoPrescription_Group FOREIGN KEY (GroupId)
        REFERENCES dbo.DemoPrescriptionGroup(GroupId),
    CONSTRAINT FK_DemoPrescription_Pharmacy FOREIGN KEY (PharmacyId)
        REFERENCES dbo.DemoPharmacy(PharmacyId),
    CONSTRAINT UQ_DemoPrescription_Sequence UNIQUE (GroupId, DispenseSequence)
);

CREATE TABLE dbo.DemoPrescriptionItem (
    PrescriptionItemId bigint IDENTITY PRIMARY KEY,
    PrescriptionId bigint NOT NULL,
    ItemCode varchar(40) NOT NULL,
    ItemName nvarchar(160) NOT NULL,
    Quantity int NOT NULL CHECK (Quantity > 0),
    UnitPriceSnapshot decimal(18,2) NULL
        CHECK (UnitPriceSnapshot >= 0),
    SortOrder int NOT NULL CHECK (SortOrder >= 0),
    LineTotal AS (Quantity * UnitPriceSnapshot) PERSISTED,
    CONSTRAINT FK_DemoItem_Prescription FOREIGN KEY (PrescriptionId)
        REFERENCES dbo.DemoPrescription(PrescriptionId)
);
