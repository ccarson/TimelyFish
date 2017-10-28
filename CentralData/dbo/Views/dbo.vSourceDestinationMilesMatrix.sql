CREATE VIEW dbo.vSourceDestinationMilesMatrix
AS
SELECT     dbo.vSitePhysicalAddressID.ContactID as SiteID,dbo.vSitePhysicalAddressID.ContactID as FromContactID, dbo.vContactPhysicalAddress.ContactID, dbo.MilesMatrix.OneWayMiles, dbo.MilesMatrix.OneWayHours
FROM         dbo.MilesMatrix INNER JOIN
                      dbo.vContactPhysicalAddress ON dbo.MilesMatrix.AddressIDTo = dbo.vContactPhysicalAddress.AddressID INNER JOIN
                      dbo.vSitePhysicalAddressID ON dbo.MilesMatrix.AddressIDFrom = dbo.vSitePhysicalAddressID.AddressID JOIN
				  dbo.Contact c on vSitePhysicalAddressID.ContactID=c.ContactID

