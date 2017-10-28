CREATE VIEW dbo.vContactMilesMatrix
AS
SELECT     cSource.ContactID AS SourceSite, cDest.ContactID AS DestSite, Min(mm.OneWayHours) as OneWayHours, Min(mm.OneWayMiles) as OneWayMiles
FROM         dbo.MilesMatrix mm INNER JOIN
                      dbo.ContactAddress cSource ON mm.AddressIDFrom = cSource.AddressID INNER JOIN
                      dbo.ContactAddress cDest ON mm.AddressIDTo = cDest.AddressID
		Group By cSource.ContactID, cDest.ContactID

