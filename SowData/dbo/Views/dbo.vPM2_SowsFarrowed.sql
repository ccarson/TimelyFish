CREATE VIEW [vPM2_SowsFarrowed] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, count(*)
	FROM SowFarrowEventTemp WITH (NOLOCK) 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowsFarrowed] TO [se\analysts]
    AS [dbo];

