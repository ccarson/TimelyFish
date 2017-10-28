CREATE VIEW [dbo].[vPM_ServiceToFarrowDetail] (FarmID, WeekOfDate, SowID, SowGenetics, SowParity)
	As
	SELECT FarmID, WeekOfDate, SowID, Min(SowGenetics) As SowGenetics, Max(SowParity) As SowParity
		FROM dbo.vPM_ServiceToFarrowBaseDetail
		GROUP BY FarmID, WeekOfDate, SowID

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_ServiceToFarrowDetail] TO [se\analysts]
    AS [dbo];

