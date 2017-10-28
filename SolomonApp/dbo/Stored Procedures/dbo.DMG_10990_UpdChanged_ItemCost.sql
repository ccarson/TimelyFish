 Create	Proc DMG_10990_UpdChanged_ItemCost
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the ItemCost table for the Rebuild Quantities and Cost option
	of Integrity Check with the values calculated in the ItemCost comparison table that are flagged
	to have changed since the last Rebuild.
*/
	Set	NoCount On

	Update	ItemCost
		Set	BMITotCost = IN10990_ItemCost.BMITotCost,
			Qty = IN10990_ItemCost.Qty,
			TotCost = IN10990_ItemCost.TotCost,
			UnitCost = IN10990_ItemCost.UnitCost
		From	ItemCost Join IN10990_ItemCost
			On ItemCost.InvtID = IN10990_ItemCost.InvtID
			And ItemCost.SiteID = IN10990_ItemCost.SiteID
			And ItemCost.LayerType = IN10990_ItemCost.LayerType
			And ItemCost.SpecificCostID = IN10990_ItemCost.SpecificCostID
			And ItemCost.RcptDate = IN10990_ItemCost.RcptDate
			And ItemCost.RcptNbr = IN10990_ItemCost.RcptNbr
			Join vp_10990_ChangedItems Changed
			On ItemCost.InvtID = Changed.InvtID
		WHERE	ItemCost.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_UpdChanged_ItemCost] TO [MSDSL]
    AS [dbo];

