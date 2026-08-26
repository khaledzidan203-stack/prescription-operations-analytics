-- SQL Server compatible synthetic portfolio schema
CREATE TABLE dbo.Branch (
    BranchId varchar(10) NOT NULL PRIMARY KEY,
    BranchName nvarchar(100) NOT NULL,
    City nvarchar(100) NOT NULL
);

CREATE TABLE dbo.Item (
    ItemId varchar(10) NOT NULL PRIMARY KEY,
    ItemName nvarchar(150) NOT NULL,
    Category nvarchar(100) NULL,
    CurrentUnitPrice decimal(18,2) NOT NULL CHECK (CurrentUnitPrice >= 0)
);

CREATE TABLE dbo.Record (
    RecordId varchar(20) NOT NULL PRIMARY KEY,
    CustomerKey varchar(20) NOT NULL,
    BranchId varchar(10) NOT NULL,
    City nvarchar(100) NOT NULL,
    Channel varchar(20) NOT NULL CHECK (Channel IN ('Standard','Call-Back','Pickup')),
    ReceivedDate date NOT NULL,
    FinalStatus varchar(20) NOT NULL CHECK (FinalStatus IN ('Done','Not Yet')),
    NotYetReason nvarchar(200) NULL,
    NextActionDate date NULL,
    DeliveryStatus varchar(20) NOT NULL,
    KnownValueSar decimal(18,2) NULL CHECK (KnownValueSar >= 0),
    CompletedDate date NULL,
    CONSTRAINT FK_Record_Branch FOREIGN KEY (BranchId) REFERENCES dbo.Branch(BranchId)
);

CREATE TABLE dbo.RecordItem (
    RecordId varchar(20) NOT NULL,
    ItemId varchar(10) NOT NULL,
    Quantity int NOT NULL CHECK (Quantity > 0),
    UnitPriceSnapshot decimal(18,2) NOT NULL CHECK (UnitPriceSnapshot >= 0),
    LineTotal AS (Quantity * UnitPriceSnapshot) PERSISTED,
    SortOrder int NOT NULL CHECK (SortOrder >= 0),
    CONSTRAINT PK_RecordItem PRIMARY KEY (RecordId, ItemId, SortOrder),
    CONSTRAINT FK_RecordItem_Record FOREIGN KEY (RecordId) REFERENCES dbo.Record(RecordId),
    CONSTRAINT FK_RecordItem_Item FOREIGN KEY (ItemId) REFERENCES dbo.Item(ItemId)
);

CREATE TABLE dbo.Shortage (
    ShortageId varchar(20) NOT NULL PRIMARY KEY,
    RecordId varchar(20) NOT NULL,
    BranchId varchar(10) NOT NULL,
    ItemId varchar(10) NOT NULL,
    RequiredQty int NOT NULL CHECK (RequiredQty > 0),
    NeededByDate date NULL,
    Status varchar(20) NOT NULL,
    CONSTRAINT FK_Shortage_Record FOREIGN KEY (RecordId) REFERENCES dbo.Record(RecordId),
    CONSTRAINT FK_Shortage_Branch FOREIGN KEY (BranchId) REFERENCES dbo.Branch(BranchId),
    CONSTRAINT FK_Shortage_Item FOREIGN KEY (ItemId) REFERENCES dbo.Item(ItemId)
);
