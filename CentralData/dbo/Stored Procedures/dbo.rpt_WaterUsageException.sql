CREATE PROCEDURE dbo.rpt_WaterUsageException 

AS

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

DECLARE @MaxWaterMeterReading TABLE(SiteContactId INT, MaxOfDateRead smalldatetime)
DECLARE @FourWeekUsageExceptions TABLE(ContactId INT, AvgWaterUsage Decimal(4,2))
DECLARE @TwelveWeekUsageExceptions TABLE(ContactId INT, AvgWaterUsage Decimal(4,2))
DECLARE @TwentySixWeekUsageExceptions TABLE(ContactId INT, AvgWaterUsage Decimal(4,2))

INSERT INTO @MaxWaterMeterReading
SELECT SiteContactId, MAX(DateRead) FROM WaterMeterReading GROUP BY SiteContactId;

--FOUR WEEK EXCEPTIONS
INSERT INTO @FourWeekUsageExceptions
SELECT 
	ContactId
	,CAST(SUM(wmr.Consumption) / AVG(wmr.Inventory) / SUM(wmr.DaysSinceLastReading) AS DECIMAL(4,2)) WaterUsage
FROM watermeterreading wmr WITH (NOLOCK)
INNER JOIN Contact c  WITH (NOLOCK) ON wmr.SiteContactID = c.ContactID 
WHERE DATEDIFF(ww, wmr.DateRead, GETDATE()) <= 4
AND ContactName like 'F%'
GROUP BY ContactId, SiteContactId
HAVING SUM(wmr.DaysSinceLastReading) <> 0
ORDER BY ContactId

--TWELVE WEEK EXCEPTIONS
INSERT INTO @TwelveWeekUsageExceptions
SELECT 
	ContactId
	,cast(SUM(wmr.Consumption) / AVG(wmr.Inventory) / SUM(wmr.DaysSinceLastReading) AS DECIMAL(4,2)) WaterUsage
	--,sum(SiteContactId) / SiteContactId NumOfReadings
FROM watermeterreading wmr WITH (NOLOCK)
INNER JOIN Contact c  WITH (NOLOCK) ON wmr.SiteContactID = c.ContactID 
WHERE DATEDIFF(ww, wmr.DateRead, GETDATE()) <= 12
AND ContactName like 'F%'
GROUP BY ContactId, SiteContactId
HAVING SUM(wmr.DaysSinceLastReading) <> 0
ORDER BY ContactId

--TWENTY SIX WEEK EXCEPTIONS
INSERT INTO @TwentySixWeekUsageExceptions
SELECT 
	ContactId
	,cast(SUM(wmr.Consumption) / AVG(wmr.Inventory) / SUM(wmr.DaysSinceLastReading) AS DECIMAL(4,2)) WaterUsage
	--,sum(SiteContactId) / SiteContactId NumOfReadings
FROM watermeterreading wmr WITH (NOLOCK)
INNER JOIN Contact c  WITH (NOLOCK) ON wmr.SiteContactID = c.ContactID 
WHERE DATEDIFF(ww, wmr.DateRead, GETDATE()) <= 26
AND ContactName like 'F%'
GROUP BY ContactId, SiteContactId
HAVING SUM(wmr.DaysSinceLastReading) <> 0  
ORDER BY ContactId

SELECT distinct
	RTRIM(ContactName) ContactName
	,ISNULL(FourWk.AvgWaterUsage, 0) FourWeekUsage
	,ISNULL(TwelveWk.AvgWaterUsage, 0) TwelveWeekUsage
	,ISNULL(TwentySixWk.AvgWaterUsage, 0) TwentySixWeekUsage
	,CAST(CONVERT(VARCHAR(50),MaxOfDateRead, 101) AS VARCHAR(10)) LastReportDate
FROM WaterMeterReading wmr WITH (NOLOCK)
INNER JOIN Contact c WITH (NOLOCK) 			ON wmr.SiteContactId = c.ContactId
LEFT JOIN @FourWeekUsageExceptions FourWk 		ON wmr.SiteContactId = FourWk.ContactId
LEFT JOIN @TwelveWeekUsageExceptions TwelveWk 		ON wmr.SiteContactId = TwelveWk.ContactId
LEFT JOIN @TwentySixWeekUsageExceptions TwentySixWk 	ON wmr.SiteContactId = TwentySixWk.ContactId
INNER JOIN @MaxWaterMeterReading mwmr 			ON wmr.SiteContactId = mwmr.SiteContactId
WHERE wmr.SiteContactId IN (
				SELECT four.ContactId FROM @FourWeekUsageExceptions four
				LEFT JOIN @TwelveWeekUsageExceptions twelve ON four.ContactId = twelve.ContactId
				LEFT JOIN @TwentySixWeekUsageExceptions twentysix ON four.ContactId = twentysix.ContactId
				WHERE FourWk.AvgWaterUsage > 1.6
				OR TwelveWk.AvgWaterUsage > 1.4
				OR TwentySixWk.AvgWaterUsage > 1.3
			)

