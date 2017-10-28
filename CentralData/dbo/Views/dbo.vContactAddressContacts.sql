
CREATE VIEW dbo.vContactAddressContacts
AS
SELECT     dbo.Contact.ContactID, dbo.Address.AddressID
FROM         dbo.Address INNER JOIN
                      dbo.Contact ON dbo.Address.TempID = dbo.Contact.ContactID

