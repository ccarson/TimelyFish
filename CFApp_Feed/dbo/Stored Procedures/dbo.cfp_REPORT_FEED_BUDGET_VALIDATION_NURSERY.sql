

CREATE procedure [dbo].[cfp_REPORT_FEED_BUDGET_VALIDATION_NURSERY]
(@UnderBudgetPct numeric(4,1)
,@OverBudgetPct numeric(4,1)
,@InvtID varchar(200)
,@StartDate datetime
,@EndDate datetime
,@PigGroupID varchar(5))
AS

IF @UnderBudgetPct IS NULL
	SET @UnderBudgetPct = 0
IF @OverBudgetPct IS NULL
	SET @OverBudgetPct = 0

IF @InvtID IS NULL
	SET @InvtID = '%'

IF @StartDate IS NULL
	SET @StartDate = '1/1/1900'
IF @EndDate IS NULL
	SET @EndDate = '1/1/3000'

IF @PigGroupID IS NULL
	SET @PigGroupID = '%'

--GROUP DATA
SELECT
	fbp.SiteContactID
,	fbp.SiteName
,	fbp.PigGroupID
,	fbp.RoomNbr
,	fbp.InvtIdOrd
,	fbp.EstInventory
,	fbp.CurrentInv
,	fbp.UseActualsFlag
,	RTRIM(ps.Description) 'PigSystem'
,	SUM(CAST(fbp.ActualLbsHead AS NUMERIC(14,2))) ActualLbsHead
,	CAST(fbp.BudgetedLbsHead AS NUMERIC(14,4)) BudgetedLbsHead
INTO #ReportData_fbvn
FROM [dbo].cfv_REPORT_FEED_BUDGET_PERCENT fbp
LEFT JOIN [$(SolomonApp)].dbo.cftPigSystem ps (nolock) 
	ON fbp.PigSystemID = ps.PigSystemID
WHERE (InvtIdOrd LIKE ('041%')
OR InvtIdOrd LIKE ('042%')
OR InvtIdOrd LIKE ('043%')
OR InvtIdOrd LIKE ('044%'))
AND InvtIdOrd LIKE '%' + @InvtID + '%'
AND (fbp.DateDel BETWEEN @StartDate AND @EndDate
	OR fbp.DateReq BETWEEN @StartDate AND @EndDate)
AND fbp.PigGroupID LIKE '%' + @PigGroupID + '%'
GROUP BY
	fbp.SiteContactID
,	fbp.SiteName
,	fbp.PigGroupID
,	fbp.RoomNbr
,	fbp.InvtIdOrd
,	fbp.EstInventory
,	fbp.CurrentInv
,	fbp.UseActualsFlag
,	RTRIM(ps.Description)
,	CAST(fbp.BudgetedLbsHead AS NUMERIC(14,4))




-- GET REPORT DATA
SELECT 
	SiteContactID
,	SiteName
,	PigGroupID
,	RoomNbr
,	InvtIdOrd
,	BudgetPercent = 
		CASE WHEN (BudgetedLbsHead = 0)
			THEN	0
			ELSE	CAST((ActualLbsHead / BudgetedLbsHead) * 100 AS NUMERIC (10,2))
		END
,	EstInventory
,	CurrentInv
,	UseActualsFlag
,	PigSystem
,	ActualLbsHead
,	BudgetedLbsHead
FROM #ReportData_fbvn
WHERE
-- BUDGET PERCENTAGE RANGE
((CASE WHEN (BudgetedLbsHead = 0)
		THEN	0
		ELSE	CAST((ActualLbsHead / BudgetedLbsHead) * 100 AS NUMERIC (10,2))
	END) <= @UnderBudgetPct
OR	(CASE WHEN (BudgetedLbsHead = 0)
		THEN	0
		ELSE	CAST((ActualLbsHead / BudgetedLbsHead) * 100 AS NUMERIC (10,2))
	END) >= @OverBudgetPct)

ORDER BY
		CASE WHEN (BudgetedLbsHead = 0)
			THEN	0
			ELSE	CAST((ActualLbsHead / BudgetedLbsHead) * 100 AS NUMERIC (10,2))
		END

DROP TABLE #ReportData_fbvn
		

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_FEED_BUDGET_VALIDATION_NURSERY] TO [db_sp_exec]
    AS [dbo];

