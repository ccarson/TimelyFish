CREATE VIEW [vPM2_ServedToFarrow] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM vPM2_ServiceToFarrowDetail WITH (NOLOCK) 	
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_ServedToFarrow] TO [se\analysts]
    AS [dbo];

