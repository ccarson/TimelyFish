 Create	Proc DMG_10990_Missing_Location
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will populate the Location comparison table with any records that are missing from
	the comparison table.  The Master Timestamp field will alway be defaulted to a binary zero for all
	inserted records.  This will cause the Master Timestamp not to match with the Location table insuring
	that the Inventory Item will be validated and rebuilt if that option is selected.
*/
	Set	NoCount On

	Insert 	Into Location
		(InvtID, SiteID, WhseLoc, Crtd_Prog, Crtd_User,
		LUpd_DateTime, LUpd_Prog, LUpd_User)
	select	t.InvtID, t.SiteID, t.WhseLoc, '10990', 'SYSADMIN',
		Convert(SmallDateTime, GetDate()), '10990', 'SYSADMIN'
	from Intran t
	left join Location l on l.InvtID = t.InvtID and l.SiteID = t.SiteID and l.WhseLoc = t.WhseLoc
	where l.InvtID is null
		AND t.InvtID LIKE @InvtIDParm
	group by t.InvtID, t.SiteID, t.WhseLoc

	Insert	Into IN10990_Location
		(Changed, Crtd_DateTime, Crtd_Prog, Crtd_User, InvtID,
		LUpd_DateTime, LUpd_Prog, LUpd_User, MstStamp, QtyOnHand,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12,
		SiteID,
		User1, User2, User3, User4, User5, User6, User7, User8,
		WhseLoc)
	Select	Changed = 0, Location.Crtd_DateTime, Location.Crtd_Prog, Location.Crtd_User, Location.InvtID,
		Location.LUpd_DateTime, Location.LUpd_Prog, Location.LUpd_User, MstStamp = Cast(0 As Binary(8)),
		Location.QtyOnHand,
		Location.S4Future01, Location.S4Future02, Location.S4Future03,
		Location.S4Future04, Location.S4Future05, Location.S4Future06,
		Location.S4Future07, Location.S4Future08, Location.S4Future09,
		Location.S4Future10, Location.S4Future11, Location.S4Future12,
		Location.SiteID,
		Location.User1, Location.User2, Location.User3, Location.User4,
		Location.User5, Location.User6, Location.User7, Location.User8,
		Location.WhseLoc
		From	Location Left Join IN10990_Location
			On Location.InvtID = IN10990_Location.InvtID
			And Location.SiteID = IN10990_Location.SiteID
			And Location.WhseLoc = IN10990_Location.WhseLoc
		Where	IN10990_Location.InvtID Is Null
			AND Location.InvtID LIKE @InvtIDParm


