 create proc DMG_CrtPO04740
	@RI_ID 			smallint,
	@BeginPeriod 		varchar(6),
	@EndPeriod 		varchar(6),
	@NumberOfDays 		float,
	@TimeWindow		float

as

	Declare @AdminLeadTime 		smallint
	Declare @SetupCost		float
	Declare @InvtCarryingCost	float
	Declare @StartYear  		varchar(4)
	Declare @EndYear    		varchar(4)
	Declare @NbrPer			smallint
	Declare @PerStr			varchar(2)
	Declare @NumTemp		smallint
		-- Retrieve data from the Setup tables.
	select 	@AdminLeadTime = AdminLeadTime,
		@SetupCost = SetupCost,
		@InvtCarryingCost = InvtCarryingCost
	from 	POSetup
		select 	@NbrPer = NbrPer from GLSetup
		-------------------------------------------------------------
	-- Create the initial temp table for the report.
	-------------------------------------------------------------
	select 	ItemSite.PrimVendID,
		IsNull(Vendor.Name, '') PrimVendName,
		ItemSite.InvtID,
		IsNull(Inventory.Descr, '') InvtDescr,
		ItemSite.SiteID,
		LeadTime = ItemSite.LeadTime + @AdminLeadTime + @TimeWindow,
		QtyAvailAtLeadTime = IsNull (
			(select Sum(SOPlan.Qty)
			from 	soplan
			where 	SOPlan.InvtID = ItemSite.InvtID and SOPlan.SiteID = ItemSite.SiteID
			  and 	SOPlan.PlanDate < (GetDate() + ItemSite.LeadTime + @AdminLeadTime)
			  and 	SOPlan.PlanType Not In ('68', '70', '75')), 0),
		DailyAvgDemand = Convert(Float, 0),
		AdditionalDemand = Convert(Float, 0),
		ItemSite.SafetyStk,
		ReorderPoint = Convert(Float, 0),
		QtyShort = Convert(Float, 0),
		OrderQty = Convert(Float, 0),
		UnitCost = Case When ItemSite.LastCost = 0 and Inventory.ValMthd = 'S' Then Inventory.StdCost Else ItemSite.LastCost End,
		OrderQtyValue = Convert(Float, 0),
		SuggestedOrderQty = Convert(Float, 0),
		SuggestedOrderValue = Convert(Float, 0),
		MaxOnHand = IsNull(Inventory.MaxOnHand, 0),
		ItemSite.CpnyID,
		ItemSite.Crtd_DateTime,
		ItemSite.Crtd_Prog,
		ItemSite.Crtd_User,
		ItemSite.LUpd_DateTime,
		ItemSite.LUpd_Prog,
		ItemSite.LUpd_User,
		ItemSite.NoteID,
		ItemSite.ReplMthd,
		ItemSite.ReordInterval,
		ItemSite.ReordQty,
		RI_ID = @RI_ID
	into 	#PO04740_Temp
	from	ItemSite
		left join
			Vendor ON Vendor.VendID = ItemSite.PrimVendID
		left join
			Inventory ON Inventory.InvtID = ItemSite.InvtID


	-------------------------------------------------------------
	-- Get the Qty Sold for each period from the Item2Hist table.
	-------------------------------------------------------------
		-- Get the Start and End year for selection.
	select @StartYear = Left(@BeginPeriod, 4)
	select @EndYear = Left(@EndPeriod, 4)
		-- Create the Item2HistTemp table.
	Create Table #Item2HistTemp
		(InvtID char( 30 ),
		SiteID char( 10 ),
		FiscYr char( 4 ),
		Period char( 6 ),
		PtdQtySls float
		)
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
				When 1 Then PtdQtySls00
				When 2 Then PtdQtySls01
				When 3 Then PtdQtySls02
				When 4 Then PtdQtySls03
				When 5 Then PtdQtySls04
				When 6 Then PtdQtySls05
				When 7 Then PtdQtySls06
				When 8 Then PtdQtySls07
				When 9 Then PtdQtySls08
				When 10 Then PtdQtySls09
				When 11 Then PtdQtySls10
				When 12 Then PtdQtySls11
				When 13 Then PtdQtySls12
			end
		From 	Item2Hist
		Where 	FiscYr between @StartYear and @EndYear
			select @NumTemp = @NumTemp + 1
	end
		----------------------------------------------------------------
	-- Update the rest of the fields in the PO04740_Temp table
	----------------------------------------------------------------
		-- Update the PO04740_Temp table with the Daily Average Demand.
	-- This is calculated as the (Total Qty Sold) / (Number of Days).
	Update	#PO04740_Temp
	Set	DailyAvgDemand = IsNull((Select (Sum(#Item2HistTemp.PtdQtySls) / @NumberOfDays)
				 From	#Item2HistTemp
				 Where 	#Item2HistTemp.InvtID = #PO04740_Temp.InvtID
				 and 	#Item2HistTemp.SiteID = #PO04740_Temp.SiteID
				 and 	#Item2HistTemp.Period >= @BeginPeriod
				 and 	#Item2HistTemp.Period <= @EndPeriod
				 Group By #Item2HistTemp.InvtID, #Item2HistTemp.SiteID), 0)
		Update	#PO04740_Temp
	Set	AdditionalDemand = LeadTime * DailyAvgDemand,

		-- ReorderPoint = Additional Demand + SafetyStk
		ReorderPoint = (LeadTime * DailyAvgDemand) + SafetyStk,
			-- QtyShort = ReorderPoint - QtyAvailAtLeadTime
		QtyShort = ((LeadTime * DailyAvgDemand) + SafetyStk) - QtyAvailAtLeadTime


	-- Update the Order Qty based on the Replenishment Method
	-- Optional Replenishment
	UPDATE	#PO04740_Temp
		-- OrderQty (EOQ) = ((2 * AnnualUsageInUnits * SetupCost) / (UnitCost * InvtCarryingCost)) ^ 5
	SET	OrderQty = Case When (UnitCost * @InvtCarryingCost) = 0 Then 0 Else SQUARE((2 * (DailyAvgDemand * 365) * @SetupCost) / (UnitCost * @InvtCarryingCost)) End
	WHERE	ReplMthd = 'O'

	-- Fixed Order Cycle
	UPDATE	#PO04740_Temp
	SET	OrderQty = (LeadTime + ReordInterval) * DailyAvgDemand
	WHERE	ReplMthd = 'C'

	-- Fixed Order Qty
	UPDATE	#PO04740_Temp
	SET	OrderQty = ReordQty
	WHERE	ReplMthd = 'Q'

	-- Update the Order Qty Value
	UPDATE	#PO04740_Temp
	SET	OrderQtyValue = OrderQty  * UnitCost
		-- Update Suggested values in PO04740_Temp
	Update	#PO04740_Temp
	Set	SuggestedOrderQty = Case When OrderQty > MaxOnHand Then OrderQty Else MaxOnHand End

	Update	#PO04740_Temp
	Set	SuggestedOrderValue = IsNull(SuggestedOrderQty * UnitCost, 0)

	----------------------------------------------------------------
	-- Insert records into the PO04740_WRK table
	----------------------------------------------------------------
	Insert into PO04740_WRK (RI_ID, AdditionalDemand, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
		DailyAvgDemand, InvtDescr, InvtID, LeadTime, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,
		OrderQty, OrderQtyValue, PrimVendID, PrimVendName, QtyAvailAtLeadTime, QtyShort, ReorderPoint,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		SafetyStk, SiteID, SuggestedOrderQty, SuggestedOrderValue, UnitCost,
		User1, User2, User3, User4, User5, User6, User7, User8)
	Select	RI_ID, AdditionalDemand, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
		DailyAvgDemand, InvtDescr, InvtID, LeadTime, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,
		OrderQty, OrderQtyValue, PrimVendID, PrimVendName, QtyAvailAtLeadTime, QtyShort, ReorderPoint,
		s4future01 = '', s4future02 = '', s4future03 = 0, s4future04 = 0, s4future05 = 0, s4future06 = 0,
		s4future07 = '', s4future08 = '', s4future09 = 0, s4future10 = 0, s4future11 = '', s4future12 = '',
		SafetyStk, SiteID, SuggestedOrderQty, SuggestedOrderValue, UnitCost,
		User1 = '', User2 = '', User3 = 0, User4 = 0, User5 = '', User6 = '', User7 = '', User8 = ''
	from 	#PO04740_Temp
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CrtPO04740] TO [MSDSL]
    AS [dbo];

