CREATE VIEW dbo.vSitetoPackerMileageRates1
AS
SELECT     SiteID, DescriptiveName,
                          (SELECT     Rate
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 453) AS HormelAustinRate,
                          (SELECT     Rate
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 492) AS MorrellSiouxCityRate,
                          (SELECT     Rate
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 493) AS MorrellSiouxFallsRate,
                          (SELECT     Rate
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 510) AS ParksWelcomeRate,
                          (SELECT     Rate
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 554) AS SwiftMarshalltownRate,
                          (SELECT     Rate
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 555) AS SwiftWorthingtonRate,
                          (SELECT     OneWayHours
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 453) AS HormelAustinTime,
                          (SELECT     OneWayHours
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 492) AS MorrellSiouxCityTime,
                          (SELECT     OneWayHours
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 493) AS MorrellSiouxFallsTime,
                          (SELECT     OneWayHours
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 510) AS ParksWelcomeTime,
                          (SELECT     OneWayHours
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 554) AS SwiftMarshalltownTime,
                          (SELECT     OneWayHours
                            FROM          dbo.vSitetoPackerMileage
                            WHERE      SiteID = v1.siteID AND ContactID = 555) AS SwiftWorthingtonTime
FROM         dbo.vSitetoPackerMileage v1
GROUP BY DescriptiveName, SiteID

