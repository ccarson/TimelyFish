 CREATE Procedure IR_FindVendor @InvtID VarChar(30), @SiteID varchar(15) as
Select
	IRPrimaryVendID As 'VendID'
From
	IRItemSiteReplenVar
Where
	InvtID = @InvtID
	And SiteID = @SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IR_FindVendor] TO [MSDSL]
    AS [dbo];

