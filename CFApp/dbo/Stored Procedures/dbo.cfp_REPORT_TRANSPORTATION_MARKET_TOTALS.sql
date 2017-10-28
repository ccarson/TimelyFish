

-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/13/2008
-- Description:	Show quantities in a week going to market
-- Parameters: 	@StartDate
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_MARKET_TOTALS] 
@StartDate DATETIME
AS

CREATE TABLE ##Totals
(	PackerContactID varchar(6)
,	Day0Date smalldatetime
,	Day0TotalQty int
,	Day0EstLbs int
,	Day0ActLbs int
,	Day1Date smalldatetime
,	Day1TotalQty int
,	Day1EstLbs int
,	Day1ActLbs int
,	Day2Date smalldatetime
,	Day2TotalQty int
,	Day2EstLbs int
,	Day2ActLbs int
,	Day3Date smalldatetime
,	Day3TotalQty int
,	Day3EstLbs int
,	Day3ActLbs int
,	Day4Date smalldatetime
,	Day4TotalQty int
,	Day4EstLbs int
,	Day4ActLbs int
,	Day5Date smalldatetime
,	Day5TotalQty int
,	Day5EstLbs int
,	Day5ActLbs int
,	Day6Date smalldatetime
,	Day6TotalQty int
,	Day6EstLbs int
,	Day6ActLbs int)

-- Initialize Packers
INSERT INTO ##Totals (PackerContactID)
SELECT DISTINCT 
	PackerContactID 
FROM	[$(SolomonApp)].dbo.WrkMarketTotals (NOLOCK)
WHERE	Day0Date = @StartDate
OR	Day1Date = DATEADD(day,1,@StartDate)
OR	Day2Date = DATEADD(day,2,@StartDate)
OR	Day3Date = DATEADD(day,3,@StartDate)
OR	Day4Date = DATEADD(day,4,@StartDate)
OR	Day5Date = DATEADD(day,5,@StartDate)
OR	Day6Date = DATEADD(day,6,@StartDate)

-- Day 0
UPDATE ##Totals
SET	Day0Date = WrkMarketTotalSums.Day0Date
,	Day0TotalQty = WrkMarketTotalSums.DayTotalQty
,	Day0EstLbs = WrkMarketTotalSums.Day0EstLbs
,	Day0ActLbs = WrkMarketTotalSums.Day0ActLbs
FROM	(SELECT PackerContactID, Day0Date, SUM(DayTotalQty) 'DayTotalQty', AVG(Day0EstLbs) 'Day0EstLbs', AVG(Day0ActLbs) 'Day0ActLbs' FROM [$(SolomonApp)].dbo.WrkMarketTotals (NOLOCK) GROUP BY PackerContactID, Day0Date) WrkMarketTotalSums
INNER JOIN ##Totals Totals
	ON Totals.PackerContactID = WrkMarketTotalSums.PackerContactID
WHERE	WrkMarketTotalSums.Day0Date = @StartDate


-- Day 1
UPDATE ##Totals
SET	Day1Date = WrkMarketTotalSums.Day1Date
,	Day1TotalQty = WrkMarketTotalSums.Day1TotalQty
,	Day1EstLbs = WrkMarketTotalSums.Day1EstLbs
,	Day1ActLbs = WrkMarketTotalSums.Day1ActLbs
FROM	(SELECT PackerContactID, Day1Date, SUM(Day1TotalQty) 'Day1TotalQty', AVG(Day1EstLbs) 'Day1EstLbs', AVG(Day1ActLbs) 'Day1ActLbs' FROM [$(SolomonApp)].dbo.WrkMarketTotals (NOLOCK) GROUP BY PackerContactID, Day1Date) WrkMarketTotalSums
INNER JOIN ##Totals Totals
	ON Totals.PackerContactID = WrkMarketTotalSums.PackerContactID
WHERE	WrkMarketTotalSums.Day1Date = DATEADD(day,1,@StartDate)

