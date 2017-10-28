CREATE VIEW dbo.vSiteGPSCoordinates
	As
	Select s.SiteID, c.ContactName as DescriptiveName, a.Longitude, a.latitude
	FROM dbo.Site s
	JOIN dbo.Contact c on s.contactid = c.contactid
	JOIN dbo.ContactAddress ca on s.contactid = ca.contactid and ca.addresstypeid = 1
	JOIN dbo.Address a on ca.addressid = a.addressid

