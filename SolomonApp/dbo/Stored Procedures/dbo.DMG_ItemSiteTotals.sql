 CREATE PROCEDURE DMG_ItemSiteTotals
	@parm1 varchar(30)
AS
	Declare	@BMIPerBegAmt	float
	Declare @BMIPtdCOGS	float
	Declare @BMIPtdCostIssd float
	Declare @BMIPYCOGS	float
	Declare @BMIPYCostIssd	float
	Declare @BMIYtdCOGS	float
	Declare @BMIYtdCostIssd float
	Declare @Crtd_DateTime	smalldatetime
	Declare @Crtd_Prog	varchar(8)
	Declare @Crtd_User	varchar(10)
	Declare @LUpd_DateTime	smalldatetime
	Declare @LUpd_Prog	varchar(8)
	Declare @LUpd_User	varchar(10)
	Declare @PerBegAmt	float
	Declare @PerBegQty	float
	Declare @PtdCOGS	float
	Declare @PtdCostIssd	float
	Declare @PtdQty		float
	Declare @PtdQtyIssd	float
	Declare @PtdSls		float
	Declare @PYCOGS		float
	Declare @PYCostIssd	float
	Declare @PYQty		float
	Declare @PYQtyIssd	float
	Declare @PYSls		float
	Declare @S4Future01	varchar(30)
	Declare @S4Future02	varchar(30)
	Declare @S4Future07	smalldatetime
	Declare @S4Future08	smalldatetime
	Declare @S4Future11	varchar(10)
	Declare @S4Future12	varchar(10)
	Declare @SiteID		varchar(10)
	Declare @User1		varchar(30)
	Declare @User2		varchar(30)
	Declare @User5		varchar(10)
	Declare @User6		varchar(10)
	Declare @User7		smalldatetime
	Declare @User8		smalldatetime
	Declare @YtdCOGS	float
	Declare @YtdCostIssd	float
	Declare @YtdQty		float
	Declare @YtdQtyIssd	float
	Declare @YtdSls		float

	-- Changes - this accumulation gets posted to TempInvtTot
	-- Sum ItemSite.QtyAlloc             for TempInvtTot.AllocQty
   	-- Sum ItemSite.QtyOnKitAssyOrders   for TempInvtTot.S4Future03
   	-- Sum ItemSite.QtyOnTransferOrders  for TempInvtTot.S4Future04
   	-- Sum ItemSite.QtyWOFirmSupply      for TempInvtTot.S4Future05
   	-- Sum ItemSite.QtyWORlsedSupply     for TempInvtTot.S4Future06
   	-- Sum ItemSite.QtyWOFirmDemand      for TempInvtTot.User3
   	-- Sum ItemSite.QtyWORlsedDemand     for TempInvtTot.User4
	SELECT 	Sum(QtyAlloc), Sum(AvgCost), Sum(BMIAvgCost), @BMIPerBegAmt,
		@BMIPtdCOGS, @BMIPtdCostIssd, @BMIPYCOGS, @BMIPYCostIssd,
		Sum(BMITotCost), @BMIYtdCOGS, @BMIYtdCostIssd, @Crtd_DateTime, @Crtd_Prog, @Crtd_User,
		InvtID, @LUpd_DateTime, @LUpd_Prog, @LUpd_User, @PerBegAmt, @PerBegQty, @PtdCOGS, @PtdCostIssd,
		@PtdQty, @PtdQtyIssd, @PtdSls, @PYCOGS, @PYCostIssd, @PYQty,
		@PYQtyIssd, @PYSls, Sum(QtyAllocBM), Sum(QtyAllocIN), Sum(QtyAllocOther), Sum(QtyAllocPORet),
		Sum(QtyAllocProjIN), Sum(QtyAllocSD), Sum(QtyAllocSO), Sum(QtyAvail), Sum(QtyCustOrd), 
		Sum(QtyInTransit), Sum(QtyNotAvail), Sum(QtyOnBO), Sum(QtyOnDP), Sum(QtyOnHand), Sum(QtyOnPO),
		Sum(QtyShipNotInv), @S4Future01, @S4Future02, Sum(QtyOnKitAssyOrders),
		Sum(QtyOnTransferOrders), Sum(QtyWOFirmSupply),
		Sum(QtyWORlsedSupply), @S4Future07, @S4Future08, Sum(S4Future09), Sum(S4Future10),
		@S4Future11, @S4Future12, @SiteID, Sum(TotCost),
		@User1, @User2, Sum(QtyWOFirmDemand), Sum(QtyWORlsedDemand),
		@User5, @User6, @User7, @User8,
		@YtdCOGS, @YtdCostIssd, @YtdQty, @YtdQtyIssd, @YtdSls
	FROM 	ItemSite
	WHERE 	InvtID = @parm1
	Group By InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemSiteTotals] TO [MSDSL]
    AS [dbo];

