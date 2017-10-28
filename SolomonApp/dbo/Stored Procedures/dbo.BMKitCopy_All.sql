 Create Proc BMKitCopy_All @KitId varchar ( 30) as
	Select * from Kit
		where KitID like @KitId
		Order by Kitid, SiteId, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMKitCopy_All] TO [MSDSL]
    AS [dbo];

