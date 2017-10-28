CREATE VIEW dbo.vcfSowSite
AS
SELECT     dbo.cftSowSite.*, dbo.cftContact.ContactName AS SiteName
FROM         dbo.cftContact INNER JOIN
                      dbo.cftSowSite ON dbo.cftContact.ContactID = dbo.cftSowSite.ContactID
