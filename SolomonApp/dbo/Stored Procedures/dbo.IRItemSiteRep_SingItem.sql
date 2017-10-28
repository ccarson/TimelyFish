 -- Drop proc IRItemSiteReplenVar_SingleItem
CREATE Procedure IRItemSiteRep_SingItem @InvtID VarChar(30), @SiteID Varchar(10) As
Select
	InvtID,
	IRPrimaryVendID,
	ReplMthd,
	IRSourceCode,
	SiteID
From
	IRItemSiteReplenVar
Where
	InvtID = @InvtID
	And SiteID Like @SiteID
Order By
	InvtID,
	SiteID


