CREATE VIEW [vPM2_SowsAndGiltsCulled] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM vPM2_SowsAndGiltsCulledBase WITH (NOLOCK)
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowsAndGiltsCulled] TO [se\analysts]
    AS [dbo];

