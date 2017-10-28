CREATE view [dbo].[vPM2_AdjServiceToFarrowDetail] (FarmID, WeekOfDate, SowID, SowGenetics, SowParity)
	As
	SELECT FarmID, WeekOfDate, SowID, Min(SowGenetics) As SowGenetics, Max(SowParity) As SowParity
		FROM vPM2_AdjServiceToFarrowBaseDetail WITH (NOLOCK)
		GROUP BY FarmID, WeekOfDate, SowID
