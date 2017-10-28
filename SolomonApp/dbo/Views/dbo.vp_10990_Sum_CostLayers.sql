 

Create	View vp_10990_Sum_CostLayers
As
	Select	ItemCost.InvtID, ItemCost.SiteID,
		TotCost = Round(Sum(ItemCost.TotCost), Pl.BaseDecPl),
		BMITotCost = Round(Sum(ItemCost.BMITotCost), Pl.BMIDecPl),
		Qty = Round(Sum(ItemCost.Qty), Pl.DecPlQty)
		From	IN10990_ItemCost ItemCost, vp_DecPl Pl
		Group By ItemCost.InvtID, ItemCost.SiteID, Pl.BaseDecPl, Pl.BMIDecPl, Pl.DecPlQty

 
