 

Create	View vp_DfltSiteBins
As
	Select	INCpnyDfltSites.CpnyID, Inventory.InvtID, Inventory.ClassID, 
		DfltSiteID = 	Case	When Len(RTrim(INDfltSites.DfltSiteID)) > 0
						Then	INDfltSites.DfltSiteID
					When Len(RTrim(INProdClDfltSites.DfltSiteID)) > 0
						Then	INProdClDfltSites.DfltSiteID
					When Len(RTrim(INCpnyDfltSites.DfltSiteID)) > 0
						Then	INCpnyDfltSites.DfltSiteID
					Else ''
				End,
		DfltPickBin = 	Case	When Len(RTrim(INDfltSites.DfltPickBin)) > 0
						Then	INDfltSites.DfltPickBin
					When Len(RTrim(INProdClDfltSites.DfltPickBin)) > 0
						Then	INProdClDfltSites.DfltPickBin
					When Len(RTrim(INCpnyDfltSites.DfltPickBin)) > 0
						Then	INCpnyDfltSites.DfltPickBin
					Else ''
				End,
		DfltPutAwayBin = 	Case	When Len(RTrim(INDfltSites.DfltPutAwayBin)) > 0
						Then	INDfltSites.DfltPutAwayBin
					When Len(RTrim(INProdClDfltSites.DfltPutAwayBin)) > 0
						Then	INProdClDfltSites.DfltPutAwayBin
					When Len(RTrim(INCpnyDfltSites.DfltPutAwayBin)) > 0
						Then	INCpnyDfltSites.DfltPutAwayBin
					Else ''
				End
		From	INCpnyDfltSites Cross Join Inventory
			Left Join INProdClDfltSites
			On INCpnyDfltSites.CpnyID = INProdClDfltSites.CpnyID
			And Inventory.ClassID = INProdClDfltSites.ClassID
			Left Join INDfltSites
			On INCpnyDfltSites.CpnyID = INDfltSites.CpnyID
			And Inventory.InvtID = INDfltSites.InvtID


 
