CREATE VIEW [dbo].[vLastWeaning]
	AS 
	SELECT FarmID, SowID, EventDate = Max(EventDate), WeekOfDate = Max(WeekOfDate), SowGenetics, SowParity, Qty = Sum(Qty)
	FROM dbo.vLastWeaningsDetail
	GROUP BY FarmID, SowID, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vLastWeaning] TO [se\analysts]
    AS [dbo];

