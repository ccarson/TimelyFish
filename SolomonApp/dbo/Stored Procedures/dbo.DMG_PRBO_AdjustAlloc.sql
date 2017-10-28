 Create Proc DMG_PRBO_AdjustAlloc
	@BatNbr		varchar(10),
	@ProgID		Varchar(8),
	@UserID		Varchar(10),
	@DrCr		smallint
As

declare
  @DecPlQty smallint

set nocount on

select
  @DecPlQty = DecPlQty
From INSetup (NoLock)
if @@error != 0 return(@@error)

if @DrCr = -1
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
		max(n.ABCCode), 0, 0, 0,
		max(n.BMIDirStdCost), max(n.BMIFOvhStdCost), max(n.BMILastCost), max(n.BMIPDirStdCost),
		max(n.BMIPFOvhStdCost), max(n.BMIPStdCost), max(n.BMIPVOvhStdCost), max(n.BMIStdCost),
		0, max(n.BMIVOvhStdCost), '', max(n.COGSAcct),
		max(n.COGSSub), 'A', max(POReceipt.CpnyID), getdate(),
		@ProgID, @UserID, max(n.CycleID), max(n.DfltPOUnit),
		max(n.DfltSOUnit), max(n.DirStdCost), 0, max(n.FOvhStdCost),
		max(n.InvtAcct), POTran.InvtID, max(n.InvtSub), 0,
		0, '', '', 0,
		0, 0, 0, 0,
		'', 999, getdate(), @ProgID,
		@UserID, 0, 0, max(n.MoveClass),
		0, max(n.PDirStdCost), max(n.PFOvhStdCost), '',
		'', max(n.PStdCostDate), max(n.PStdCost), max(n.PVOvhStdCost),
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, '', '', '',
		0, 0, 0, 0,
		'', '', 0, 0,
		'', '', 0, 0,
		max(n.DfltSalesAcct), max(n.DfltSalesSub), '', 0,
		max(n.DfltShpNotInvAcct), max(n.DfltShpNotInvSub), POTran.SiteID, max(n.StdCost),
		max(n.StdCostDate), max(n.StkItem), 0, 0,
		max(n.UsageRate), '', '', 0,
		0, '', '', '',
		'', max(n.VOvhStdCost), 0
	from	POTran
	inner 	join POReceipt on POReceipt.BatNbr = POTran.BatNbr AND POReceipt.RcptNbr = POTran.RcptNbr AND POReceipt.RcptType ='X'
	inner 	join Inventory n (nolock) on n.InvtID = POTran.InvtID AND n.StkItem = 1
	where	POTran.BatNbr = @BatNbr
	and not exists (	select	*
				from	ItemSite
				where	InvtID = POTran.InvtID
				and	SiteID = POTran.SiteID)
	group by POTran.InvtID, POTran.SiteID
if @@error != 0 return(@@error)

if @DrCr = -1
	insert	Location
	(
		CountStatus, Crtd_DateTime, Crtd_Prog, Crtd_User,
		InvtID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
		QtyAlloc, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
		S4Future01, S4Future02, S4Future03, S4Future04,
		S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		Selected, SiteID, User1, User2, User3, User4,
		User5, User6, User7, User8, WhseLoc
	)
	select
		'A', getdate(), @ProgID, @UserID,
		POTran.InvtID, getdate(), @ProgID, @UserID, 0,
		0, 0, 0, 0,
		'', '', 0, 0,
		0, 0, '', '',
		0, 0, '', '',
		0, POTran.SiteID, '', '', 0, 0,
		'', '', '', '', POTran.WhseLoc

	from	POTran
	inner 	join Inventory n (nolock) on n.InvtID = POTran.InvtID AND n.StkItem = 1
	inner 	join POReceipt on POReceipt.BatNbr = POTran.BatNbr AND POReceipt.RcptNbr = POTran.RcptNbr AND POReceipt.RcptType ='X'
	where	POTran.BatNbr = @BatNbr
	and	not exists (	select	*
				from	Location
				where	InvtID = POTran.InvtID
				and	SiteID = POTran.SiteID
				and	WhseLoc = POTran.WhseLoc)
	group by POTran.InvtID, POTran.SiteID, POTran.WhseLoc
if @@error != 0 return(@@error)

if @DrCr = -1
		insert	LotSerMst
		(
			Cost, Crtd_DateTime, Crtd_Prog, Crtd_User,
			ExpDate, InvtID, LIFODate, LotSerNbr,
			LUpd_DateTime, LUpd_Prog, LUpd_User,
			MfgrLotSerNbr, NoteID, OrigQty, QtyAlloc,
			QtyOnHand, QtyShipNotInv, QtyWORlsedDemand, RcptDate,
			S4Future01, S4Future02, S4Future03, S4Future04,
			S4Future05, S4Future06, S4Future07, S4Future08,
			S4Future09, S4Future10, S4Future11, S4Future12,
			ShipContCode, SiteID, Source, SrcOrdNbr, Status, StatusDate,
			User1, User2, User3, User4,
			User5, User6, User7, User8,
			WarrantyDate, WhseLoc
		)
		select distinct
			0, getdate(), @ProgID, @UserID,
			'', LotSerT.InvtID, '', LotSerT.LotSerNbr,
			getdate(), @ProgID, @UserID,
			'', 0, 0, 0,
			0, 0, 0, '',
			'', '', 0, 0,
			0, 0, '', '',
			0, 0, '', '',
			'', LotSerT.SiteID, 'PO', '', 'H', '',
			'', '', 0, 0,
			'', '', '', '',
			'', LotSerT.WhseLoc

	from	LotSerT
	inner 	join Inventory n (nolock) on n.InvtID = LotSerT.InvtID AND n.StkItem = 1
	inner 	join POReceipt on POReceipt.BatNbr = LotSerT.BatNbr AND POReceipt.RcptNbr = LotSerT.RefNbr AND POReceipt.RcptType ='X'
	where	LotSerT.BatNbr = @BatNbr
		and	not exists (	select	*
					from	LotSerMst
					where	InvtID = LotSerT.InvtID
					and	LotSerNbr = LotSerT.LotSerNbr
					and	SiteID = LotSerT.SiteID
					and	WhseLoc = LotSerT.WhseLoc)
	group by LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr
