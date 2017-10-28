
CREATE VIEW dbo.vActiveFinishSites
AS
SELECT DISTINCT TOP 100 PERCENT dbo.Site.SiteID, dbo.Contact.ContactName AS SiteName
FROM         dbo.Site INNER JOIN
                      dbo.Barn ON dbo.Site.SiteID = dbo.Barn.SiteID INNER JOIN
                      dbo.Contact ON dbo.Site.ContactID = dbo.Contact.ContactID
WHERE     (dbo.Contact.StatusTypeID = 1) AND (dbo.Barn.FacilityTypeID = 5) OR
                      (dbo.Barn.FacilityTypeID = 6) OR
                      (dbo.Barn.FacilityTypeID = 7)
ORDER BY dbo.Contact.ContactName

