CREATE VIEW dbo.vPM_PigsBornforFarrowedAndWeaned (FarmID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowParity, SowGenetics, Qty = SUM(Qty)
	FROM vPM_PigsBornforFarrowedAndWeanedBase
	WHERE Qty IS NOT NULL
	GROUP BY FarmID, WeekOfDate, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsBornforFarrowedAndWeaned] TO [se\analysts]
    AS [dbo];

