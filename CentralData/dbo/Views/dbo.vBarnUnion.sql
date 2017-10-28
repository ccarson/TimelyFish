CREATE VIEW dbo.vBarnUnion
AS
SELECT     ContactID, BarnID, BarnNbr, StatusTypeID
FROM         dbo.vBarn
UNION
SELECT     '', 9999, '', 1

