CREATE VIEW [dbo].[vPM_SowsAndGiltsCulled] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM dbo.vPM_SowsAndGiltsCulledBase
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_SowsAndGiltsCulled] TO [se\analysts]
    AS [dbo];

