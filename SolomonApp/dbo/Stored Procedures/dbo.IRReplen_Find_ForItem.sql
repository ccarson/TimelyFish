 CREATE Procedure IRReplen_Find_ForItem @InvtID VarChar(30), @SiteID VarChar(10) As
Select
	ReplMthd,Buyer,IRSourceCode,IRTransferSiteID,IRPrimaryVendID,ShipViaID
From
	IRItemSiteReplenVar
Where
	InvtID = @InvtID
	And SiteID = @SiteID


