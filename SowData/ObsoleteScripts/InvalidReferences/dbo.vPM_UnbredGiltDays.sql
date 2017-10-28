CREATE VIEW [dbo].[vPM_UnbredGiltDays] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, SUM(CASE AdjDaysMating WHEN 0 THEN SowDays ELSE AdjDaysMating END)
		FROM dbo.vPM_UnbredGiltDaysBase v
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_UnbredGiltDays] TO [se\analysts]
    AS [dbo];

