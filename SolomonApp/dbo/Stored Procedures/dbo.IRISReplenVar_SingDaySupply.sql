 Create Procedure IRISReplenVar_SingDaySupply
	@InvtID VarChar(30),
	@SiteID VarChar(10)
As
Select
	IRDaysSupply
From
	IRItemSiteReplenVar
Where
	InvtID = @InvtID
	And SiteID = @SiteID


