 CREATE PROC ADG_Kit_Active_Sites
	@KitID	varchar (30),
	@SiteID	varchar (10)
AS
SELECT Kit.SiteId, Site.Name
FROM Kit
	left outer join Site
		on 	Kit.SiteId = Site.SiteId
WHERE Kit.KitId like @KitID AND
	Kit.SiteId like @SiteID AND
	Kit.Status = 'A'
ORDER BY Kit.SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Kit_Active_Sites] TO [MSDSL]
    AS [dbo];

