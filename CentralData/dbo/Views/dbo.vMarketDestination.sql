CREATE VIEW dbo.vMarketDestination
AS
SELECT     *
FROM         dbo.vPacker
UNION
SELECT     *
FROM         dbo.vTailender


