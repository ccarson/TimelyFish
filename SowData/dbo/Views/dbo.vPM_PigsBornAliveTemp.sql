CREATE VIEW [dbo].[vPM_PigsBornAliveTemp] (FarmID, WeekOfDate, SowID, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowID, SowParity, sum(QtyBornAlive)
	FROM dbo.SowFarrowEventTemp 
	GROUP BY FarmID, WeekOfDate, SowID, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsBornAliveTemp] TO [se\analysts]
    AS [dbo];

