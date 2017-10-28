 

Create View vp_ItemCost_OM

As
	Select	ItemCost.*, (ItemCost.Qty - ItemCost.S4Future03) QtyCalc
		From	ItemCost

 
