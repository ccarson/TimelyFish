CREATE VIEW [vPM2_PigDeathsOfLittersWeaned] (FarmID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS 
	SELECT FarmID, WeekOfDate, SowParity, SowGenetics, Sum(Qty)
	FROM vPM2_PigDeathsOfLittersWeanedBase WITH (NOLOCK)
	WHERE Qty IS NOT NULL
	GROUP BY FarmID, WeekOfDate, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigDeathsOfLittersWeaned] TO [se\analysts]
    AS [dbo];

