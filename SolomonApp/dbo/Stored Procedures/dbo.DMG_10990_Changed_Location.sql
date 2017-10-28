 Create	Proc DMG_10990_Changed_Location
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the Location comparison table
	so that only records that have changed are flagged.
*/
	Set	NoCount On

	Update	IN10990_Location
		Set Changed = 0
	WHERE IN10990_Location.InvtID LIKE @InvtIDParm

	Update	IN10990_Location
		Set Changed = 1
		From	Location Left Join IN10990_Location
			On Location.InvtID = IN10990_Location.InvtID
			And Location.SiteID = IN10990_Location.SiteID
			And Location.WhseLoc = IN10990_Location.WhseLoc
		Where	Location.tStamp <> IN10990_Location.MstStamp
			AND IN10990_Location.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_Changed_Location] TO [MSDSL]
    AS [dbo];

