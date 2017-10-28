CREATE PROC cfpAbraCompanySites
	AS
	Select sd.*
	FROM SegDef sd
	LEFT JOIN cftSite s ON sd.ID = s.SiteID
	LEFT JOIN cftContact c ON s.ContactID = c.ContactID
	Where (s.OwnershipTypeID IS NULL Or s.OwnershipTypeID In('01','03','05'))
	AND (s.SiteID Not IN('9999') Or s.SiteID IS NULL) and sd.SegNumber = 3
	ORDER BY sd.id
