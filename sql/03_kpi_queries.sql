-- Overall KPI validation
SELECT
    COUNT(*) AS TotalRecords,
    SUM(CASE WHEN FinalStatus='Done' THEN 1 ELSE 0 END) AS DoneRecords,
    SUM(CASE WHEN FinalStatus='Not Yet' THEN 1 ELSE 0 END) AS NotYetRecords,
    CAST(SUM(CASE WHEN FinalStatus='Done' THEN 1.0 ELSE 0 END) / NULLIF(COUNT(*),0) AS decimal(10,4)) AS CompletionRate,
    SUM(KnownValueSar) AS KnownRecordValueSar,
    SUM(CASE WHEN KnownValueSar IS NULL THEN 1 ELSE 0 END) AS ValueNARecords,
    SUM(CASE WHEN DeliveryStatus='Delivered' THEN 1 ELSE 0 END) AS DeliveredRecords
FROM dbo.Record;

-- Channel-level performance
SELECT Channel, COUNT(*) Records,
       SUM(CASE WHEN FinalStatus='Done' THEN 1 ELSE 0 END) DoneRecords,
       SUM(KnownValueSar) KnownValueSar,
       SUM(CASE WHEN KnownValueSar IS NULL THEN 1 ELSE 0 END) ValueNARecords
FROM dbo.Record
GROUP BY Channel
ORDER BY Records DESC;

-- Action-oriented item requirements
SELECT * FROM dbo.vw_OpenItemRequirements
ORDER BY RequiredQty DESC, RecordsAffected DESC;
