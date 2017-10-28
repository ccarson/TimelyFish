CREATE VIEW [vPM2_ServiceToFarrowDetail] (FarmID, WeekOfDate, SowID, SowGenetics, SowParity)
	As
	SELECT FarmID, WeekOfDate, SowID, Min(SowGenetics) As SowGenetics, Max(SowParity) As SowParity
		FROM vPM2_ServiceToFarrowBaseDetail WITH (NOLOCK)
		GROUP BY FarmID, WeekOfDate, SowID

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_ServiceToFarrowDetail] TO [se\analysts]
    AS [dbo];

