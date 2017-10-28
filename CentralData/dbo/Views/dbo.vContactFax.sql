CREATE VIEW dbo.vContactFax
AS
SELECT     dbo.ContactPhone.ContactID, dbo.Phone.PhoneNbr
FROM         dbo.ContactPhone INNER JOIN
                      dbo.Phone ON dbo.ContactPhone.PhoneID = dbo.Phone.PhoneID
WHERE     (dbo.ContactPhone.PhoneTypeID = 7)

