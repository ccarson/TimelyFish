 

-- The following creates a view from the temp table. It contains records only for those bottom nodes that do not supply to other nodes 

Create	View IRWrkDemand_Rollup
As
Select	InvtID, FromSiteID, SiteID
	From	IRWrkItemSite (NoLock)
	Where	Len(RTrim(FromSiteID)) > 0
		And Processed = 0
		And SiteID Not In (Select FromSiteID From IRWrkItemSite Site (NoLock) 
					Where Site.InvtID = IRWrkItemSite.InvtID 
						And Processed = 0 And Len(RTrim(FromSiteID)) > 0)

 
