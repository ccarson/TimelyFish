 

Create	View vp_INCheck_LotSerMst
As
/*
	This view will return a summarized view of the standardized Inventory detail transactions 
	specific for the LotSerMst table.
*/
	Select	LotSerMst.InvtID, LotSerMst.LotSerNbr,
		QtyOnHand = 	Case	When	Inventory.SerAssign = 'U'
						Then	0
					Else	Round(Sum(Inc.Qty), Pl.DecPlQty)
				End,
		LotSerMst.SiteID, 
		LotSerMst.WhseLoc
		From	vp_DecPl Pl,
			LotSerMst Join IN10990_Check Inc
			On	LotSerMst.InvtID = Inc.InvtID
				And LotSerMst.SiteID = Inc.SiteID
				And LotSerMst.WhseLoc = Inc.WhseLoc
				And LotSerMst.LotSerNbr = Inc.LotSerNbr
			Join	Inventory
			On	LotSerMst.InvtID = Inventory.InvtID
		Where	DataLength(RTrim(Inc.LotSerNbr)) > 0
		Group By LotSerMst.InvtID, LotSerMst.SiteID, LotSerMst.WhseLoc, LotSerMst.LotSerNbr,
			Inventory.SerAssign, Pl.DecPlQty


 
