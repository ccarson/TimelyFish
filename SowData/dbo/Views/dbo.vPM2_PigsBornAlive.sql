CREATE VIEW [vPM2_PigsBornAlive] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyBornAlive)
	FROM SowFarrowEventTemp WITH (NOLOCK)
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigsBornAlive] TO [se\analysts]
    AS [dbo];

