 Create	Proc DMG_10990_UpdTStamp_ItemSite
	@InvtIDParm	VARCHAR (30)
As
/*
	This procedure will update the ItemSite comparison table by clearing the changed flag
	on all previous changed records, and updates the Master TimeStamp field from the TimeStamp
	from the ItemSite table.
*/
	Set	NoCount On

/*
	Delete all zero-qty&cost ItemSite records that were inserted by DMG_10990_Missing_ItemSite
*/
	delete s from
	IN10990_ItemSite cmp
	inner join ItemSite s on s.InvtID = cmp.InvtID
				and s.SiteID = cmp.SiteID
	where s.Crtd_Prog = '10990' and
  	abs(s.QtyAlloc) < 0.000000005 and
  	abs(s.QtyCustOrd) < 0.000000005 and
  	abs(s.QtyInTransit) < 0.000000005 and
  	abs(s.QtyNotAvail) < 0.000000005 and
  	abs(s.QtyOnBO) < 0.000000005 and
  	abs(s.QtyOnDP) < 0.000000005 and
  	abs(s.QtyOnHand) < 0.000000005 and
  	abs(s.QtyOnKitAssyOrders) < 0.000000005 and
  	abs(s.QtyOnTransferOrders) < 0.000000005 and
  	abs(s.QtyOnPO) < 0.000000005 and
	abs(s.QtyShipNotInv) < 0.000000005 and
	abs(s.QtyWOFirmDemand) < 0.000000005 and
	abs(s.QtyWOFirmSupply) < 0.000000005 and
	abs(s.QtyWORlsedDemand) < 0.000000005 and
	abs(s.QtyWORlsedSupply) < 0.000000005 and
	abs(s.TotCost) < 0.000000005 and
	not exists(select * from Location loc where loc.InvtID = s.InvtID and loc.SiteID = s.SiteID and not (
			abs(loc.QtyAlloc) < 0.000000005 and
			abs(loc.QtyOnHand) < 0.000000005 and
			abs(loc.QtyShipNotInv) < 0.000000005 and
			abs(loc.QtyWORlsedDemand) < 0.000000005))
	AND cmp.InvtID LIKE @InvtIDParm

	Update	IN10990_ItemSite
		Set	MstStamp = ItemSite.tStamp,
			Changed = 0
		From	ItemSite Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
		Where	ItemSite.tStamp <> IN10990_ItemSite.MstStamp
			AND IN10990_ItemSite.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_UpdTStamp_ItemSite] TO [MSDSL]
    AS [dbo];

