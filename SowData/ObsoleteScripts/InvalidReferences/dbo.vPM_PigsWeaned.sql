CREATE VIEW [dbo].[vPM_PigsWeaned] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(qty)
	FROM dbo.SowWeanEvent
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsWeaned] TO [se\analysts]
    AS [dbo];

