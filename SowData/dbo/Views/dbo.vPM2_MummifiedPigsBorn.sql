CREATE VIEW [vPM2_MummifiedPigsBorn] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyMummy) 
	FROM SowFarrowEventTemp WITH (NOLOCK)
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_MummifiedPigsBorn] TO [se\analysts]
    AS [dbo];

