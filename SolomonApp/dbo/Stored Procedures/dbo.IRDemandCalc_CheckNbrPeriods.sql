 CREATE Procedure IRDemandCalc_CheckNbrPeriods
	@InvtID VarChar(30),
	@SiteID VarChar(10),
	@CurrentPeriod VarChar(6)
As
-- This proc is a helper proc, so Solomon can read the results of the IRDemandCalc procedure.  Solomon does not appear to handle output variables.
-- The usage returned would be for the period BEFORE the one passed in, the monthly total and the UsageperPeriod are for the current month.
Declare @ReturnNbrDaysInPeriod Int
Declare @ReturnUsagePerDay Float
Declare @ReturnUsagePerPeriod Float
Declare @DemandFormID VarChar(10)
Declare @WorkPeriod VarChar(6)
Declare @ReplaceItem VarChar(30)
Declare @i Int
Set NoCount On
Select
	@DemandFormID = IRDemandID,
	@ReplaceItem = IRModelInvtID
From
	IRItemSiteReplenVar
Where
	InvtID = @InvtID
	And SiteID = @SiteID

-- Build work table, if that is needed, in a helper proc
Execute IRWrkPeriod_Create @CurrentPeriod

Set NoCount Off
Select
	Count(*) As 'Errors'
From
	IRWrkPeriod
	Left Outer Join IRItemUsage On
					IRItemUsage.Period = IRWrkPeriod.Period
					And IRItemUsage.InvtID = @InvtID
					And IRItemUsage.SiteID = @SiteID
	Left Outer Join IRItemUsage As IRIUReplacement On
					IRIUReplacement.Period = IRWrkPeriod.Period
					And IRIUReplacement.InvtID = @ReplaceItem
					And IRIUReplacement.SiteID = @SiteID
Where
	-- Where No Usage is given
	0 = Coalesce	(
				-- Try the given item first
				NullIf((IsNull(IRItemUsage.DemActual,0) + IsNull(IRItemUsage.DemActAdjust,0) + IsNull(IRItemUsage.DemOverride,0)),0),
				-- The Replacement item next
				NullIf((IsNull(IRIUReplacement.DemActual,0) + IsNull(IRIUReplacement.DemActAdjust,0) + IsNull(IRIUReplacement.DemOverride,0)),0),
				-- Last, just use 0
				0
			)
	And IRWrkPeriod.Number <= IsNull((Select Max(PriorPeriodNbr) From IRDemDetail Where IRDemDetail.DemandID = @DemandFormID),0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRDemandCalc_CheckNbrPeriods] TO [MSDSL]
    AS [dbo];

