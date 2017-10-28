CREATE VIEW dbo.vSowSites
AS
SELECT     dbo.SowSite.*, dbo.Contact.ContactName AS SowSiteName
FROM         dbo.Contact RIGHT OUTER JOIN
                      dbo.SowSite ON dbo.Contact.ContactID = dbo.SowSite.ContactID

