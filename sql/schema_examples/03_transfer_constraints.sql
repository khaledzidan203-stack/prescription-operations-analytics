-- Portfolio-safe transfer lineage and concurrency subset.

CREATE TABLE dbo.DemoPrescriptionTransfer (
    TransferId bigint IDENTITY PRIMARY KEY,
    OriginalPrescriptionId bigint NOT NULL,
    SourcePrescriptionId bigint NOT NULL,
    DestinationPrescriptionId bigint NULL,
    OriginalPharmacyId int NOT NULL,
    FromPharmacyId int NOT NULL,
    ToPharmacyId int NOT NULL,
    TransferType varchar(40) NOT NULL
        CHECK (TransferType IN ('Pre-Dispense', 'Delivery', 'Return to Original')),
    TransferStatus varchar(40) NOT NULL
        CHECK (TransferStatus IN ('Pending Receipt', 'Received', 'Cancelled')),
    CreatedAtUtc datetime2 NOT NULL DEFAULT SYSUTCDATETIME(),
    RowVersion rowversion NOT NULL,
    CONSTRAINT CK_DemoTransfer_DifferentBranches CHECK (FromPharmacyId <> ToPharmacyId),
    CONSTRAINT FK_DemoTransfer_Original FOREIGN KEY (OriginalPrescriptionId)
        REFERENCES dbo.DemoPrescription(PrescriptionId),
    CONSTRAINT FK_DemoTransfer_Source FOREIGN KEY (SourcePrescriptionId)
        REFERENCES dbo.DemoPrescription(PrescriptionId),
    CONSTRAINT FK_DemoTransfer_Destination FOREIGN KEY (DestinationPrescriptionId)
        REFERENCES dbo.DemoPrescription(PrescriptionId)
);

CREATE UNIQUE INDEX UX_DemoTransfer_OnePendingSource
ON dbo.DemoPrescriptionTransfer(SourcePrescriptionId)
WHERE TransferStatus = 'Pending Receipt';
