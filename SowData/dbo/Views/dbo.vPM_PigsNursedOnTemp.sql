CREATE VIEW [dbo].[vPM_PigsNursedOnTemp] (FarmID, WeekOfDate, SowID, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowID, SowParity, sum(Qty)
	FROM dbo.SowNurseEventTemp 
	WHERE EventType='NURSE ON'
	GROUP BY FarmID, WeekOfDate, SowID, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsNursedOnTemp] TO [se\analysts]
    AS [dbo];

