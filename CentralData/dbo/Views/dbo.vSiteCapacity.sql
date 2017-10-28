CREATE VIEW dbo.vSiteCapacity
AS
SELECT     s.ContactID as SiteID, SUM(ISNULL(b.StdCap, 0)) AS SiteCap, SUM(ISNULL(b.StdCap, 0) * b.CapMultiplier) AS AltSiteCap
FROM         dbo.vsSite s INNER JOIN
                      dbo.vsBarn b ON s.ContactID = b.ContactID
GROUP BY s.ContactID

