-- Expected result for each check is zero.

SELECT COUNT(*) AS InvalidPrescriptionItems
FROM dbo.DemoPrescriptionItem
WHERE Quantity <= 0
   OR UnitPriceSnapshot < 0
   OR SortOrder < 0;

SELECT COUNT(*) AS OrphanMissingItems
FROM dbo.DemoMissingItem AS m
LEFT JOIN dbo.DemoPrescription AS p
    ON p.PrescriptionId = m.PrescriptionId
WHERE p.PrescriptionId IS NULL;

SELECT COUNT(*) AS InvalidTransferBranches
FROM dbo.DemoPrescriptionTransfer
WHERE FromPharmacyId = ToPharmacyId;

SELECT COUNT(*) AS DuplicateProcurementPulls
FROM dbo.DemoProcurementLine
GROUP BY MissingItemId
HAVING COUNT(*) > 1;
