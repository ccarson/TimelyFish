CREATE VIEW dbo.vContactPhysicalAddress
AS
SELECT     dbo.Contact.ContactID, dbo.ContactAddress.AddressID, dbo.ContactAddress.AddressTypeID, dbo.Address.Address1, dbo.Address.Address2, 
                      dbo.Address.City, dbo.Address.State, dbo.Address.Zip, dbo.Address.Country, dbo.Address.Longitude, dbo.Address.Latitude, dbo.Address.County, 
                      dbo.Address.Township, dbo.Address.SectionNbr, dbo.Address.Range
FROM         dbo.Contact INNER JOIN
                      dbo.ContactAddress ON dbo.Contact.ContactID = dbo.ContactAddress.ContactID INNER JOIN
                      dbo.Address ON dbo.ContactAddress.AddressID = dbo.Address.AddressID
WHERE     (dbo.ContactAddress.AddressTypeID = 1)

