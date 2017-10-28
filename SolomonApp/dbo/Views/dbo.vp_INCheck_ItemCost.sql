 

Create	View vp_INCheck_ItemCost
As
/*
	This view will return a summarized view of the standardized Inventory detail transactions 
	specific for the ItemCost table.
*/
	Select	BMITotCost = Round(Sum(	Case	When	INSetup.BMIEnabled = 0
							Then	0
						Else	Case	When	Inc.CuryMultDiv = 'D'
									Then	Round(Coalesce(Inc.TotCost, 0) / Coalesce(Inc.Rate, 1), Pl.BMIDecPl)
								Else	Round(Coalesce(Inc.TotCost, 0) * Coalesce(Inc.Rate, 1), Pl.BMIDecPl)
							End
					End), Pl.BMIDecPl),
		InvtID = Inc.InvtID, 
		LayerType = Coalesce(Inc.LayerType, 'S'),
		Qty = Round(Sum(Coalesce(Inc.Qty, 0)), Pl.DecPlQty),
		RcptDate = Inc.RcptDate,
		RcptNbr = Inc.RcptNbr,
		SiteID = Inc.SiteID,
		SpecificCostID = Coalesce(Inc.SpecificCostID, ''),
		TotCost = Round(Sum(Coalesce(Inc.TotCost, 0)), Pl.BaseDecPl)
		From	vp_DecPl Pl, INSetup,
			IN10990_Check Inc
		Where	(((Inc.ValMthd In ('F', 'L')
			And DataLength(RTrim(Inc.RcptNbr)) > 0)
			Or (Inc.ValMthd In ('S')
			And Inc.SpecificCostID <> ''))
			And Inc.TranType Not In ('AC', 'AS', 'CM', 'DM', 'II', 'IN', 'PI', 'RI', 'TR'))
			And Inc.LayerType <> 'W'
		Group By Inc.InvtID, Inc.SiteID, Inc.LayerType, Inc.SpecificCostID,
			Inc.RcptDate, Inc.RcptNbr, Pl.BMIDecPl, Pl.DecPlQty, Pl.BaseDecPl

UNION

	Select	BMITotCost = Round(Sum(	Case	When	INSetup.BMIEnabled = 0
							Then	0
						Else	Case	When	Inc.CuryMultDiv = 'D'
									Then	Round(Coalesce(Inc.TotCost, 0) / Coalesce(Inc.Rate, 1), Pl.BMIDecPl)
								Else	Round(Coalesce(Inc.TotCost, 0) * Coalesce(Inc.Rate, 1), Pl.BMIDecPl)
							End
					End), Pl.BMIDecPl),
		InvtID = Inc.InvtID, 
		LayerType = Coalesce(Inc.LayerType, 'S'),
		Qty = Round(Sum(Coalesce(Inc.Qty, 0)), Pl.DecPlQty),
		RcptDate = '01/01/1900',
		RcptNbr = '',
		SiteID = Inc.SiteID,
		SpecificCostID = Coalesce(Inc.SpecificCostID, ''),
		TotCost = Round(Sum(Coalesce(Inc.TotCost, 0)), Pl.BaseDecPl)
		From	vp_DecPl Pl, INSetup,
			IN10990_Check Inc
		Where	(((Inc.ValMthd In ('F', 'L')
			And DataLength(RTrim(Inc.RcptNbr)) > 0)
			Or (Inc.ValMthd In ('S')
			And Inc.SpecificCostID <> ''))
			And Inc.TranType Not In ('AC', 'AS', 'CM', 'DM', 'II', 'IN', 'PI', 'RI', 'TR'))
			And Inc.LayerType = 'W'
		Group By Inc.InvtID, Inc.SiteID, Inc.LayerType, Inc.SpecificCostID,
			Pl.BMIDecPl, Pl.DecPlQty, Pl.BaseDecPl


 
