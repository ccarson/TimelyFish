
CREATE VIEW [dbo].[vPM_PigsBornAlive] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyBornAlive)
	FROM dbo.SowFarrowEvent 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsBornAlive] TO [se\analysts]
    AS [dbo];

