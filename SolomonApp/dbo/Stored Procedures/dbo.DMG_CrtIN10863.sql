 create proc DMG_CrtIN10863
	@RI_ID 			smallint,
	@BeginPeriod 		varchar(6),
	@EndPeriod 		varchar(6),
	@WhereStr		VARCHAR(1024)
as

	Declare @StartYear  		varchar(4)
	Declare @EndYear    		varchar(4)
	Declare @NbrPer			smallint
	Declare @PerStr			varchar(2)
	Declare @NumTemp		smallint
	Declare @SelectStr1		varchar(2000)
	Declare @FromStr1		varchar(2000)

    Set NoCount On
	
	Create Table #ABCTemp
		(RI_ID		smallint,
		ABCCode		char( 2 ),
		ABCDescr	char( 30 ),
		CpnyID 		char( 10 ),
		InvtID 		char( 30 ),
		SiteID 		char( 10 ),
		TotalSold 	float
		)

	select 	@NbrPer = NbrPer from GLSetup

	-------------------------------------------------------------
	-- Get the Qty Sold for each period from the Item2Hist table.
	-------------------------------------------------------------
		-- Get the Start and End year for selection.
	select @StartYear = Left(@BeginPeriod, 4)
	select @EndYear = Left(@EndPeriod, 4)
		-- Create the ItemHistTemp table.
	Create Table #ItemHistTemp
		(InvtID 	char( 30 ),
		SiteID 		char( 10 ),
		FiscYr 		char( 4 ),
		Period 		char( 6 ),
		PtdCostRcvd 	float
		)
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
				When 1 Then PtdCostRcvd00
				When 2 Then PtdCostRcvd01
				When 3 Then PtdCostRcvd02
				When 4 Then PtdCostRcvd03
				When 5 Then PtdCostRcvd04
				When 6 Then PtdCostRcvd05
				When 7 Then PtdCostRcvd06
				When 8 Then PtdCostRcvd07
				When 9 Then PtdCostRcvd08
				When 10 Then PtdCostRcvd09
				When 11 Then PtdCostRcvd10
				When 12 Then PtdCostRcvd11
				When 13 Then PtdCostRcvd12
			end
		From 	ItemHist
		Where 	FiscYr between @StartYear and @EndYear
			select @NumTemp = @NumTemp + 1
	end

		----------------------------------------------------------------
	-- Insert records into the IN10863_WRK table
	----------------------------------------------------------------
 	Select @SelectStr1 =
	'Insert into #ABCTemp (RI_ID, ABCCode, ABCDescr, CpnyID, InvtID,
		SiteID, TotalSold)
	Select	' + Convert(varchar(10), @ri_id) + ', ItemSite.ABCCode, IsNull(PIABC.Descr, ''''), ItemSite.CpnyID, ItemSite.InvtID,
		ItemSite.SiteID,
		TotalSold = IsNull((Select Sum(#ItemHistTemp.PtdCostRcvd)
				 From	#ItemHistTemp
				 Where 	#ItemHistTemp.InvtID = ItemSite.InvtID
				 and 	#ItemHistTemp.SiteID = ItemSite.SiteID
				 and 	#ItemHistTemp.Period >= ' + @BeginPeriod + '
				 and 	#ItemHistTemp.Period <= ' + @EndPeriod + '), 0) '
	Select @FromStr1 =
	'from 	ItemSite
		left join
			PIABC ON PIABC.ABCCode = Left(ItemSite.ABCCode, 1) '

	if @WhereStr <> '' and @WhereStr is not NULL
	begin
		select @FromStr1 = @FromStr1 +
	  	'left join
			Inventory ON ItemSite.InvtID = Inventory.InvtId
		left join
			Site ON ItemSite.SiteID = Site.SiteID
		left join
			IN10863_WRK ON IN10863_WRK.InvtID = ItemSite.InvtID and IN10863_WRK.SiteID = ItemSite.SiteID
		left join
			RptCompany ON RptCompany.CpnyID = ItemSite.CpnyID '

		select @WhereStr = 'Where ' + @WhereStr

	end

	exec (@SelectStr1 + @FromStr1 + @WhereStr + ' ORDER BY ItemSite.InvtID, ItemSite.SiteID ')

	----------------------------------------------------------------
	-- Update the ABC class for each item.
	----------------------------------------------------------------
	Declare @TempTotal 		float
	Declare @ClassTotal		float
	Declare @ClassFlag		bit
	Declare @InvtID 		char( 30 )
	Declare @SiteID 		char( 10 )
	Declare @TotalSold 		float
	Declare @PrevTotalSold		float

	Declare ABCTempCsr 		Cursor for select InvtID, SiteID, TotalSold from #ABCTemp order by TotalSold DESC, InvtID, SiteID
		Open ABCTempCsr

	-- Get the 'A' class.
	Select @ClassTotal = IsNull(Sum(TotalSold) * (Select ClassPct * .01 from PIABC where ABCCode = 'A'), 0) from #ABCTemp

	Select @TempTotal = IsNull(Sum(TotalSold), 0) From #ABCTemp where ABCCode = 'AF'
		select @ClassFlag = 0

	fetch next from ABCTempCsr into @InvtID, @SiteID, @TotalSold
	While (@@fetch_status = 0 and @ClassFlag = 0)
	begin
		-- Sum up the total sold so far so we can compare it to the overall total for the class.
		Select @TempTotal = @TotalSold + @TempTotal

		Update #ABCTemp Set ABCCode = 'A' where InvtID = @InvtID and SiteID = @SiteID and ABCCode Not in ('AF', 'BF', 'CF')

		-- Save the TotalSold to the PrevTotalSold so we can compare it to the previous total sold.  If
		-- the current total sold equals the previous total sold, then both items should have the same ABC Code.
		select @PrevTotalSold = @TotalSold

		fetch next from ABCTempCsr into @InvtID, @SiteID, @TotalSold

		if (@TempTotal > @ClassTotal and @PrevTotalSold <> @TotalSold) or @TotalSold = 0
			Select @ClassFlag = 1

	end


	-- Get the 'B' class.
	Select @ClassTotal = IsNull(Sum(TotalSold) * (Select ClassPct * .01 from PIABC where ABCCode = 'B'), 0) from #ABCTemp

	Select @TempTotal = IsNull(Sum(TotalSold), 0) From #ABCTemp where ABCCode = 'BF'

	select @ClassFlag = 0

	While (@@fetch_status = 0 and @ClassFlag = 0)
	begin
		-- Sum up the total sold so far so we can compare it to the overall total for the class.
		Select @TempTotal = @TotalSold + @TempTotal

		Update #ABCTemp Set ABCCode = 'B' where InvtID = @InvtID and SiteID = @SiteID and ABCCode Not in ('AF', 'BF', 'CF')

		-- Save the TotalSold to the PrevTotalSold so we can compare it to the previous total sold.  If
		-- the current total sold equals the previous total sold, then both items should have the same ABC Code.
		select @PrevTotalSold = @TotalSold

		fetch next from ABCTempCsr into @InvtID, @SiteID, @TotalSold

		if (@TempTotal > @ClassTotal and @PrevTotalSold <> @TotalSold) or @TotalSold = 0
			Select @ClassFlag = 1
	end

	-- Get the 'C' class.
	Select @ClassTotal = IsNull(Sum(TotalSold) * (Select ClassPct * .01 from PIABC where ABCCode = 'C'), 0) from #ABCTemp

	Select @TempTotal = IsNull(Sum(TotalSold), 0) From #ABCTemp where ABCCode = 'CF'

	select @ClassFlag = 0

	While (@@fetch_status = 0 and @ClassFlag = 0)
	begin
		-- Sum up the total sold so far so we can compare it to the overall total for the class.
		Select @TempTotal = @TotalSold + @TempTotal

		Update #ABCTemp Set ABCCode = 'C' where InvtID = @InvtID and SiteID = @SiteID and ABCCode Not in ('AF', 'BF', 'CF')

		if @TempTotal > @ClassTotal
			Select @ClassFlag = 1

		fetch next from ABCTempCsr into @InvtID, @SiteID, @TotalSold
	end

	close ABCTempCsr
	deallocate ABCTempCsr
		Insert into IN10863_WRK (RI_ID, ABCCode, CpnyID, InvtID,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		SiteID, TotalSold,
		User1, User2, User3, User4, User5, User6, User7, User8)
	Select	@RI_ID, ABCCode, CpnyID, InvtID,
		ABCDescr, s4future02 = '', s4future03 = 0, s4future04 = 0, s4future05 = 0, s4future06 = 0,
		s4future07 = '', s4future08 = '', s4future09 = 0, s4future10 = 0, s4future11 = '', s4future12 = '',
		SiteID, TotalSold,
		User1 = '', User2 = '', User3 = 0, User4 = 0, User5 = '', User6 = '', User7 = '', User8 = ''
	from	#ABCTemp

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CrtIN10863] TO [MSDSL]
    AS [dbo];

