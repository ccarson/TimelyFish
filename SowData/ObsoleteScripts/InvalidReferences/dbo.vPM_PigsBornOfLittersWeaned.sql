CREATE VIEW [dbo].[vPM_PigsBornOfLittersWeaned] (FarmID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS 
	SELECT FarmID, WeekOfDate, SowParity, SowGenetics, Sum(Qty)
	FROM dbo.vPM_PigsBornOfLittersWeanedBase
	WHERE Qty IS NOT NULL
	GROUP BY FarmID, WeekOfDate, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsBornOfLittersWeaned] TO [se\analysts]
    AS [dbo];

