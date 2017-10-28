 Create Proc BMRoutingCopy_All @KitId varchar ( 30) as
	Select * from Routing
		where KitID like @KitId
		Order by Kitid, SiteId, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMRoutingCopy_All] TO [MSDSL]
    AS [dbo];

