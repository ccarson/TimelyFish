CREATE VIEW [dbo].[vPM_PigletDeaths] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(Qty)
	FROM dbo.SowPigletDeathEvent 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigletDeaths] TO [se\analysts]
    AS [dbo];

