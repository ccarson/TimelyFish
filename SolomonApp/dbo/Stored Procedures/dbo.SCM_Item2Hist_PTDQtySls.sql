 create proc SCM_Item2Hist_PTDQtySls
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

	-- Create the Item2HistTemp table.
	Create Table #Item2HistTemp
		(InvtID 	char( 30 ),
		SiteID 		char( 10 ),
		FiscYr 		char( 4 ),
		Period 		char( 6 ),
		PTDQtySls 		float
		)
		-- Get the Start and End year for selection.
	select @StartYear = Left(@BeginPeriod, 4)
	select @EndYear = Left(@EndPeriod, 4)

	select @NbrPer = NbrPer from GLSetup

	-- Iterate through each period up until GLSetup.NbrPer and
	-- get each value for the Qty Sold from Item2Hist.
	Select @NumTemp = 1
	While @NumTemp >= 1 and @NumTemp <= @NbrPer
	Begin
			If @NumTemp < 10
			select @PerStr = '0' + convert(varchar(2), @NumTemp)
		Else
			select @PerStr = convert(varchar(2), @NumTemp)
			Insert 	Into #Item2HistTemp
		Select 	InvtID, SiteID, FiscYr, FiscYr + @PerStr Period,
			Case @NumTemp
				When 1 Then PTDQtySls00
				When 2 Then PTDQtySls01
				When 3 Then PTDQtySls02
				When 4 Then PTDQtySls03
				When 5 Then PTDQtySls04
				When 6 Then PTDQtySls05
				When 7 Then PTDQtySls06
				When 8 Then PTDQtySls07
				When 9 Then PTDQtySls08
				When 10 Then PTDQtySls09
				When 11 Then PTDQtySls10
				When 12 Then PTDQtySls11
				When 13 Then PTDQtySls12
			end
		From 	Item2Hist
		Where 	InvtID = @InvtID
		  and	SiteID = @SiteID
		  and	FiscYr between @StartYear and @EndYear

		select @NumTemp = @NumTemp + 1
	end

	select Sum(PTDQtySls) from #Item2HistTemp where Period between @BeginPeriod and @EndPeriod


