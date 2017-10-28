CREATE VIEW dbo.vVets
AS
SELECT     dbo.Contact.ContactID, dbo.Contact.ContactFirstName + ' ' + LEFT(dbo.Contact.ContactLastName, 1) + '.' AS VetName
FROM         Contact INNER JOIN
                      dbo.ContactRoleType ON dbo.Contact.ContactID = dbo.ContactRoleType.ContactID
WHERE     (dbo.ContactRoleType.RoleTypeID = 1)
