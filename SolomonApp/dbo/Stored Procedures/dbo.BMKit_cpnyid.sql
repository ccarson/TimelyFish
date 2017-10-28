
Create Proc BMKit_cpnyid @cpnyid varchar (10), @KitID varchar ( 30) as
	Select DISTINCT Kit.KitID from Kit
		INNER JOIN site ON Kit.SiteID = site.siteID
		where
		site.cpnyid = @cpnyid
		AND Kit.KitID like @KitID
		Order by Kit.Kitid
