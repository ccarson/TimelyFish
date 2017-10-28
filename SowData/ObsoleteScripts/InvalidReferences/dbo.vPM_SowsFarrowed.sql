
CREATE VIEW [dbo].[vPM_SowsFarrowed] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, count(*)
	FROM dbo.SowFarrowEvent 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_SowsFarrowed] TO [se\analysts]
    AS [dbo];