-- Day 2
UPDATE ##Totals
SET	Day2Date = WrkMarketTotalSums.Day2Date
,	Day2TotalQty = WrkMarketTotalSums.Day2TotalQty
,	Day2EstLbs = WrkMarketTotalSums.Day2EstLbs
,	Day2ActLbs = WrkMarketTotalSums.Day2ActLbs
FROM	(SELECT PackerContactID, Day2Date, SUM(Day2TotalQty) 'Day2TotalQty', AVG(Day2EstLbs) 'Day2EstLbs', AVG(Day2ActLbs) 'Day2ActLbs' FROM [$(SolomonApp)].dbo.WrkMarketTotals (NOLOCK) GROUP BY PackerContactID, Day2Date) WrkMarketTotalSums
INNER JOIN ##Totals Totals
	ON Totals.PackerContactID = WrkMarketTotalSums.PackerContactID
WHERE	WrkMarketTotalSums.Day2Date = DATEADD(day,2,@StartDate)

-- Day 3
UPDATE ##Totals
SET	Day3Date = WrkMarketTotalSums.Day3Date
,	Day3TotalQty = WrkMarketTotalSums.Day3TotalQty
,	Day3EstLbs = WrkMarketTotalSums.Day3EstLbs
,	Day3ActLbs = WrkMarketTotalSums.Day3ActLbs
FROM	(SELECT PackerContactID, Day3Date, SUM(Day3TotalQty) 'Day3TotalQty', AVG(Day3EstLbs) 'Day3EstLbs', AVG(Day3ActLbs) 'Day3ActLbs' FROM [$(SolomonApp)].dbo.WrkMarketTotals (NOLOCK) GROUP BY PackerContactID, Day3Date) WrkMarketTotalSums
INNER JOIN ##Totals Totals
	ON Totals.PackerContactID = WrkMarketTotalSums.PackerContactID
WHERE	WrkMarketTotalSums.Day3Date = DATEADD(day,3,@StartDate)

-- Day 4
UPDATE ##Totals
SET	Day4Date = WrkMarketTotalSums.Day4Date
,	Day4TotalQty = WrkMarketTotalSums.Day4TotalQty
,	Day4EstLbs = WrkMarketTotalSums.Day4EstLbs
,	Day4ActLbs = WrkMarketTotalSums.Day4ActLbs
FROM	(SELECT PackerContactID, Day4Date, SUM(Day4TotalQty) 'Day4TotalQty', AVG(Day4EstLbs) 'Day4EstLbs', AVG(Day4ActLbs) 'Day4ActLbs' FROM [$(SolomonApp)].dbo.WrkMarketTotals (NOLOCK) GROUP BY PackerContactID, Day4Date) WrkMarketTotalSums
INNER JOIN ##Totals Totals
	ON Totals.PackerContactID = WrkMarketTotalSums.PackerContactID
WHERE	WrkMarketTotalSums.Day4Date = DATEADD(day,4,@StartDate)

-- Day 5
UPDATE ##Totals
SET	Day5Date = WrkMarketTotalSums.Day5Date
,	Day5TotalQty = WrkMarketTotalSums.Day5TotalQty
,	Day5EstLbs = WrkMarketTotalSums.Day5EstLbs
,	Day5ActLbs = WrkMarketTotalSums.Day5ActLbs
FROM	(SELECT PackerContactID, Day5Date, SUM(Day5TotalQty) 'Day5TotalQty', AVG(Day5EstLbs) 'Day5EstLbs', AVG(Day5ActLbs) 'Day5ActLbs' FROM [$(SolomonApp)].dbo.WrkMarketTotals (NOLOCK) GROUP BY PackerContactID, Day5Date) WrkMarketTotalSums
INNER JOIN ##Totals Totals
	ON Totals.PackerContactID = WrkMarketTotalSums.PackerContactID
WHERE	WrkMarketTotalSums.Day5Date = DATEADD(day,5,@StartDate)

-- Day 6
UPDATE ##Totals
SET	Day6Date = WrkMarketTotalSums.Day6Date
,	Day6TotalQty = WrkMarketTotalSums.Day6TotalQty
,	Day6EstLbs = WrkMarketTotalSums.Day6EstLbs
,	Day6ActLbs = WrkMarketTotalSums.Day6ActLbs
FROM	(SELECT PackerContactID, Day6Date, SUM(Day6TotalQty) 'Day6TotalQty', AVG(Day6EstLbs) 'Day6EstLbs', AVG(Day6ActLbs) 'Day6ActLbs' FROM [$(SolomonApp)].dbo.WrkMarketTotals (NOLOCK) GROUP BY PackerContactID, Day6Date) WrkMarketTotalSums
INNER JOIN ##Totals Totals
	ON Totals.PackerContactID = WrkMarketTotalSums.PackerContactID
