-- Find duplicate active logical incoming records before adding a unique index.
SELECT
    PharmacyId,
    RecordType,
    NormalizedIdentityKey,
    NormalizedRecordNumber,
    COUNT_BIG(*) AS DuplicateCount
FROM dbo.DemoIncomingRecord
WHERE Status IN ('New', 'In Progress')
GROUP BY
    PharmacyId,
    RecordType,
    NormalizedIdentityKey,
    NormalizedRecordNumber
HAVING COUNT_BIG(*) > 1;

-- Expected release-gate result: zero rows.
