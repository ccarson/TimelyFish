CREATE VIEW [vPM2_FemalesEntered] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM vPM2_FemalesEnteredBase WITH (NOLOCK)
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_FemalesEntered] TO [se\analysts]
    AS [dbo];

