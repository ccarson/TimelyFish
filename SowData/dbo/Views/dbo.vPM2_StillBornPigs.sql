CREATE VIEW [vPM2_StillBornPigs] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyStillBorn)
	FROM SowFarrowEventTemp WITH (NOLOCK)
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_StillBornPigs] TO [se\analysts]
    AS [dbo];

