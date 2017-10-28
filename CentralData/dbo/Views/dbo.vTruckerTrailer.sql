CREATE VIEW dbo.vTruckerTrailer
AS
SELECT     tt.MarketTruckerID as TruckerTrailerID, ((CASE c.ContactTypeID WHEN 1 THEN c.ContactName ELSE LEFT(c.ContactFirstName, 1) + '. ' + c.ContactLastName END) 
                      + ' ' + (CASE tt.TruckNbr WHEN 1 THEN '' ELSE tt.TruckNbr END)) AS TruckName, c.ContactID, c.ContactName
FROM         dbo.MarketTrucker tt INNER JOIN
                      dbo.Contact c ON tt.ContactID = c.ContactID
UNION
SELECT     9999, '', '', ''

