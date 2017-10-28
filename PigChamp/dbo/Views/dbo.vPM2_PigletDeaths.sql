
CREATE VIEW [dbo].[vPM2_PigletDeaths] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(Qty)
	FROM SowPigletDeathEventTemp WITH (NOLOCK)
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigletDeaths] TO [se\analysts]
    AS [dbo];

