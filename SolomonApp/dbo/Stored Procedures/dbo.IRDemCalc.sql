 CREATE Procedure IRDemCalc
	@InvtID VarChar(30),
	@SiteID VarChar(10),
	@CurrentPeriod VarChar(6),
	@NbrDaysInPeriod Int,
	@ReturnUsagePerDay Float OUTPUT,
	@ReturnUsagePerPeriod Float OUTPUT,
	@S4Future03 Float = NULL

As

-- will determine the Daily average of the prior periods, then apply the daily average to the current period's number of work days
Declare @DemandFormID VarChar(10)
Declare @WeightedSum Float
Declare @WeightSum Float
Declare @i Int
Declare @ReplacementPart VarChar(30)
Declare @TrendPct Money
Declare @RecordsIRWrkPeriod Int
Declare @NbrPeriod Int
Declare @NbrPerToUse Int
Declare @PeriodTotal Float

-- The number of days is set to 22 per documentation from Mitch at Solomon
Set NoCount On

-- Determine demand formula to use
Select
	@DemandFormID = IRDemandID,
	@ReplacementPart = IRModelInvtID
From
	IRItemSiteReplenVar
Where
	InvtID = @InvtID
	And SiteID = @SiteID

If RTrim(IsNull(@ReplacementPart,'')) = ''
	-- Replacement not found, so just use self
	Set @ReplacementPart = @InvtID

-- VM, 9/13/01, Create IRWrkPeriod table regardless of Demand Formula present or not.
Execute IRWrkPeriod_Create @CurrentPeriod

If Exists (Select * from IRDemDetail Where DemandID = @DemandFormID)
Begin
	-- Demand Formula does have entries, so use them
	-- Need a list of periods
	-- Build work table from helper proc
	-- Execute IRWrkPeriod_Create @CurrentPeriod

	-- So now IRWrkPeriod should have a list of Accounting periods, and how far back they are
	-- This will be used to determine the weight needed per item below.
	Set @WeightedSum = 0
	Select
		@WeightedSum = IsNull	(
						Sum	(
								IRDemDetail.Weight *
								(
									Coalesce	(
												NullIf 	(
														(
															IsNull(IRItemUsage.DemActual,0.0)
															+ IsNull(IRItemUsage.DemActAdjust,0)
															+ IsNull(IRItemUsage.DemOverride,0)
														)
														,0.0
													),
												NullIf	(
														(
															IsNull(Replacement.DemActual,0.0)
															+ IsNull(Replacement.DemActAdjust,0)
															+ IsNull(Replacement.DemOverride,0)
														)
														,0.0
													),
												0.0
											)
								)
								-- VM, 09/12/01, The following commented out because fiscal period days passed as parameters
								-- / IsNull(NullIf(IRFiscWrkDays.NbrWrkDays,0),22)
								/ @NbrDaysInPeriod
							)
						,0
					),
		@WeightSum = Sum(IRDemDetail.Weight)
	From
		IRDemDetail
		Inner Join IRWrkPeriod On
						IRWrkPeriod.CurrentPeriod = @CurrentPeriod
						And IRWrkPeriod.Number = IRDemDetail.PriorPeriodNbr
		Left Outer Join IRItemUsage On
								IRItemUsage.Period = IRWrkPeriod.Period
								And IRItemUsage.InvtID = @InvtID
								And IRItemUsage.SiteID = @SiteID
	-- 	VM, 09/12/01, The following commented out because fiscal period days passed as parameters
	--	Left Outer Join IRFiscWrkDays On
	--							IRFiscWrkDays.Period = @CurrentPeriod
		Left Outer Join IRItemUsage Replacement On
								Replacement.Period = IRWrkPeriod.Period
								And Replacement.InvtId = @ReplacementPart
								And Replacement.SiteID = @SiteID
	Where
		IRDemDetail.DemandID = @DemandFormID
		And IRDemDetail.Weight <> 0.0

	If IsNull(@WeightSum,0) > 0
		Set @ReturnUsagePerDay = (IsNull(@WeightedSum,0)/ @WeightSum)
	Else
		Set @ReturnUsagePerDay = 0

	-- VM, 09/12/01, Multiply by the trend factor
	-- Get Trend Factor from ItemSIte table
	If @S4Future03 Is Null
	Select @TrendPct = IsNull(S4Future03,0) from ItemSite Where InvtID = @InvtID AND SiteID = @SiteID
	Else
	Select @TrendPct = @S4Future03

	if @TrendPct = 0 	-- Get from demand formula
		SELECT @TrendPct = ISNull(Trend,0) FROM IRDemHeader WHERE DemandID = @DemandFormID

	SET @ReturnUsagePerDay = @ReturnUsagePerDay + (@ReturnUsagePerDay * @TrendPct / 100)

	-- VM, 9/12/01, The following commented out because Fiscal days passed as parameter
	-- @ReturnUsagePerDay now should have the average DAILY usage.  So Find the Number of days in the next period
	-- Set @ReturnNbrDaysInPeriod = 22
	-- Select
	-- 	@ReturnNbrDaysInPeriod = IsNull(NbrWrkDays,22)
	-- From
	-- 	IRFiscWrkDays
	-- Where
	--	Period = @CurrentPeriod
	-- Multiply the result by the number of days in the period to forecast for
	-- Set @ReturnUsagePerPeriod = @ReturnUsagePerDay * IsNull(@ReturnNbrDaysInPeriod,22)
	Set @ReturnUsagePerPeriod = @ReturnUsagePerDay * @NbrDaysInPeriod
