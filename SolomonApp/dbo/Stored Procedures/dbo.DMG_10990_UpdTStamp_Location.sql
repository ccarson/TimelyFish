 Create	Proc DMG_10990_UpdTStamp_Location
	@InvtIDParm	VARCHAR (30)
As
/*
	This procedure will update the Location comparison table by clearing the changed flag
	on all previous changed records, and updates the Master TimeStamp field from the TimeStamp
	from the Location table.
*/
	Set	NoCount On
/*
	Delete all zero-qty location records that were inserted by DMG_10990_Missing_Location
*/
	delete loc from
	IN10990_Location cmp
	inner join Location loc on loc.InvtID = cmp.InvtID
				and loc.SiteID = cmp.SiteID
				and loc.WhseLoc = cmp.WhseLoc
	where loc.Crtd_Prog = '10990' and
  	abs(loc.QtyAlloc) < 0.000000005 and abs(loc.QtyOnHand) < 0.000000005 and abs(loc.QtyShipNotInv) < 0.000000005 and abs(loc.QtyWORlsedDemand) < 0.000000005
	AND loc.InvtID LIKE @InvtIDParm

	Update	IN10990_Location
		Set	MstStamp = Location.tStamp,
			Changed = 0
		From	Location Join IN10990_Location
			On Location.InvtID = IN10990_Location.InvtID
			And Location.SiteID = IN10990_Location.SiteID
			And Location.WhseLoc = IN10990_Location.WhseLoc
		Where	Location.tStamp <> IN10990_Location.MstStamp
			AND IN10990_Location.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_UpdTStamp_Location] TO [MSDSL]
    AS [dbo];

