

CREATE VIEW [dbo].[vPM_TotalSowDays] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Sum(SowDays) 
		FROM dbo.vPM_TotalSowDaysBase
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


