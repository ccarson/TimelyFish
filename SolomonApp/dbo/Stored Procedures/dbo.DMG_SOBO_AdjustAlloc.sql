 Create Proc DMG_SOBO_AdjustAlloc
	@CpnyID		varchar(10),
	@OrdNbr		Varchar(10),
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

if not exists(select * from SOSched (nolock) where CpnyID = @CpnyID and OrdNbr = @OrdNbr and LotSerialEntered = 1)
return(0)

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
		max(ABCCode), 0, 0, 0,
		max(BMIDirStdCost), max(BMIFOvhStdCost), max(BMILastCost), max(BMIPDirStdCost),
		max(BMIPFOvhStdCost), max(BMIPStdCost), max(BMIPVOvhStdCost), max(BMIStdCost),
		0, max(BMIVOvhStdCost), '', max(n.COGSAcct),
		max(n.COGSSub), 'A', @CpnyID, getdate(),
		@ProgID, @UserID, max(CycleID), max(DfltPOUnit),
		max(DfltSOUnit), max(DirStdCost), 0, max(FOvhStdCost),
		max(InvtAcct), sol.InvtID, max(InvtSub), 0,
		0, '', '', 0,
		0, 0, 0, 0,
		'', 999, getdate(), @ProgID,
		@UserID, 0, 0, max(MoveClass),
		0, max(PDirStdCost), max(PFOvhStdCost), '',
		'', max(PStdCostDate),max(PStdCost), max(PVOvhStdCost),
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, '', '', '',
		0, 0, 0, 0,
		'', '', 0, 0,
		'', '', 0, 0,
		max(DfltSalesAcct), max(DfltSalesSub), '', 0,
		max(DfltShpNotInvAcct), max(DfltShpNotInvSub), sos.SiteID, max(StdCost),
		max(StdCostDate), max(StkItem), 0, 0,
		max(UsageRate), '', '', 0,
		0, '', '', '',
		'', max(VOvhStdCost), 0
	from	SOLine sol
	inner 	join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef
	inner 	join Inventory n (nolock) on n.InvtID = sol.InvtID
	where	sol.CpnyID = @CpnyID and sol.OrdNbr = @OrdNbr and sos.LotSerialEntered = 1
	and not exists (	select	InvtID, SiteID
				from	ItemSite
				where	InvtID = sol.InvtID
				and	SiteID = sos.SiteID)
	group by sol.InvtID, sos.SiteID
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
	select distinct
		'A', getdate(), @ProgID, @UserID,
		sol.InvtID, getdate(), @ProgID, @UserID, 0,
		0, 0, 0, 0,
		'', '', 0, 0,
		0, 0, '', '',
		0, 0, '', '',
		0, sos.SiteID, '', '', 0, 0,
		'', '', '', '', lot.WhseLoc

	from	SOLine sol
	inner 	join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef
	inner 	join SOLot lot on lot.CpnyID = sos.CpnyID and lot.OrdNbr = sos.OrdNbr and lot.LineRef = sos.LineRef and lot.SchedRef = sos.SchedRef
	inner 	join Inventory n (nolock) on n.InvtID = sol.InvtID
	where	sol.CpnyID = @CpnyID and sol.OrdNbr = @OrdNbr and sos.LotSerialEntered = 1
	and	not exists (	select	InvtID, SiteID, WhseLoc
				from	Location
				where	InvtID = sol.InvtID
				and	SiteID = sos.SiteID
				and	WhseLoc = lot.WhseLoc)
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
			'', sol.InvtID, '', lot.LotSerNbr,
			getdate(), @ProgID, @UserID,
			'', 0, 0, 0,
			0, 0, 0, '',
			'', '', 0, 0,
			0, 0, '', '',
			0, 0, '', '',
			'', sos.SiteID, 'OM', '', 'H', '',
			'', '', 0, 0,
			'', '', '', '',
			'', lot.WhseLoc

	from	SOLine sol
	inner 	join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef
	inner 	join SOLot lot on lot.CpnyID = sos.CpnyID and lot.OrdNbr = sos.OrdNbr and lot.LineRef = sos.LineRef and lot.SchedRef = sos.SchedRef
	inner 	join Inventory n (nolock) on n.InvtID = sol.InvtID
	where	sol.CpnyID = @CpnyID and sol.OrdNbr = @OrdNbr and sos.LotSerialEntered = 1
		and	not exists (	select	InvtID, SiteID, WhseLoc, LotSerNbr
					from	LotSerMst
					where	InvtID = sol.InvtID
					and	LotSerNbr = lot.LotSerNbr
					and	SiteID = sos.SiteID
					and	WhseLoc = lot.WhseLoc)
if @@error != 0 return(@@error)

