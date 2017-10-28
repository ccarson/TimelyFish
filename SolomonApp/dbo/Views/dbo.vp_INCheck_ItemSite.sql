 

Create	View vp_INCheck_ItemSite
As
/*
	This view will return a summarized view of the standardized Inventory detail transactions 
	specific for the ItemSite table.
*/
	Select	BMITotCost = Round(Sum(	Case	When	INSetup.BMIEnabled = 0
							Then	0
						Else	Case	When	Inc.ValMthd = 'T'
								Then	Case	When	Inc.CuryMultDiv = 'D'
											Then	Round(Round(Round(Coalesce(Inc.Qty * Inc.UnitCost, 0), Pl.BaseDecPl), Pl.BaseDecPl) / Coalesce(Inc.Rate, 1), Pl.BMIDecPl)
										Else	Round(Round(Round(Coalesce(Inc.Qty * Inc.UnitCost, 0), Pl.BaseDecPl), Pl.BaseDecPl) *  Coalesce(Inc.Rate, 1), Pl.BMIDecPl)
									End
							Else	Case	When	Inc.CuryMultDiv = 'D'
										Then	Round(Coalesce(Inc.TotCost, 0) / Coalesce(Inc.Rate, 1), Pl.BMIDecPl)
									Else	Round(Coalesce(Inc.TotCost, 0) * Coalesce(Inc.Rate, 1), Pl.BMIDecPl)
								End
							End
					End), Pl.BMIDecPl),
		ItemSite.CpnyID,
		ItemSite.InvtID, 
		QtyOnHand = Round(Sum(Coalesce(Inc.Qty, 0)), Pl.DecPlQty),
		ItemSite.SiteID, 
		TotCost =	Case	When	Inc.ValMthd = 'T'
						Then	Round(Sum(Round(Coalesce(Inc.Qty * Inc.UnitCost, 0), Pl.BaseDecPl)), Pl.BaseDecPl)
					Else	Round(Sum(Coalesce(Inc.TotCost, 0)), Pl.BaseDecPl)
				End,
		Inc.ValMthd
		From	vp_DecPl Pl, INSetup,
			ItemSite Join IN10990_Check Inc
			On	ItemSite.CpnyID = Inc.CpnyID
				And ItemSite.InvtID = Inc.InvtID
				And ItemSite.SiteID = Inc.SiteID
			Join	Inventory
			On	ItemSite.InvtID = Inventory.InvtID
		Where	((Inc.TranType Not In ('AB', 'CG', 'CT')
			And Inventory.ValMthd = 'T')
			Or (Inc.TranType Not In ('AB', 'AS', 'CM', 'DM', 'II', 'IN', 'PI', 'RI', 'TR')
			And Inventory.ValMthd <> 'T')
			Or (Inc.TranType In ('AB') 
			And Inventory.LotSerTrack In ('LI', 'SI')
			And DataLength(RTrim(Inc.LotSerNbr)) = 0)
			Or (Inc.TranType In ('AB') 
			And Inventory.LotSerTrack Not In ('LI', 'SI')))
		Group By ItemSite.InvtID, ItemSite.SiteID, ItemSite.CpnyID, Inc.ValMthd, 
			Pl.BMIDecPl, Pl.DecPlQty, Pl.BaseDecPl


 
