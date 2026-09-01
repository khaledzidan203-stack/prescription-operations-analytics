-- Synthetic parameters for a standalone portfolio example.
-- The application calculates TodayStartUtc from the Saudi business date.
DECLARE @AuthenticatedPharmacyId int = 1;
DECLARE @TodayStartUtc datetime2 = '2026-08-31T21:00:00';
DECLARE @TomorrowStartUtc datetime2 = DATEADD(day, 1, @TodayStartUtc);
DECLARE @DueEndExclusiveUtc datetime2 = DATEADD(day, 6, @TodayStartUtc);
DECLARE @NowUtc datetime2 = SYSUTCDATETIME();

SELECT
    SUM(CASE WHEN NextFillAtUtc > @NowUtc THEN 1 ELSE 0 END) AS UpcomingCount,
    SUM(CASE WHEN NextFillAtUtc >= @TodayStartUtc
              AND NextFillAtUtc < @DueEndExclusiveUtc THEN 1 ELSE 0 END) AS DueCount,
    SUM(CASE WHEN NextFillAtUtc < @TodayStartUtc THEN 1 ELSE 0 END) AS OverdueCount,
    SUM(CASE WHEN NextFillAtUtc >= @TodayStartUtc
              AND NextFillAtUtc < @TomorrowStartUtc THEN 1 ELSE 0 END) AS DueTodayCount
FROM dbo.DemoPrescription
WHERE PharmacyId = @AuthenticatedPharmacyId
  AND WorkflowStatus = 'Not Yet'
  AND NextFillAtUtc IS NOT NULL;