/*Update ItemSite*/
update ItemSite set
  QtyAllocSO = round(convert(decimal(25,9),ItemSite.QtyAllocSO) - @DrCr * v.QtyAllocSO, @DecPlQty),
  QtyAvail = round(convert(decimal(25,9),ItemSite.QtyAvail) + @DrCr * v.QtyAllocSO, @DecPlQty)
from
(select sol.InvtID, sos.SiteID,
QtyAllocSO = sum(convert(decimal(25,9), QtyShipStock))
	from	SOLine sol
	inner 	join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef
	inner 	join SOLot lot on lot.CpnyID = sos.CpnyID and lot.OrdNbr = sos.OrdNbr and lot.LineRef = sos.LineRef and lot.SchedRef = sos.SchedRef
	where	sol.CpnyID = @CpnyID and sol.OrdNbr = @OrdNbr and sos.LotSerialEntered = 1
group by sol.InvtID, sos.SiteID) v
inner join ItemSite on ItemSite.InvtID = v.InvtID and ItemSite.SiteID = v.SiteID
if @@error != 0 return(@@error)

/*Update Location*/
update Location set
  QtyAllocSO = round(convert(decimal(25,9),Location.QtyAllocSO) - @DrCr * v.QtyAllocSO, @DecPlQty),
  QtyAvail = round(convert(decimal(25,9),Location.QtyAvail) + @DrCr * v.QtyAllocSO, @DecPlQty)
from(select sol.InvtID, sos.SiteID, lot.WhseLoc,
QtyAllocSO = sum(convert(decimal(25,9), QtyShipStock))
	from	SOLine sol
	inner 	join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef
	inner 	join SOLot lot on lot.CpnyID = sos.CpnyID and lot.OrdNbr = sos.OrdNbr and lot.LineRef = sos.LineRef and lot.SchedRef = sos.SchedRef
	where	sol.CpnyID = @CpnyID and sol.OrdNbr = @OrdNbr and sos.LotSerialEntered = 1
group by sol.InvtID, sos.SiteID, lot.WhseLoc) v
inner join Location on Location.InvtID = v.InvtID and Location.SiteID = v.SiteID and Location.WhseLoc = v.WhseLoc
if @@error != 0 return(@@error)

/*Update Lot/Serial Master*/
update LotSerMst set
  QtyAllocSO = round(convert(decimal(25,9),LotSerMst.QtyAllocSO) - @DrCr * v.QtyAllocSO, @DecPlQty),
  QtyAvail = round(convert(decimal(25,9),LotSerMst.QtyAvail) + @DrCr * v.QtyAllocSO, @DecPlQty)
from(select sol.InvtID, sos.SiteID, lot.WhseLoc, lot.LotSerNbr,
QtyAllocSO = sum(convert(decimal(25,9), QtyShipStock))
	from	SOLine sol
	inner 	join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef
	inner 	join SOLot lot on lot.CpnyID = sos.CpnyID and lot.OrdNbr = sos.OrdNbr and lot.LineRef = sos.LineRef and lot.SchedRef = sos.SchedRef
	where	sol.CpnyID = @CpnyID and sol.OrdNbr = @OrdNbr and sos.LotSerialEntered = 1
group by sol.InvtID, sos.SiteID, lot.WhseLoc, lot.LotSerNbr) v
inner join LotSerMst on LotSerMst.InvtID = v.InvtID and LotSerMst.SiteID = v.SiteID and LotSerMst.WhseLoc = v.WhseLoc and LotSerMst.LotSerNbr = v.LotSerNbr
if @@error != 0 return(@@error)

if @DrCr = 1
delete 	LotSerMst
from	SOLine sol
inner 	join SOSched sos on sos.CpnyID = sol.CpnyID and sos.OrdNbr = sol.OrdNbr and sos.LineRef = sol.LineRef
inner 	join SOLot lot on lot.CpnyID = sos.CpnyID and lot.OrdNbr = sos.OrdNbr and lot.LineRef = sos.LineRef and lot.SchedRef = sos.SchedRef
inner 	join Inventory n (nolock) on n.InvtID = sol.InvtID
inner 	join LotSerMst on LotSerMst.InvtID = sol.InvtID and LotSerMst.SiteID = sos.SiteID and LotSerMst.WhseLoc = lot.WhseLoc and LotSerMst.LotSerNbr = lot.LotSerNbr
where	sol.CpnyID = @CpnyID and sol.OrdNbr = @OrdNbr and sos.LotSerialEntered = 1 and
	(sos.DropShip = 1 or n.SerAssign = 'U') and LotSerMst.Source = 'OM' and LotSerMst.Status = 'H'
if @@error != 0 return(@@error)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOBO_AdjustAlloc] TO [MSDSL]
    AS [dbo];

