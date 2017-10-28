CREATE view [dbo].[vPM_SowAndGiltDeaths] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM dbo.vPM_SowAndGiltDeathsBase v
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_SowAndGiltDeaths] TO [se\analysts]
    AS [dbo];

