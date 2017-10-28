CREATE VIEW dbo.vPigSupplier
AS
SELECT     dbo.Contact.ContactID, dbo.Contact.ContactName,'' as DummyFacilityTypeID
FROM         dbo.Contact INNER JOIN
                      dbo.ContactRoleType ON dbo.Contact.ContactID = dbo.ContactRoleType.ContactID
WHERE     (dbo.ContactRoleType.RoleTypeID = 4)

