CREATE view [dbo].[vPM_AdjServedToFarrow] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
      AS
      SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
            FROM vPM_AdjServiceToFarrowDetail WITH (NOLOCK)      
            GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity
