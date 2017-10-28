CREATE VIEW [dbo].[vPM_PigDeathsOfLittersWeaned] (FarmID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS 
	SELECT FarmID, WeekOfDate, SowParity, SowGenetics, Sum(Qty)
	FROM dbo.vPM_PigDeathsOfLittersWeanedBase
	WHERE Qty IS NOT NULL
	GROUP BY FarmID, WeekOfDate, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigDeathsOfLittersWeaned] TO [se\analysts]
    AS [dbo];

