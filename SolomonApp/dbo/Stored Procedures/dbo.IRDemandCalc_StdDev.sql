 CREATE Procedure IRDemandCalc_StdDev
	@InvtID VarChar(30),
	@SiteID VarChar(10),
	@CurrentPeriod VarChar(6),
	@S4Future03 Float = NULL
As
-- This proc is a helper proc, so Solomon can read the results of the IRDemandCalc procedure.  Solomon does not appear to handle output variables.
-- The usage returned would be for the period BEFORE the one passed in, the monthly total and the UsageperPeriod are for the current month.
Declare @ReturnNbrDaysInPeriod Int
Declare @ReturnUsagePerDay Float
Declare @ReturnUsagePerPeriod Float
Declare @DemandFormID VarChar(10)
Declare @WorkPeriod VarChar(6)
Declare @i Int
Declare @DemPerFromIRSetup Int		-- VM, 12/04/01, DE 227672

Set NoCount On
Select
	@DemandFormID = IRDemandID
From
	IRItemSiteReplenVar
Where
	InvtID = @InvtID
	And SiteID = @SiteID

-- VM, 12/04/01, DE 227672
Select
  @DemPerFromIRSetup = ISNull(DemPeriodNbr,6)
From
  IRSetup

-- VM, 12/04/01, DE 227672
Set @ReturnNbrDaysInPeriod = 22

-- Build work table from helper proc
Execute IRWrkPeriod_Create @CurrentPeriod
	Create Table #WrkPeriodsStdDev
	(
		Period		VarChar(6)	Not Null,
		Number		Int		Null,
		Forecast	Float		Null,
		Processed	SmallInt	Null
	)

	Insert Into #WrkPeriodsStdDev
		(
			Period,
			Number
		)
	Select
		Period,
		Number
	From
		IRWrkPeriod
	Where
		CurrentPeriod = @CurrentPeriod
		-- VM, 12/04/01, DE 227672, Take the value from IRSetup for number of demand periods instead of taking zero.
		-- And IRWrkPeriod.Number <= IsNull((Select Max(PriorPeriodNbr) From IRDemDetail Where IRDemDetail.DemandID = @DemandFormID),0)
		And IRWrkPeriod.Number <= IsNull((Select Max(PriorPeriodNbr) From IRDemDetail Where IRDemDetail.DemandID = @DemandFormID),@DemPerFromIRSetup)

	While Exists (Select * from #WrkPeriodsStdDev where Processed Is Null)
	Begin
		Select @WorkPeriod = (Select Top 1 Period from #WrkPeriodsStdDev Where Processed is null)
		Exec IRDemCalc @InvtID, @SiteID, @WorkPeriod, @ReturnNbrDaysInPeriod, @ReturnUsagePerDay OUTPUT,@ReturnUsagePerPeriod OUTPUT,@S4Future03
		Update
			#WrkPeriodsStdDev
		Set
			Processed = 1,
			Forecast = @ReturnUsagePerPeriod
		Where
			Period = @WorkPeriod
	End
Set NoCount Off
Select
	IsNull	(
			StDev	(
					IsNull(IRItemUsage.DemActual,0.0) + IsNull(IRItemUsage.DemActAdjust,0.0) + IsNull(IRItemUsage.DemOverride,0.0)
					- IsNull(Forecast,0)
				)
			,0
		)
		As 'StdDev'
From
	#WrkPeriodsStdDev
	Left Outer Join IRItemUsage On
					IRItemUsage.Period = #WrkPeriodsStdDev.Period
					And IRItemUsage.InvtID = @InvtID
					And IRItemUsage.SiteID = @SiteID

--  Finish cleanup
Drop Table #WrkPeriodsStdDev



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRDemandCalc_StdDev] TO [MSDSL]
    AS [dbo];

