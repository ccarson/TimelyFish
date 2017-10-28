 


Create View vr_10640_BMICostVariance As
      

	Select	ItemBMIHist.InvtID, InvtDescr = Inventory.Descr, ItemBMIHist.SiteID, SiteName = Site.Name,
		HistTot = Round(ItemBMIHist.BMIBegBal - ItemBMIHist.BMIYTDCOGS + ItemBMIHist.BMIYTDCostAdjd 
			- ItemBMIHist.BMIYTDCostIssd + ItemBMIHist.BMIYTDCostRcvd, vp_DecPl.BMIDecPl), 
		ItemSiteTot = Round(ItemSite.BMITotCost, vp_DecPl.BMIDecPl),
		Variance = Round(Round(ItemBMIHist.BMIBegBal - ItemBMIHist.BMIYTDCOGS + ItemBMIHist.BMIYTDCostAdjd 
			- ItemBMIHist.BMIYTDCostIssd + ItemBMIHist.BMIYTDCostRcvd, vp_DecPl.BMIDecPl)
			- Round(ItemSite.BMITotCost, vp_DecPl.BMIDecPl), vp_DecPl.BMIDecPl)
		From	ItemBMIHist (NoLock) Inner Join ItemSite (NoLock)
			  On ItemBMIHist.InvtID = ItemSite.InvtID
			  And ItemBMIHist.SiteID = ItemSite.SiteID
			Inner Join Inventory (NoLock)
			  On ItemBMIHist.InvtID = Inventory.InvtID
			Inner Join Site 
			  On ItemBMIHist.SiteID = Site.SiteID
			Inner Join (SELECT InvtID, SiteID, Max(FiscYr) MaxFiscYr FROM ItemBMIHist GROUP BY InvtID, SiteID) ItemBMIHistMax
			  On ItemBMIHistMax.InvtID = ItemBMIHist.InvtID 
			  and ItemBMIHistMax.SiteID = ItemBMIHist.SiteID
			  and ItemBMIHistMax.MaxFiscYr = ItemBMIHist.FiscYR	
			Join vp_DecPl ON 1=1
			Join INSetup On 1=1
		Where	Inventory.StkItem = 1 AND Inventory.ValMthd <> 'U'
			And Round(ItemBMIHist.BMIBegBal - ItemBMIHist.BMIYTDCOGS + ItemBMIHist.BMIYTDCostAdjd 
			- ItemBMIHist.BMIYTDCostIssd + ItemBMIHist.BMIYTDCostRcvd, vp_DecPl.BMIDecPl)
			<> Round(ItemSite.BMITotCost, vp_DecPl.BMIDecPl)
      


 
