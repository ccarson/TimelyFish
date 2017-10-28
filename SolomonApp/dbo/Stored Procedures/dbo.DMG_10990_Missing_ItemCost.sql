 Create	Proc DMG_10990_Missing_ItemCost
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will populate the ItemCost comparison table with any records that are missing from
	the comparison table.  The Master Timestamp field will alway be defaulted to a binary zero for all
	inserted records.  This will cause the Master Timestamp not to match with the ItemCost table insuring
	that the Inventory Item will be validated and rebuilt if that option is selected.
*/
	Set	NoCount On

	Insert	Into IN10990_ItemCost
		(BMITotCost, Changed, Crtd_DateTime, Crtd_Prog,
		Crtd_User, InvtID, LayerType, LUpd_DateTime, LUpd_Prog,
		LUpd_User, MstStamp, Qty, RcptDate, RcptNbr,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12,
		SiteID, SpecificCostID, TotCost,
		User1, User2, User3, User4, User5, User6, User7, User8,
		UnitCost)
	Select	0, Changed = 0, ItemCost.Crtd_DateTime, ItemCost.Crtd_Prog,
		ItemCost.Crtd_User, ItemCost.InvtID,
		Case	When	DataLength(RTrim(ItemCost.LayerType)) > 0
				Then ItemCost.LayerType
			Else	'S'
		End,
		ItemCost.LUpd_DateTime, ItemCost.LUpd_Prog,
		ItemCost.LUpd_User, MstStamp = Cast(0 As Binary(8)), 0,
		RcptDate = Cast(Cast(Month(ItemCost.RcptDate) As VarChar(4)) + '/'
				+ Cast(Day(ItemCost.RcptDate) As VarChar(4)) + '/'
				+ Cast(Year(ItemCost.RcptDate) As VarChar(4)) As SmallDateTime),
		ItemCost.RcptNbr,
		ItemCost.S4Future01, ItemCost.S4Future02, ItemCost.S4Future03,
		ItemCost.S4Future04, ItemCost.S4Future05, ItemCost.S4Future06,
		ItemCost.S4Future07, ItemCost.S4Future08, ItemCost.S4Future09,
		ItemCost.S4Future10, ItemCost.S4Future11, ItemCost.S4Future12,
		ItemCost.SiteID, ItemCost.SpecificCostID, 0,
		ItemCost.User1, ItemCost.User2, ItemCost.User3, ItemCost.User4,
		ItemCost.User5, ItemCost.User6, ItemCost.User7, ItemCost.User8,
		ItemCost.UnitCost
		From	ItemCost Left Join IN10990_ItemCost
			On ItemCost.InvtID = IN10990_ItemCost.InvtID
			And ItemCost.SiteID = IN10990_ItemCost.SiteID
			And ItemCost.LayerType = IN10990_ItemCost.LayerType
			And ItemCost.SpecificCostID = IN10990_ItemCost.SpecificCostID
			And ItemCost.RcptDate = IN10990_ItemCost.RcptDate
			And ItemCost.RcptNbr = IN10990_ItemCost.RcptNbr
		Where	IN10990_ItemCost.InvtID Is Null
			And ItemCost.LayerType = 'S'
			AND ItemCost.InvtID LIKE @InvtIDParm


