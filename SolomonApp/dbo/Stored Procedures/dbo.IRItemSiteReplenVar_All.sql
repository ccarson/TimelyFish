 Create Procedure IRItemSiteReplenVar_All
	@InvtID VarChar(30),
	@SiteID VarChar(10)
As
Select
	*
From
	IRItemSiteReplenVar
Where
	InvtID Like @InvtID
	And SiteID Like @SiteID
Order By
	InvtID,
	SiteID


