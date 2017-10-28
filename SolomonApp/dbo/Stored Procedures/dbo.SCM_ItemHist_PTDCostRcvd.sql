 create proc SCM_ItemHist_PTDCostRcvd
	@InvtID			varchar(30),
	@SiteID			varchar(10),
	@BeginPeriod 		varchar(6),
	@EndPeriod 		varchar(6)
	as

	Declare @StartYear  		varchar(4)
	Declare @EndYear    		varchar(4)
	Declare @NbrPer			smallint
	Declare @PerStr			varchar(2)
	Declare @NumTemp		smallint

	-- Create the ItemHistTemp table.
	Create Table #ItemHistTemp
		(InvtID 	char( 30 ),
		SiteID 		char( 10 ),
		FiscYr 		char( 4 ),
		Period 		char( 6 ),
		PTDCostRcvd 	float
		)
		-- Get the Start and End year for selection.
	select @StartYear = Left(@BeginPeriod, 4)
	select @EndYear = Left(@EndPeriod, 4)

	select @NbrPer = NbrPer from GLSetup

	-- Iterate through each period up until GLSetup.NbrPer and
	-- get each value for the Qty Sold from ItemHist.
	Select @NumTemp = 1
	While @NumTemp >= 1 and @NumTemp <= @NbrPer
	Begin
			If @NumTemp < 10
			select @PerStr = '0' + convert(varchar(2), @NumTemp)
		Else
			select @PerStr = convert(varchar(2), @NumTemp)
			Insert 	Into #ItemHistTemp
		Select 	InvtID, SiteID, FiscYr, FiscYr + @PerStr Period,
			Case @NumTemp
				When 1 Then PTDCostRcvd00
				When 2 Then PTDCostRcvd01
				When 3 Then PTDCostRcvd02
				When 4 Then PTDCostRcvd03
				When 5 Then PTDCostRcvd04
				When 6 Then PTDCostRcvd05
				When 7 Then PTDCostRcvd06
				When 8 Then PTDCostRcvd07
				When 9 Then PTDCostRcvd08
				When 10 Then PTDCostRcvd09
				When 11 Then PTDCostRcvd10
				When 12 Then PTDCostRcvd11
				When 13 Then PTDCostRcvd12
			end
		From 	ItemHist
		Where 	InvtID = @InvtID
		  and	SiteID = @SiteID
		  and	FiscYr between @StartYear and @EndYear

		select @NumTemp = @NumTemp + 1
	end

	select Sum(PTDCostRcvd) from #ItemHistTemp where Period between @BeginPeriod and @EndPeriod


