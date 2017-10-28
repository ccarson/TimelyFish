 Create Proc EDLocTable_Verify @SiteId varchar(10), @WhseLoc varchar(10) As
Select Count(*) From LocTable Where SiteId = @SiteId And WhseLoc = @WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDLocTable_Verify] TO [MSDSL]
    AS [dbo];

