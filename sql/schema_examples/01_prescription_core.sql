-- Generic portfolio schema example.
CREATE TABLE dbo.Site (
    SiteId int IDENTITY PRIMARY KEY,
    SiteCode nvarchar(40) NOT NULL UNIQUE,
    SiteName nvarchar(200) NOT NULL,
    IsActive bit NOT NULL DEFAULT 1
);

CREATE TABLE dbo.OperationalRecord (
    RecordId bigint IDENTITY PRIMARY KEY,
    SiteId int NOT NULL,
    WorkflowCategory nvarchar(40) NOT NULL,
    Status nvarchar(40) NOT NULL,
    BusinessKey nvarchar(120) NOT NULL,
    ScheduledDate date NULL,
    KnownValue decimal(18,2) NULL,
    CreatedAtUtc datetime2 NOT NULL DEFAULT SYSUTCDATETIME(),
    RowVersion rowversion NOT NULL,
    CONSTRAINT FK_OperationalRecord_Site
        FOREIGN KEY (SiteId) REFERENCES dbo.Site(SiteId),
    CONSTRAINT CK_OperationalRecord_KnownValue
        CHECK (KnownValue IS NULL OR KnownValue >= 0)
);

CREATE TABLE dbo.RecordLine (
    RecordLineId bigint IDENTITY PRIMARY KEY,
    RecordId bigint NOT NULL,
    ItemCode nvarchar(80) NOT NULL,
    Quantity int NOT NULL,
    ValueSnapshot decimal(18,2) NULL,
    CONSTRAINT FK_RecordLine_Record
        FOREIGN KEY (RecordId) REFERENCES dbo.OperationalRecord(RecordId),
    CONSTRAINT CK_RecordLine_Quantity CHECK (Quantity > 0),
    CONSTRAINT CK_RecordLine_Value CHECK (ValueSnapshot IS NULL OR ValueSnapshot >= 0)
);

-- Fictional workflow labels only.
ALTER TABLE dbo.OperationalRecord ADD CONSTRAINT CK_OperationalRecord_Workflow
CHECK (WorkflowCategory IN ('Workflow Alpha', 'Workflow Beta', 'Workflow Gamma'));
