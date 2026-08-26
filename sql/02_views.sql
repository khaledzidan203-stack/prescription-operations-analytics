CREATE OR ALTER VIEW dbo.vw_RecordAnalytics AS
SELECT
    r.RecordId, r.BranchId, b.BranchName, r.City, r.Channel, r.ReceivedDate,
    r.FinalStatus, r.NotYetReason, r.NextActionDate, r.DeliveryStatus,
    r.KnownValueSar,
    CASE WHEN r.KnownValueSar IS NULL THEN 1 ELSE 0 END AS IsValueNA
FROM dbo.Record r
JOIN dbo.Branch b ON b.BranchId = r.BranchId;
GO

CREATE OR ALTER VIEW dbo.vw_OpenItemRequirements AS
SELECT
    s.ItemId, i.ItemName, s.BranchId, b.BranchName,
    SUM(s.RequiredQty) AS RequiredQty,
    COUNT(DISTINCT s.RecordId) AS RecordsAffected
FROM dbo.Shortage s
JOIN dbo.Item i ON i.ItemId=s.ItemId
JOIN dbo.Branch b ON b.BranchId=s.BranchId
WHERE s.Status='Open'
GROUP BY s.ItemId, i.ItemName, s.BranchId, b.BranchName;
GO
