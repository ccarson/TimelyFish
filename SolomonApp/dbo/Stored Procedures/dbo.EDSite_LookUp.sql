 Create Proc EDSite_LookUp @SiteId varchar(10) As
Select SiteId From Site Where SiteId = @SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSite_LookUp] TO [MSDSL]
    AS [dbo];

