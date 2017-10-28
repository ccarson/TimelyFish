CREATE VIEW dbo.vMarketTrucker
AS
SELECT     tt.ContactID as TruckerID, c.ContactName AS TruckerName
FROM         dbo.MarketTrucker tt INNER JOIN
                      dbo.Contact c ON tt.ContactID = c.ContactID
UNION
SELECT     9999, ''

