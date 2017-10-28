CREATE VIEW [vPM2_SowAndGiltDeaths] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM vPM2_SowAndGiltDeathsBase v WITH (NOLOCK)
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowAndGiltDeaths] TO [se\analysts]
    AS [dbo];

