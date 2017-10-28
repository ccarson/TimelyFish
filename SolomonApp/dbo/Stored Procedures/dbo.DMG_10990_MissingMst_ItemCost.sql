 Create	Proc DMG_10990_MissingMst_ItemCost
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will populate the ItemCost Master Table with any records that are missing.
*/
	Set	NoCount On

	Insert	Into ItemCost
		(BMITotCost, Crtd_DateTime, Crtd_Prog,
		Crtd_User, InvtID, LayerType, LUpd_DateTime, LUpd_Prog,
		LUpd_User, Qty, RcptDate, RcptNbr,
		SiteID, SpecificCostID, TotCost,
		UnitCost)
	Select	IN10990_ItemCost.BMITotCost, IN10990_ItemCost.Crtd_DateTime, IN10990_ItemCost.Crtd_Prog,
		IN10990_ItemCost.Crtd_User, IN10990_ItemCost.InvtID,
		Case	When	DataLength(RTrim(IN10990_ItemCost.LayerType)) > 0
				Then IN10990_ItemCost.LayerType
			Else	'S'
		End,
		IN10990_ItemCost.LUpd_DateTime, IN10990_ItemCost.LUpd_Prog, IN10990_ItemCost.LUpd_User,
		IN10990_ItemCost.Qty, IN10990_ItemCost.RcptDate, IN10990_ItemCost.RcptNbr,
		IN10990_ItemCost.SiteID, IN10990_ItemCost.SpecificCostID, IN10990_ItemCost.TotCost,
		IN10990_ItemCost.UnitCost
		From	IN10990_ItemCost Left Join ItemCost
			On IN10990_ItemCost.InvtID = ItemCost.InvtID
			And IN10990_ItemCost.SiteID = ItemCost.SiteID
			And IN10990_ItemCost.LayerType = ItemCost.LayerType
			And IN10990_ItemCost.SpecificCostID = ItemCost.SpecificCostID
			And IN10990_ItemCost.RcptDate = ItemCost.RcptDate
			And IN10990_ItemCost.RcptNbr = ItemCost.RcptNbr
		Where	IN10990_ItemCost.Qty <> 0
			And ItemCost.InvtID Is Null
			AND IN10990_ItemCost.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_MissingMst_ItemCost] TO [MSDSL]
    AS [dbo];

