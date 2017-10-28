CREATE VIEW [dbo].[vPM_PigsDeathTemp] (FarmID, WeekOfDate, SowID, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowID, SowParity,sum(Qty)
	FROM dbo.SowPigletDeathEventTemp  
	GROUP BY FarmID, WeekOfDate, SowID, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsDeathTemp] TO [se\analysts]
    AS [dbo];

