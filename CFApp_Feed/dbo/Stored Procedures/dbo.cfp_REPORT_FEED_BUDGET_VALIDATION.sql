
CREATE procedure [dbo].[cfp_REPORT_FEED_BUDGET_VALIDATION]
(@UnderBudgetPct numeric(4,1)
,@OverBudgetPct numeric(4,1)
,@PigProdPhaseID varchar(8000))

AS
IF @UnderBudgetPct IS NULL
	SET @UnderBudgetPct = 0
IF @OverBudgetPct IS NULL
	SET @OverBudgetPct = 0

create table #PigProdPhaseID (Value varchar(100))
insert into #PigProdPhaseID select * from [$(SolomonApp)].dbo.cffn_SPLIT_STRING(@PigProdPhaseID,',')

SELECT 
	fbp.SiteContactID,
	fbp.SiteName,
	fbp.PigGroupID, 
	fbp.EstInventory, 
	fbp.PigGenderTypeID,
	fbp.PigProdPhaseID,
	fbp.PGStatusID,
	fbp.FeedPlanType, 
	fbp.DateSwitchedToIndPlan,
	fbp.CalcCurWgt,
    fbp.ActStartWgt,
	fbp.AvgPriorFeed,
	fbp.StartQty, 
	fbp.RoomNbr,
	fbp.FeedRep,
	fbp.SvcMgr,
	fbp.UseActuals,
	fbp.PigSystem, 
	fbp.LastRationOrd,
	fbp.LastRationDel,
	fbp.PriorFeedQty, 
	ActualLbPerHead = fbp.ActualLbsHead,
	fbp.BudgetedLbPerHead, 
	fbp.PctBudgetComplete
FROM cfv_REPORT_FEED_BUDGET_PERCENT_ALL fbp
JOIN #PigProdPhaseID phases
	on phases.Value = fbp.PigProdPhaseID
WHERE fbp.PctBudgetComplete < @UnderBudgetPct
OR fbp.PctBudgetComplete > @OverBudgetPct

drop table #PigProdPhaseID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_FEED_BUDGET_VALIDATION] TO PUBLIC
    AS [dbo];

