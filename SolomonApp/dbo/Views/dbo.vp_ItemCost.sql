 

Create View vp_ItemCost
As
	Select	ItemCost.InvtID,
		ItemCost.SiteID,
		LayerType = Case When DataLength(RTrim(ItemCost.LayerType)) = 0 Then 'S' Else ItemCost.LayerType End,
		ItemCost.SpecificCostID,
		ItemCost.RcptNbr, 
		ItemCost.RcptDate, ItemCost.Qty, ItemCost.UnitCost, ItemCost.TotCost 
		From	ItemCost

 
