 CREATE PROC SCM_Kit_BOM_KitId_Active
	@Parm1 varchar (30), @Parm2 varchar (10)
AS
	SELECT Kit.* FROM Kit,Site where
		Kit.KitID = @Parm1 AND
		Kit.Status = 'A' AND
		Kit.KitType = 'B' AND
		Kit.ExpKitDet = 1 AND
		Kit.SiteID LIKE @Parm2 AND
		Site.SiteID = Kit.SiteID
	ORDER BY Kit.SiteID


