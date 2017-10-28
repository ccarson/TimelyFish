CREATE VIEW [vPM2_TotalSowDays] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Sum(SowDays) 
		FROM vPM2_TotalSowDaysBase WITH (NOLOCK)
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_TotalSowDays] TO [se\analysts]
    AS [dbo];

