CREATE VIEW [dbo].[vPM_PigsWeanedTemp] (FarmID, WeekOfDate, SowID, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowID, SowParity, sum(Qty)
	FROM dbo.SowWeanEventTemp 
	--WHERE EventType='PART WEAN'
	GROUP BY FarmID, WeekOfDate, SowID, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsWeanedTemp] TO [se\analysts]
    AS [dbo];

