SELECT
    m.PharmacyId,
    m.ItemCode,
    m.ItemName,
    SUM(m.RequiredQuantity) AS RequiredQuantity,
    COUNT(DISTINCT m.PrescriptionId) AS PrescriptionsAffected
FROM dbo.DemoMissingItem AS m
LEFT JOIN dbo.DemoProcurementLine AS pulled
    ON pulled.MissingItemId = m.MissingItemId
WHERE m.IsResolved = 0
  AND pulled.MissingItemId IS NULL
GROUP BY m.PharmacyId, m.ItemCode, m.ItemName
ORDER BY RequiredQuantity DESC, PrescriptionsAffected DESC;
