CREATE VIEW [dbo].[vPM_FemalesEntered] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM dbo.vPM_FemalesEnteredBase
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_FemalesEntered] TO [se\analysts]
    AS [dbo];

