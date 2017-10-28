
CREATE VIEW [dbo].[vPM2_PigsBornforFarrowedAndWeaned] (FarmID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowParity, SowGenetics, Qty = SUM(Qty)
	FROM vPM2_PigsBornforFarrowedAndWeanedBase WITH (NOLOCK)
	WHERE Qty IS NOT NULL
	GROUP BY FarmID, WeekOfDate, SowParity, SowGenetics


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigsBornforFarrowedAndWeaned] TO [se\analysts]
    AS [dbo];

