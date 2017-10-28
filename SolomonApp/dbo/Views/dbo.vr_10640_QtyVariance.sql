 

Create View vr_10640_QtyVariance As      


	Select	Item2Hist.InvtID, InvtDescr = Inventory.Descr, Item2Hist.SiteID, SiteName = Site.Name,
		HistTot = Round(Item2Hist.BegQty + Item2Hist.YTDQtyAdjd - Item2Hist.YTDQtyIssd 
			+ Item2Hist.YTDQtyRcvd - Item2Hist.YTDQtySls + Item2Hist.YTDQtyDShpSls
			+ Item2Hist.YTDQtyTrsfrIn - Item2Hist.YTDQtyTrsfrOut 
			+ (Select COALESCE(SUM(YTDQtyDShpSls),0) From Item2Hist Item2HistTotal Where Item2HistTotal.InvtID = Item2Hist.InvtID And Item2HistTotal.SiteID =  Item2Hist.SiteID And  Item2HistTotal.FiscYr < Item2Hist.FiscYr), vp_DecPl.DecPlQty), 
		ItemSiteTot = Round(ItemSite.QtyOnHand, vp_DecPl.DecPlQty),
		Variance = Round(Round(Item2Hist.BegQty + Item2Hist.YTDQtyAdjd - Item2Hist.YTDQtyIssd 
			+ Item2Hist.YTDQtyRcvd - Item2Hist.YTDQtySls + Item2Hist.YTDQtyDShpSls 
			+ Item2Hist.YTDQtyTrsfrIn - Item2Hist.YTDQtyTrsfrOut
			+ (Select COALESCE(SUM(YTDQtyDShpSls),0) From Item2Hist Item2HistTotal Where Item2HistTotal.InvtID = Item2Hist.InvtID And Item2HistTotal.SiteID =  Item2Hist.SiteID And  Item2HistTotal.FiscYr < Item2Hist.FiscYr), vp_DecPl.DecPlQty)
			- Round(ItemSite.QtyOnHand, vp_DecPl.DecPlQty), vp_DecPl.DecPlQty)
		From	Item2Hist (NoLock) Inner Join ItemSite (NoLock)
			  On Item2Hist.InvtID = ItemSite.InvtID
			  And Item2Hist.SiteID = ItemSite.SiteID
			Inner Join Inventory (NoLock)
			  On Item2Hist.InvtID = Inventory.InvtID
			Inner Join Site 
			  On Item2Hist.SiteID = Site.SiteID
			Inner Join (SELECT InvtID, SiteID, Max(FiscYr) MaxFiscYr FROM Item2Hist GROUP BY InvtID, SiteID) Item2HistMax
			  On Item2HistMax.InvtID = Item2Hist.InvtID 
			  and Item2HistMax.SiteID = Item2Hist.SiteID
			  and Item2HistMax.MaxFiscYr = Item2Hist.FiscYR	
			Join vp_DecPl ON 1=1
			Join INSetup On 1=1
		Where	Inventory.StkItem = 1 AND Inventory.ValMthd <> 'U'
			And Round(Item2Hist.BegQty + Item2Hist.YTDQtyAdjd - Item2Hist.YTDQtyIssd 
			+ Item2Hist.YTDQtyRcvd - Item2Hist.YTDQtySls + Item2Hist.YTDQtyDShpSls
			+ Item2Hist.YTDQtyTrsfrIn - Item2Hist.YTDQtyTrsfrOut
			+ (Select COALESCE(SUM(YTDQtyDShpSls),0) From Item2Hist Item2HistTotal Where Item2HistTotal.InvtID = Item2Hist.InvtID And Item2HistTotal.SiteID =  Item2Hist.SiteID And  Item2HistTotal.FiscYr < Item2Hist.FiscYr), vp_DecPl.DecPlQty)
			<> Round(ItemSite.QtyOnHand, vp_DecPl.DecPlQty)
      


 