WHERE	WrkMarketTotalSums.Day6Date = DATEADD(day,6,@StartDate)


SELECT
	Totals.PackerContactID 
,	cftContact.ShortName 'Packer'
,	Totals.Day0Date 
,	Totals.Day0TotalQty 
,	Totals.Day0EstLbs 
,	Totals.Day0ActLbs 
,	Totals.Day1Date 
,	Totals.Day1TotalQty 
,	Totals.Day1EstLbs 
,	Totals.Day1ActLbs 
,	Totals.Day2Date 
,	Totals.Day2TotalQty 
,	Totals.Day2EstLbs 
,	Totals.Day2ActLbs 
,	Totals.Day3Date 
,	Totals.Day3TotalQty 
,	Totals.Day3EstLbs 
,	Totals.Day3ActLbs 
,	Totals.Day4Date 
,	Totals.Day4TotalQty 
,	Totals.Day4EstLbs 
,	Totals.Day4ActLbs 
,	Totals.Day5Date 
,	Totals.Day5TotalQty 
,	Totals.Day5EstLbs 
,	Totals.Day5ActLbs 
,	Totals.Day6Date 
,	Totals.Day6TotalQty 
,	Totals.Day6EstLbs 
,	Totals.Day6ActLbs 
,	COALESCE(Totals.Day0TotalQty,0) 
+	COALESCE(Totals.Day1TotalQty,0) 
+	COALESCE(Totals.Day2TotalQty,0) 
+	COALESCE(Totals.Day3TotalQty,0) 
+	COALESCE(Totals.Day4TotalQty,0) 
+	COALESCE(Totals.Day5TotalQty,0) 
+	COALESCE(Totals.Day6TotalQty,0) 'OverallQty'
,	CASE WHEN (CASE WHEN COALESCE(Totals.Day0EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day1EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day2EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day3EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day4EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day5EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day6EstLbs,0) = 0 THEN 0 ELSE 1 END) = 0
	THEN	0
	ELSE
		(COALESCE(Totals.Day0EstLbs,0)
		+	COALESCE(Totals.Day1EstLbs,0)
		+	COALESCE(Totals.Day2EstLbs,0)
		+	COALESCE(Totals.Day3EstLbs,0)
		+	COALESCE(Totals.Day4EstLbs,0)
		+	COALESCE(Totals.Day5EstLbs,0)
		+	COALESCE(Totals.Day6EstLbs,0))
		/
		(CASE WHEN COALESCE(Totals.Day0EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day1EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day2EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day3EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day4EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day5EstLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day6EstLbs,0) = 0 THEN 0 ELSE 1 END)
	END 'OverallEstLbs'
,	CASE WHEN (CASE WHEN COALESCE(Totals.Day0ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day1ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day2ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day3ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day4ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day5ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day6ActLbs,0) = 0 THEN 0 ELSE 1 END) = 0
	THEN	0
	ELSE
		(COALESCE(Totals.Day0ActLbs,0)
		+	COALESCE(Totals.Day1ActLbs,0)
		+	COALESCE(Totals.Day2ActLbs,0)
		+	COALESCE(Totals.Day3ActLbs,0)
		+	COALESCE(Totals.Day4ActLbs,0)
		+	COALESCE(Totals.Day5ActLbs,0)
		+	COALESCE(Totals.Day6ActLbs,0))
		/
		(CASE WHEN COALESCE(Totals.Day0ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day1ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day2ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day3ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day4ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day5ActLbs,0) = 0 THEN 0 ELSE 1 END
		+	CASE WHEN COALESCE(Totals.Day6ActLbs,0) = 0 THEN 0 ELSE 1 END)
	END 'OverallActLbs'
FROM	##Totals Totals
INNER JOIN [$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
	ON cftContact.ContactID = Totals.PackerContactID
ORDER BY cftContact.ShortName

drop table ##Totals



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_MARKET_TOTALS] TO [db_sp_exec]
    AS [dbo];

