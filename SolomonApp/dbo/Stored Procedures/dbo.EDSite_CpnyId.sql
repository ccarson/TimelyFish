 Create Proc EDSite_CpnyId @SiteId varchar(10) As
Select CpnyId From Site Where SiteId = @SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSite_CpnyId] TO [MSDSL]
    AS [dbo];

