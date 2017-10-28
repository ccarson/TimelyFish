CREATE VIEW [vPM2_UnbredGiltDays] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, SUM(CASE AdjDaysMating WHEN 0 THEN SowDays ELSE AdjDaysMating END)
		FROM vPM2_UnbredGiltDaysBase v WITH (NOLOCK)
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_UnbredGiltDays] TO [se\analysts]
    AS [dbo];

