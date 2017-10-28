CREATE VIEW dbo.vTailEnder
AS
SELECT DISTINCT dbo.Contact.ContactID, dbo.Contact.ContactName, 0 AS TrackTotals
FROM         dbo.Contact INNER JOIN
                      dbo.Site ON dbo.Contact.ContactID = dbo.Site.ContactID INNER JOIN
                      dbo.Barn ON dbo.Site.SiteID = dbo.Barn.SiteID
WHERE     (dbo.Barn.FacilityTypeID = 7)
UNION
SELECT     9999, ' ', 0


