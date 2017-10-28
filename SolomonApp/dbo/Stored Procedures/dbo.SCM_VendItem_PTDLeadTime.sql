 create proc SCM_VendItem_PTDLeadTime
	@InvtID			varchar(30),
	@SiteID			varchar(10),
	@VendID			varchar(15),
	@AlternateID		varchar(30),
	@BeginPeriod 		varchar(6),
	@EndPeriod 		varchar(6)
	as

	Declare @StartYear  		varchar(4)
	Declare @EndYear    		varchar(4)
	Declare @NbrPer			smallint
	Declare @PerStr			varchar(2)
	Declare @NumTemp		smallint

	-- Create the VendItemTemp table.
	Create Table #VendItemTemp
		(Period 		char( 6 ),
		PTDLeadTime 		float
		)
		-- Get the Start and End year for selection.
	select @StartYear = Left(@BeginPeriod, 4)
	select @EndYear = Left(@EndPeriod, 4)

	select @NbrPer = NbrPer from GLSetup

	-- Iterate through each period up until GLSetup.NbrPer and
	-- get each value for the Qty Sold from VendItem.
	Select @NumTemp = 1
	While @NumTemp >= 1 and @NumTemp <= @NbrPer
	Begin
			If @NumTemp < 10
			select @PerStr = '0' + convert(varchar(2), @NumTemp)
		Else
			select @PerStr = convert(varchar(2), @NumTemp)
			Insert 	Into #VendItemTemp
		Select 	FiscYr + @PerStr Period,
			Case @NumTemp
				When 1 Then PTDLeadTime00
				When 2 Then PTDLeadTime01
				When 3 Then PTDLeadTime02
				When 4 Then PTDLeadTime03
				When 5 Then PTDLeadTime04
				When 6 Then PTDLeadTime05
				When 7 Then PTDLeadTime06
				When 8 Then PTDLeadTime07
				When 9 Then PTDLeadTime08
				When 10 Then PTDLeadTime09
				When 11 Then PTDLeadTime10
				When 12 Then PTDLeadTime11
				When 13 Then PTDLeadTime12
			end
		From 	VendItem
		Where 	InvtID = @InvtID
		  and	SiteID = @SiteID
		  and	VendID = @VendID
		  and	AlternateID = @AlternateID
		  and	FiscYr between @StartYear and @EndYear

		select @NumTemp = @NumTemp + 1
	end

	select Sum(PTDLeadTime) from #VendItemTemp where Period between @BeginPeriod and @EndPeriod



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_VendItem_PTDLeadTime] TO [MSDSL]
    AS [dbo];

