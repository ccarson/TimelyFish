 CREATE Procedure IRVendor_Find_ForItem
	@InvtID VarChar(30),
	@SiteID VarChar(10)
As
Select
-- Need the convert and case, as need to get no result when replen policy is not in 1,2
	Convert(Char(15),(Case When ReplMthd in (1,2) Then IRPrimaryVendID Else '' End)) As 'ReplMthd'
From
	IRItemSiteReplenVar
Where
	InvtID = @InvtID
	and SiteID = @SiteID


