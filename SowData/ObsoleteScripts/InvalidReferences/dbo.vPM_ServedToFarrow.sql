CREATE VIEW [dbo].[vPM_ServedToFarrow] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM dbo.vPM_ServiceToFarrowDetail 	
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_ServedToFarrow] TO [se\analysts]
    AS [dbo];

