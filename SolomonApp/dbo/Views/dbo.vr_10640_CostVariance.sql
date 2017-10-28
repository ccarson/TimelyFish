 


Create View vr_10640_CostVariance As
      
	Select	ItemHist.InvtID, InvtDescr = Inventory.Descr, ItemHist.SiteID, SiteName = Site.Name,
		HistTot = Round(ItemHist.BegBal - ItemHist.YTDCOGS + ItemHist.YTDDShpSls
			+ ItemHist.YTDCostAdjd 	- ItemHist.YTDCostIssd + ItemHist.YTDCostRcvd 
			+ ItemHist.YTDCostTrsfrIn - ItemHist.YTDCostTrsfrOut 
			+ (Select COALESCE(SUM(YTDDShpSls),0) From ItemHist ItemHistTotal Where ItemHistTotal.InvtID = ItemHist.InvtID And ItemHistTotal.SiteID =  ItemHist.SiteID And  ItemHistTotal.FiscYr < ItemHist.FiscYr), vp_DecPl.BaseDecPl), 
		ItemSiteTot = Round(ItemSite.TotCost, vp_DecPl.BaseDecPl),
		Variance = Round(Round(ItemHist.BegBal - ItemHist.YTDCOGS + ItemHist.YTDDShpSls
			+ ItemHist.YTDCostAdjd - ItemHist.YTDCostIssd + ItemHist.YTDCostRcvd 
			+ ItemHist.YTDCostTrsfrIn - ItemHist.YTDCostTrsfrOut
			+ (Select COALESCE(SUM(YTDDShpSls),0) From ItemHist ItemHistTotal Where ItemHistTotal.InvtID = ItemHist.InvtID And ItemHistTotal.SiteID =  ItemHist.SiteID And  ItemHistTotal.FiscYr < ItemHist.FiscYr), vp_DecPl.BaseDecPl)
			- Round(ItemSite.TotCost, vp_DecPl.BaseDecPl), vp_DecPl.BaseDecPl)
		From	ItemHist (NoLock) Inner Join ItemSite (NoLock)
			  On ItemHist.InvtID = ItemSite.InvtID
			  And ItemHist.SiteID = ItemSite.SiteID
			Inner Join Inventory (NoLock)
			  On ItemHist.InvtID = Inventory.InvtID
			Inner Join Site 
			  On ItemHist.SiteID = Site.SiteID
			Inner Join (SELECT InvtID, SiteID, Max(FiscYr) MaxFiscYr FROM ItemHist GROUP BY InvtID, SiteID) ItemHistMax
			  On ItemHistMax.InvtID = ItemHist.InvtID 
			  and ItemHistMax.SiteID = ItemHist.SiteID
			  and ItemHistMax.MaxFiscYr = ItemHist.FiscYR
			Join vp_DecPl ON 1=1
			Join INSetup On 1=1
		Where	Inventory.StkItem = 1 AND Inventory.ValMthd <> 'U'
			And Round(ItemHist.BegBal - ItemHist.YTDCOGS + ItemHist.YTDDShpSls
			+ ItemHist.YTDCostAdjd - ItemHist.YTDCostIssd + ItemHist.YTDCostRcvd 
			+ ItemHist.YTDCostTrsfrIn - ItemHist.YTDCostTrsfrOut
			+ (Select COALESCE(SUM(YTDDShpSls),0) From ItemHist ItemHistTotal Where ItemHistTotal.InvtID = ItemHist.InvtID And ItemHistTotal.SiteID =  ItemHist.SiteID And  ItemHistTotal.FiscYr < ItemHist.FiscYr), vp_DecPl.BaseDecPl)
			<> Round(ItemSite.TotCost, vp_DecPl.BaseDecPl)      


 
