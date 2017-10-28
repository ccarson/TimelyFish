Create View [dbo].[vSitetoPackerMileage]

as

SELECT     vsn.DescriptiveName, mm.OneWayMiles, mm.OneWayHours, c.ContactName, 
                      Rate = 
                          (SELECT     mr.Rate
                            FROM          dbo.MileageRate mr
                            WHERE      Ceiling(mm.OneWayMiles) BETWEEN mr.LowMiles AND mr.HighMiles), 
                      vsn.ContactID as SiteID, c.ContactID, p.TrackTotals, p.Culls, p.MaxNbrLoads
FROM         dbo.vSiteName vsn INNER JOIN
                      dbo.vSitePhysicalAddressID spa ON vsn.ContactID = spa.ContactID INNER JOIN
                      dbo.MilesMatrix mm ON spa.AddressID = mm.AddressIDFrom INNER JOIN
                      dbo.vPackerPhysicalAddress ppa ON mm.AddressIDTo = ppa.AddressID INNER JOIN
                      dbo.Contact c ON ppa.ContactID = c.ContactID INNER JOIN
                      dbo.Packer p ON ppa.ContactID = p.ContactID

