 Create	Proc DMG_10990_UpdChanged_Location
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the Location table for the Rebuild Quantities and Cost option
	of Integrity Check with the values calculated in the Location comparison table that are flagged
	to have changed since the last Rebuild.
*/
	Set	NoCount On

	Update	Location
		Set	QtyOnHand = IN10990_Location.QtyOnHand
		From	Location Join IN10990_Location
			On Location.InvtID = IN10990_Location.InvtID
			And Location.SiteID = IN10990_Location.SiteID
			And Location.WhseLoc = IN10990_Location.WhseLoc
			Join vp_10990_ChangedItems Changed
			On Location.InvtID = Changed.InvtID
		WHERE Location.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_UpdChanged_Location] TO [MSDSL]
    AS [dbo];

