-- Portfolio-safe Missing Items and Procurement subset.

CREATE TABLE dbo.DemoMissingItem (
    MissingItemId bigint IDENTITY PRIMARY KEY,
    PrescriptionId bigint NOT NULL,
    PharmacyId int NOT NULL,
    ItemCode varchar(40) NOT NULL,
    ItemName nvarchar(160) NOT NULL,
    RequiredQuantity int NOT NULL CHECK (RequiredQuantity > 0),
    IsResolved bit NOT NULL DEFAULT 0,
    CONSTRAINT FK_DemoMissing_Prescription FOREIGN KEY (PrescriptionId)
        REFERENCES dbo.DemoPrescription(PrescriptionId)
);

CREATE TABLE dbo.DemoProcurementBatch (
    BatchId bigint IDENTITY PRIMARY KEY,
    BatchNumber varchar(40) NOT NULL UNIQUE,
    CreatedAtUtc datetime2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.DemoProcurementLine (
    LineId bigint IDENTITY PRIMARY KEY,
    BatchId bigint NOT NULL,
    MissingItemId bigint NOT NULL UNIQUE,
    PharmacyId int NOT NULL,
    PharmacyCodeSnapshot varchar(30) NOT NULL,
    ItemCodeSnapshot varchar(40) NOT NULL,
    ItemNameSnapshot nvarchar(160) NOT NULL,
    RequiredQuantitySnapshot int NOT NULL CHECK (RequiredQuantitySnapshot > 0),
    CONSTRAINT FK_DemoProcurementLine_Batch FOREIGN KEY (BatchId)
        REFERENCES dbo.DemoProcurementBatch(BatchId),
    CONSTRAINT FK_DemoProcurementLine_Missing FOREIGN KEY (MissingItemId)
        REFERENCES dbo.DemoMissingItem(MissingItemId)
);