if @@error != 0 return(@@error)

/*Update ItemSite*/
update ItemSite set
  QtyAllocPORet = round(convert(decimal(25,9),ItemSite.QtyAllocPORet) - @DrCr * v.QtyAllocPORet, @DecPlQty),
  QtyAvail = round(convert(decimal(25,9),ItemSite.QtyAvail) + @DrCr * v.QtyAllocPORet, @DecPlQty)
from
(select POTran.InvtID, POTran.SiteID, QtyAllocPORet = round(sum(case when POTran.UnitMultDiv = 'D' then
						case when POTran.CnvFact <> 0 then
							round(POTran.Qty / POTran.CnvFact, @DecPlQty)
						else
							0
						end
						else
							round(POTran.Qty * POTran.CnvFact, @DecPlQty)
						end), @DecPlQty)
				from	POReceipt, POTran, LocTable
				where	POTran.BatNbr = @BatNbr
				and	POReceipt.RcptNbr = POTRan.RcptNbr
				and	POTran.TranType = 'X'
				and	POTran.PurchaseType = 'GI'
				and	POReceipt.Rlsed = 0
				and	POTran.SiteID = LocTable.SiteID
				and	POTran.WhseLoc = LocTable.WhseLoc
				and	LocTable.InclQtyAvail = 1
	group by POTran.InvtID, POTran.SiteID) v
inner join ItemSite on ItemSite.InvtID = v.InvtID and ItemSite.SiteID = v.SiteID
if @@error != 0 return(@@error)

/*Update Location*/
update Location set
  QtyAllocPORet = round(convert(decimal(25,9),Location.QtyAllocPORet) - @DrCr * v.QtyAllocPORet, @DecPlQty),
  QtyAvail = round(convert(decimal(25,9),Location.QtyAvail) + @DrCr * v.QtyAllocPORet, @DecPlQty)
from
(select POTran.InvtID, POTran.SiteID, POTran.WhseLoc, QtyAllocPORet = round(sum(case when POTran.UnitMultDiv = 'D' then
						case when POTran.CnvFact <> 0 then
							round(POTran.Qty / POTran.CnvFact, @DecPlQty)
						else
							0
						end
						else
							round(POTran.Qty * POTran.CnvFact, @DecPlQty)
						end), @DecPlQty)
				from	POReceipt, POTran, LocTable
				where	POTran.BatNbr = @BatNbr
				and	POReceipt.RcptNbr = POTRan.RcptNbr
				and	POTran.TranType = 'X'
				and	POTran.PurchaseType = 'GI'
				and	POReceipt.Rlsed = 0
				and	POTran.SiteID = LocTable.SiteID
				and	POTran.WhseLoc = LocTable.WhseLoc
				and	LocTable.InclQtyAvail = 1
	group by POTran.InvtID, POTran.SiteID, POTran.WhseLoc) v
inner join Location on Location.InvtID = v.InvtID and Location.SiteID = v.SiteID and Location.WhseLoc = v.WhseLoc
if @@error != 0 return(@@error)

/*Update Lot/Serial Master*/
update LotSerMst set
  QtyAllocPORet = round(convert(decimal(25,9),LotSerMst.QtyAllocPORet) - @DrCr * v.QtyAllocPORet, @DecPlQty),
  QtyAvail = round(convert(decimal(25,9),LotSerMst.QtyAvail) + @DrCr * v.QtyAllocPORet, @DecPlQty)
from
(select LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr,
					QtyAllocPORet = round(sum(-LotSerT.InvtMult * LotSerT.Qty), @DecPlQty)
					from	LotSerT, POReceipt, LocTable
					where	LotSerT.BatNbr = @BatNbr and LotSerT.InvtMult * LotSerT.Qty < 0
					and	LotSerT.BatNbr = POReceipt.BatNbr
					and	LotSerT.RefNbr = POReceipt.RcptNbr
					and	POReceipt.RcptType = 'X'
					and	POReceipt.Rlsed = 0
					and	LotSerT.Rlsed = 0
					and	LotSerT.SiteID = LocTable.SiteID
					and	LotSerT.WhseLoc = LocTable.WhseLoc
					and	LocTable.InclQtyAvail = 1
	group by LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr) v
inner join LotSerMst on LotSerMst.InvtID = v.InvtID and LotSerMst.SiteID = v.SiteID and LotSerMst.WhseLoc = v.WhseLoc and LotSerMst.LotSerNbr = v.LotSerNbr
if @@error != 0 return(@@error)


