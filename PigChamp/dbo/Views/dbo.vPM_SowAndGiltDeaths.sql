

CREATE VIEW [dbo].[vPM_SowAndGiltDeaths] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM dbo.vPM_SowAndGiltDeathsBase v
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