End
Else
Begin
	-- No entries in Demand formula, so need to just go for last month
	-- Don't need to worry about weight at all in this case
	Set @ReturnUsagePerDay = 0

	-- VM, 9/13/01, The following entire block commented out, because need to calculate forecast based upon the parameters in the IRSetup
	/*
	If Exists 	(
				Select
					*
				From
					IRItemUsage
				Where
			 		IRItemUsage.InvtID = @InvtID
					And IRItemUsage.SiteID = @SiteID
					And IRItemUsage.Period = @CurrentPeriod
			)
	Begin
		-- Record exists in primary table, use that
		Select
			@ReturnUsagePerDay = Sum	(
						(
							IsNull(IRItemUsage.DemActual,0)
							+ IsNull(IRItemUsage.DemActAdjust,0)
							+ IsNull(IRItemUsage.DemOverride,0)
						)
						-- VM, 09/12/01, following commented out because fiscal period days passed as parameter
						-- / IsNull(NullIf(IRFiscWrkDays.NbrWrkDays,0),22)
						/ @NbrDaysInPeriod
					)
		From
			IRItemUsage
			-- VM, 09/12/01, following commented out because fiscal period days passed as parameter
			-- Left Outer Join IRFiscWrkDays On IRFiscWrkDays.Period = @CurrentPeriod
		Where
			IRItemUsage.InvtID = @InvtID
			And IRItemUsage.SiteID = @SiteID
			And IRItemUsage.Period = @CurrentPeriod
	End
	Else
	Begin
		-- Try the Replacement Part
		Select
			@ReturnUsagePerDay = Sum	(
						(
							IsNull(IRItemUsage.DemActual,0)
							+ IsNull(IRItemUsage.DemActAdjust,0)
							+ IsNull(IRItemUsage.DemOverride,0)
						)
						-- VM, 09/12/01, following commented out because fiscal period days passed as parameter
						-- / IsNull(NullIf(IRFiscWrkDays.NbrWrkDays,0),22)
						/ @NbrDaysInPeriod
					)
		From
			IRItemUsage
			-- VM, 09/12/01, following commented out because fiscal period days passed as parameter
			-- Left Outer Join IRFiscWrkDays On IRFiscWrkDays.Period = @CurrentPeriod
		Where
			IRItemUsage.InvtID = @ReplacementPart
			And IRItemUsage.SiteID = @SiteID
			And IRItemUsage.Period = @CurrentPeriod

	End
	*/

	-- @ReturnUsagePerDay now should have the average DAILY usage.  So Find the Number of days in the next period
	-- VM, 9/12/01, The following commented out because Fiscal days passed as parameter
	-- Set @ReturnNbrDaysInPeriod = 22

	-- Select
	--	@ReturnNbrDaysInPeriod = IsNull(NbrWrkDays,22)
	-- From
	--	IRFiscWrkDays
	-- Where
	--	Period = @CurrentPeriod
	-- Multiply the result by the number of days in the period to forecast for
	-- Set @ReturnUsagePerPeriod = @ReturnUsagePerDay * IsNull(@ReturnNbrDaysInPeriod,22)

	-- VM, 9/13/01, Following code added to calculate the forecast when demand formula does not exist

	SELECT @NbrPeriod = ISNull(DemPeriodNbr,6) FROM IRSetup
	SELECT @RecordsIRWrkPeriod = Count(*) FROM IRWrkPeriod

	SELECT @PeriodToTal = SUM (
					Coalesce(
							NullIf 	(
									(
										  IsNull(IRItemUsage.DemActual,0.0)
										+ IsNull(IRItemUsage.DemActAdjust,0)
										+ IsNull(IRItemUsage.DemOverride,0)
									)
										,0.0
								),
							NullIf	(
									(
										  IsNull(Replacement.DemActual,0.0)
									        + IsNull(Replacement.DemActAdjust,0)
										+ IsNull(Replacement.DemOverride,0)
									)
										,0.0
								),
							0.0
						)
				   )
				FROM IRWrkPeriod
				Left Outer Join IRItemUsage On
						IRWrkPeriod.Period = IRItemUsage.Period
						And IRItemUsage.InvtID = @InvtID
						And IRItemUsage.SiteID = @SiteID
				Left Outer Join IRItemUsage Replacement On
						Replacement.Period = IRWrkPeriod.Period
						And Replacement.InvtId = @ReplacementPart
						And Replacement.SiteID = @SiteID
				WHERE   IRWrkPeriod.CurrentPeriod = @CurrentPeriod
					AND IRWrkPeriod.Number <= @NbrPeriod

	SET @PeriodTotal = ISNull(@PeriodTotal, 0.0)

	IF @NbrPeriod <= @RecordsIRWrkPeriod
		SET @NbrPerToUse = @NBrPeriod
	Else
		SET @NbrPerToUse = @RecordsIRWrkPeriod

	IF @NbrPerToUse = 0
		SET @ReturnUsagePerPeriod = 0
	ELSE
		SET @ReturnUsagePerPeriod = @PeriodTotal/@NbrPerToUSe

	-- Though Demand Formula is not there, trend may still be there in the ItemSite table
	If @S4Future03 Is Null
	Select @TrendPct = IsNull(S4Future03,0) from ItemSite Where InvtID = @InvtID AND SiteID = @SiteID
	else
	Select @TrendPct = @S4Future03

	SET @ReturnUsagePerPeriod = @ReturnUsagePerPeriod + (@ReturnUsagePerPeriod * @TrendPct / 100)

	Set @ReturnUsagePerDay = @ReturnUsagePerPeriod / @NbrDaysInPeriod

End
-- Fix any null issues
Select
	@ReturnUsagePerDay = IsNull(@ReturnUsagePerDay,-0),
	-- VM, 9/12/01, The following commented out because Fiscal days passed as parameter
	-- @ReturnNbrDaysInPeriod = IsNull(@ReturnNbrDaysInPeriod,-0),
	@ReturnUsagePerPeriod = IsNull(@ReturnUsagePerPeriod,0)
Set Nocount Off


