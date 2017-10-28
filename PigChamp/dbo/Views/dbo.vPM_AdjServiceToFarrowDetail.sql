

CREATE VIEW [dbo].[vPM_AdjServiceToFarrowDetail] (FarmID, WeekOfDate, SowID, SowGenetics, SowParity)
      As
      SELECT FarmID, WeekOfDate, SowID, Min(SowGenetics) As SowGenetics, Max(SowParity) As SowParity
            FROM vPM_AdjServiceToFarrowBaseDetail WITH (NOLOCK)
            GROUP BY FarmID, WeekOfDate, SowID


