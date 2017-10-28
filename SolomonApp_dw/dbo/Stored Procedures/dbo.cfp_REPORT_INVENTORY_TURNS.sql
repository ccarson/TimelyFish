CREATE PROCEDURE [dbo].[cfp_REPORT_INVENTORY_TURNS]
	@StartFiscalYear INT
,	@StartFiscalPeriod INT
,	@EndFiscalYear INT
,	@EndFiscalPeriod INT
,	@SiteID varchar(1000)
AS

--Prep
DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
DECLARE @NumWeeks INT

select @StartDate = MIN(WeekOfDate) from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) where FiscalYear = @StartFiscalYear and FiscalPeriod = @StartFiscalPeriod
select @EndDate = MAX(WeekEndDate) from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) where FiscalYear = @EndFiscalYear and FiscalPeriod = @EndFiscalPeriod

SELECT @NumWeeks = DATEDIFF(week, @StartDate, @EndDate) + 1

create table #SiteID (Value varchar(100))
insert into #SiteID select * from [$(SolomonApp)].dbo.cffn_SPLIT_STRING(@SiteID,',')

-- Report Data
SELECT 
	Inventory.InvtID, 
	ItemSite.SiteID, 
	Site.Name, 
	Inventory.Descr, 
	ISNULL(ItemSite.QtyOnHand,0) - ISNULL(SubtractIssues.IssuesFromEndPeriod,0) QtyOnHand, 
	SUM(cft_INVENTORY_ROLLUP.QtyIssued) QtyIssued,
	WksOfInvt = CAST(CASE WHEN (SUM(cft_INVENTORY_ROLLUP.QtyIssued) / @NumWeeks) <> 0 
					THEN QtyOnHand / (SUM(cft_INVENTORY_ROLLUP.QtyIssued) / @NumWeeks)
					ELSE 0
				END AS NUMERIC(14,2)),
	ItemSite.TotCost, 
	SUM(cft_INVENTORY_ROLLUP.Cost) Cost,
	CONVERT(VARCHAR,MAX(cft_INVENTORY_ROLLUP.LastIssueDate),101) LastIssueDate
FROM   [$(SolomonApp)].dbo.Inventory Inventory (NOLOCK)
INNER JOIN [$(SolomonApp)].dbo.ItemSite ItemSite (NOLOCK)
	ON Inventory.InvtID=ItemSite.InvtID
INNER JOIN [$(SolomonApp)].dbo.Site Site (NOLOCK)
	ON ItemSite.SiteID=Site.SiteId
LEFT OUTER JOIN  dbo.cft_INVENTORY_ROLLUP cft_INVENTORY_ROLLUP (NOLOCK)
	ON rtrim(cft_INVENTORY_ROLLUP.InvtId) = rtrim(Inventory.InvtID)
	AND rtrim(cft_INVENTORY_ROLLUP.SiteID) = rtrim(Site.SiteID)
LEFT OUTER JOIN (SELECT InvtID, SiteID, sum(QtyIssued) IssuesFromEndPeriod
				FROM cft_INVENTORY_ROLLUP cft_INVENTORY_ROLLUP (NOLOCK)
				INNER JOIN (SELECT FiscalYear, FiscalPeriod, MIN(WeekOfDate) WeekOfDate, MAX(WeekEndDate) WeekEndDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) GROUP BY FiscalYear, FiscalPeriod) cftWeekDefinition
					ON cftWeekDefinition.FiscalYear = cft_INVENTORY_ROLLUP.FiscalYear
					AND cftWeekDefinition.FiscalPeriod = cft_INVENTORY_ROLLUP.FiscalPeriod
				WHERE cftWeekDefinition.WeekOfDate > @EndDate
				GROUP BY InvtID, SiteID) SubtractIssues
	ON SubtractIssues.InvtID = cft_INVENTORY_ROLLUP.InvtID
	AND SubtractIssues.SiteID = cft_INVENTORY_ROLLUP.SiteID
INNER JOIN #SiteID Sites
	ON Sites.Value = RTRIM(ItemSite.SiteID)
WHERE	ItemSite.QtyOnHand<>0
	AND cft_INVENTORY_ROLLUP.TranType NOT IN ('ct', 'rc', 'pi')
GROUP BY 
	Inventory.InvtID, 
	ItemSite.SiteID, 
	Site.Name, 
	Inventory.Descr, 
	ItemSite.QtyOnHand, 
	ItemSite.TotCost,
	SubtractIssues.IssuesFromEndPeriod
ORDER BY 
	ItemSite.SiteID,
	Inventory.InvtID
	


DROP TABLE #SiteID



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_INVENTORY_TURNS] TO [db_sp_exec]
    AS [dbo];

