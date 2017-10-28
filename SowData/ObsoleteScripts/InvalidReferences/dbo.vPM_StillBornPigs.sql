
CREATE VIEW [dbo].[vPM_StillBornPigs] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyStillBorn)
	FROM dbo.SowFarrowEvent 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_StillBornPigs] TO [se\analysts]
    AS [dbo];

