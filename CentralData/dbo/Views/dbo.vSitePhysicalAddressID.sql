CREATE VIEW dbo.vSitePhysicalAddressID
AS
SELECT     dbo.Site.SiteID, dbo.ContactAddress.AddressID, dbo.ContactAddress.AddressTypeID,dbo.Site.ContactID
FROM         dbo.Site INNER JOIN
                      dbo.ContactAddress ON dbo.Site.ContactID = dbo.ContactAddress.ContactID
WHERE     (dbo.ContactAddress.AddressTypeID = 1)

