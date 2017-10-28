 

-- The following creates a view from the temp table. It sums up qty for the those bottom nodes only that do not supply to other nodes and 
-- populates that qty in the source.

Create	View IRWrkDemandQty_Rollup
As
Select	InvtID, FromSiteID, DemandQty = Sum(DemandQty)
	From	IRWrkItemSite (NoLock)
	Where	Len(RTrim(FromSiteID)) > 0
		And Processed = 0
		And SiteID Not In (Select FromSiteID From IRWrkItemSite Site (NoLock) 
					Where Site.InvtID = IRWrkItemSite.InvtID 
						And Processed = 0 And Len(RTrim(FromSiteID)) > 0)
	Group By InvtID, FromSiteID

 
