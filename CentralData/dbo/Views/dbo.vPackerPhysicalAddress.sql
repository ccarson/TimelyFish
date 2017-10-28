CREATE VIEW dbo.vPackerPhysicalAddress
AS
SELECT     dbo.Packer.ContactID, dbo.ContactAddress.AddressID, dbo.ContactAddress.AddressTypeID
FROM         dbo.ContactAddress INNER JOIN
                      dbo.Packer ON dbo.ContactAddress.ContactID = dbo.Packer.ContactID
WHERE     (dbo.ContactAddress.AddressTypeID = 1)

