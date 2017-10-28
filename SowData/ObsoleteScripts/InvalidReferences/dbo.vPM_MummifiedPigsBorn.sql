
CREATE VIEW [dbo].[vPM_MummifiedPigsBorn] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyMummy) 
	FROM dbo.SowFarrowEvent 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_MummifiedPigsBorn] TO [se\analysts]
    AS [dbo];

