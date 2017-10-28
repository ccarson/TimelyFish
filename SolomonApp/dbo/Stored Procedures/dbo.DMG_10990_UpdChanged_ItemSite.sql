 Create	Proc DMG_10990_UpdChanged_ItemSite
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the ItemSite table for the Rebuild Quantities and Cost option
	of Integrity Check with the values calculated in the ItemSite comparison table that are flagged
	to have changed since the last Rebuild.
*/
	Set	NoCount On

	Update	ItemSite
		Set	AvgCost = 	Case 	When 	IN10990_ItemSite.QtyOnHand = 0
							Then ItemSite.AvgCost
						Else	IN10990_ItemSite.AvgCost
					End,
			BMIAvgCost = 	Case 	When 	IN10990_ItemSite.QtyOnHand = 0
							Then ItemSite.BMIAvgCost
						Else	IN10990_ItemSite.BMIAvgCost
					End,
			BMITotCost = IN10990_ItemSite.BMITotCost,
			QtyOnHand = IN10990_ItemSite.QtyOnHand,
			TotCost = IN10990_ItemSite.TotCost
		From	ItemSite Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
			Join vp_10990_ChangedItems Changed
			On ItemSite.InvtID = Changed.InvtID
		WHERE	ItemSite.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_UpdChanged_ItemSite] TO [MSDSL]
    AS [dbo];

