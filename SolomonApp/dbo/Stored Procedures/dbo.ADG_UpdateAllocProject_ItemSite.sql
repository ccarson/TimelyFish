
Create Proc ADG_UpdateAllocProject_ItemSite
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@CpnyID		Varchar(10),
	@ProgID		Varchar(8),
	@UserID		Varchar(10),
        @Qty            Float
	  
As

	
	insert	ItemSite
	(
		ABCCode, AllocQty, AvgCost, BMIAvgCost,
		BMIDirStdCst, BMIFovhStdCst, BMILastCost, BMIPDirStdCst,
		BMIPFOvhStdCst, BMIPStdCst, BMIPVOvhStdCst, BMIStdCost,
		BMITotCost, BMIVOvhStdCst, Buyer, COGSAcct,
		COGSSub, CountStatus, CpnyID, Crtd_DateTime,
		Crtd_Prog, Crtd_User, CycleID, DfltPOUnit,
		DfltSOUnit, DirStdCst, EOQ, FOvhStdCst,
		InvtAcct, InvtID, InvtSub, LastBookQty,
		LastCost, LastCountDate, LastPurchaseDate, LastPurchasePrice,
		LastStdCost, LastVarAmt, LastVarPct, LastVarQty,
		LastVendor, LeadTime, LUpd_DateTime, LUpd_Prog,
		LUpd_User, MaxOnHand, MfgLeadTime, MoveClass,
		NoteId, PDirStdCst, PFOvhStdCst, PrimVendID,
		ProdMgrID, PStdCostDate, PStdCst, PVOvhStdCst,
		QtyAlloc, QtyAvail, QtyCustOrd, QtyInTransit,
		QtyNotAvail, QtyOnBO, QtyOnDP, QtyOnHand,
		QtyOnKitAssyOrders, QtyOnPO, QtyOnTransferOrders, QtyShipNotInv,
		QtyWOFirmDemand, QtyWOFirmSupply, QtyWORlsedDemand, QtyWORlsedSupply,
		ReordInterval, ReordPt, ReordPtCalc, ReordQty,
		ReordQtyCalc, ReplMthd, S4Future01, S4Future02,
		S4Future03, S4Future04, S4Future05, S4Future06,
		S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12, SafetyStk, SafetyStkCalc,
		SalesAcct, SalesSub, SecondVendID, Selected,
		ShipNotInvAcct, ShipNotInvSub, SiteID, StdCost,
		StdCostDate, StkItem, TotCost, Turns,
		UsageRate, User1, User2, User3,
		User4, User5, User6, User7,
		User8, VOvhStdCst, YTDUsage
	)
	select
		ABCCode, 0, 0, 0,
		BMIDirStdCost, BMIFOvhStdCost, BMILastCost, BMIPDirStdCost,
		BMIPFOvhStdCost, BMIPStdCost, BMIPVOvhStdCost, BMIStdCost,
		0, BMIVOvhStdCost, '', COGSAcct,
		COGSSub, 'A', @CpnyID, getdate(),
		@ProgID, @UserID, CycleID, DfltPOUnit,
		DfltSOUnit, DirStdCost, 0, FOvhStdCost,
		InvtAcct, @InvtID, InvtSub, 0,
		0, '', '', 0,
		0, 0, 0, 0,
		'', 999, getdate(), @ProgID,
		@UserID, 0, 0, MoveClass,
		0, PDirStdCost, PFOvhStdCost, '',
		'', PStdCostDate,PStdCost, PVOvhStdCost,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, '', '', '',
		0, 0, 0, 0,
		'', '', 0, 0,
		'', '', 0, 0,
		DfltSalesAcct, DfltSalesSub, '', 0,
		DfltShpNotInvAcct, DfltShpNotInvSub, @SiteID, StdCost,
		StdCostDate, StkItem, 0, 0,
		UsageRate, '', '', 0,
		0, '', '', '',
		'', VOvhStdCost, 0
	from	Inventory (nolock)
	where	InvtID = @InvtID
	and	not exists (	select	InvtID, SiteID
				from	ItemSite
				where	InvtID = @InvtID
				and	SiteID = @SiteID)
if @@error != 0 return(@@error)

update ItemSite set
	QtyAllocIN = convert(dec(25,9),QtyAllocIN) + @qty,
	PrjINQtyAllocIN = convert(dec(25,9),PrjINQtyAllocIN) + @qty,
        LUpd_Prog = @ProgId,
	LUpd_User = @UserId,
	LUpd_DateTime = getdate()
where InvtID = @InvtID and SiteID = @SiteID
if @@error != 0 return(@@error)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_UpdateAllocProject_ItemSite] TO [MSDSL]
    AS [dbo];

