
create VIEW [dbo].[vPM2_AdjServedToFarrow] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM vPM2_AdjServiceToFarrowDetail WITH (NOLOCK) 	
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

