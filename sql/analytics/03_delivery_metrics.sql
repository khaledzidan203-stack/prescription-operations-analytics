-- Illustrative table names for a synthetic reporting model.
SELECT
    PharmacyId,
    COUNT(*) AS DeliveryRequests,
    SUM(CASE WHEN RequestStatus = 'Pending' THEN 1 ELSE 0 END) AS PendingRequests,
    SUM(CASE WHEN RequestStatus = 'Pulled' THEN 1 ELSE 0 END) AS PulledRequests,
    SUM(CASE WHEN DeliveryStatus = 'Done' THEN 1 ELSE 0 END) AS CompletedDeliveries,
    SUM(CASE WHEN DeliveryStatus = 'Transferred' THEN 1 ELSE 0 END) AS TransferredDeliveries
FROM dbo.DemoDeliveryRequest
GROUP BY PharmacyId
ORDER BY DeliveryRequests DESC;
