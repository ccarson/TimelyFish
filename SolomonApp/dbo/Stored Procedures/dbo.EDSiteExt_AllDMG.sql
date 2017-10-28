 Create Proc EDSiteExt_AllDMG @SiteId varchar(10) As
Select * From EDSiteExt Where SiteId = @SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSiteExt_AllDMG] TO [MSDSL]
    AS [dbo];

