CREATE VIEW dbo.vDiagnosticLab
AS
SELECT     c.ContactID, c.ContactName
FROM         Contact c INNER JOIN
                      dbo.ContactRoleType ON c.ContactID  = dbo.ContactRoleType.ContactID
WHERE     (dbo.ContactRoleType.RoleTypeID = 16)
