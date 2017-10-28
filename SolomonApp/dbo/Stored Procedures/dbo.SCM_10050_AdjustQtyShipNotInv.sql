 Create Proc SCM_10050_AdjustQtyShipNotInv
	@BatNbr		Varchar(10),
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

if not exists(select * from Intran t (nolock) where t.BatNbr = @BatNbr and t.JrnlType = 'OM' and t.S4Future09 = 0)
return(0)

if @DrCr = -1
Insert	Location(
	CountStatus, Crtd_DateTime, Crtd_Prog, Crtd_User,
	InvtId, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
	QtyAlloc, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
	S4Future01, S4Future02, S4Future03,
	S4Future04, S4Future05, S4Future06, S4Future07,
	S4Future08, S4Future09, S4Future10, S4Future11,
	S4Future12, Selected, SiteId, User1, User2, User3,
	User4, User5, User6, User7, User8, WhseLoc)
Select distinct
	'A', getdate(), @ProgID, @UserID, t.InvtId, getdate(),
	@ProgID, @UserID, 0,
	0, 0, 0, 0,
	'', '', 0, 0, 0,
	0, '', '', 0, 0, '', '', 0,
	t.SiteID, '', '', 0, 0, '', '', '',
	'', t.WhseLoc
From	Intran t (nolock)
left join Location l on l.InvtID = t.InvtID and l.SiteID = t.SiteID and l.WhseLoc = t.WhseLoc
Where	t.BatNbr = @BatNbr and t.JrnlType = 'OM' and t.WhseLoc <> '' and t.S4Future09 = 0 and l.InvtID is null
if @@error != 0 return(@@error)

if @DrCr = -1
Insert Into LotSerMst
	(InvtID, LotSerNbr, SiteID, WhseLoc, Crtd_Prog,
	 Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User, OrigQty,
	Status, Source)
Select	LotSerT.InvtID, LotSerT.LotSerNbr, LotSerT.SiteID, LotSerT.WhseLoc, @ProgID,
	@UserID, getdate(), @ProgID, @UserID,
	0, 'H', 'OM'
From LotSerT (nolock)
left join LotSerMst (NoLock)
	On LotSerT.InvtID = LotSerMst.InvtID
	And LotSerT.LotSerNbr = LotSerMst.LotSerNbr
	And LotSerT.SiteID = LotSerMst.SiteID
	And LotSerT.WhseLoc = LotSerMst.WhseLoc
Where	LotSerT.BatNbr = @BatNbr and LotSerT.TranSrc='OM' and LotSerMst.InvtID Is Null
Group By LotSerT.InvtID, LotSerT.LotSerNbr, LotSerT.SiteID, LotSerT.WhseLoc
if @@error != 0 return(@@error)

/*Update Location*/
update loc set
  loc.QtyShipNotInv = round(convert(decimal(25,9),loc.QtyShipNotInv) - @DrCr * v.QtyShipNotInv, @DecPlQty)
from
(select t.InvtID, t.SiteID, t.WhseLoc,
QtyShipNotInv = sum(round(convert(decimal(25,9), Qty * case when UnitMultDiv = 'M' then CnvFact else 1 end / case when UnitMultDiv = 'D' then CnvFact else 1 end), @DecPlQty))
from Intran t (nolock)
where t.BatNbr = @BatNbr and t.JrnlType = 'OM' and t.S4Future09 = 0
group by t.InvtID, t.SiteID, t.WhseLoc) v
inner join Location loc on loc.InvtID = v.InvtID and loc.SiteID = v.SiteID and loc.WhseLoc = v.WhseLoc
if @@error != 0 return(@@error)

/*Update Lot/Serial Master*/
update mst set
  mst.QtyShipNotInv = round(convert(decimal(25,9),mst.QtyShipNotInv) - @DrCr * v.QtyShipNotInv, @DecPlQty)
from
(select lot.InvtID, lot.SiteID, lot.WhseLoc, lot.LotSerNbr,
QtyShipNotInv = sum(round(convert(decimal(25,9), lot.Qty * case when UnitMultDiv = 'M' then CnvFact else 1 end / case when UnitMultDiv = 'D' then CnvFact else 1 end), @DecPlQty))
from LotSert lot (nolock)
inner join Intran t (nolock) on t.BatNbr = lot.BatNbr and t.LineRef = lot.INTranLineRef
where lot.BatNbr = @BatNbr and lot.TranSrc = 'OM' and t.S4Future09 = 0
group by lot.InvtID, lot.SiteID, lot.WhseLoc, lot.LotSerNbr) v
inner join LotSerMst mst on mst.InvtID = v.InvtID and mst.SiteID = v.SiteID and mst.WhseLoc = v.WhseLoc and mst.LotSerNbr = v.LotSerNbr
if @@error != 0 return(@@error)

if @DrCr = 1
delete mst
from InTran t (nolock)
inner join LotSerMst mst on mst.InvtID = t.InvtID and mst.SiteID = t.SiteID and mst.WhseLoc = t.WhseLoc
where t.BatNbr = @BatNbr and t.JrnlType ='OM' and
	mst.Status = 'H' and
	mst.Source = 'OM' and
	abs(mst.OrigQty) < 0.0000000005 and
	abs(mst.QtyOnHand) < 0.0000000005 and
	abs(mst.QtyAlloc) < 0.0000000005 and
	abs(mst.QtyShipNotInv) < 0.0000000005 and
	abs(mst.QtyWORlsedDemand) < 0.0000000005
if @@error != 0 return(@@error)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10050_AdjustQtyShipNotInv] TO [MSDSL]
    AS [dbo];

