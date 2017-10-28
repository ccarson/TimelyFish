CREATE VIEW dbo.cfvPigSupplier
AS
SELECT     dbo.cftContact.*, dbo.cftContactRoleType.RoleTypeID AS Expr1
FROM         dbo.cftContact INNER JOIN
                      dbo.cftContactRoleType ON dbo.cftContact.ContactID = dbo.cftContactRoleType.ContactID
WHERE     (dbo.cftContactRoleType.RoleTypeID = '004')
