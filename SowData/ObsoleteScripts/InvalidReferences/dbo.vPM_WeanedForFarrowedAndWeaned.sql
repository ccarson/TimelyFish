CREATE VIEW dbo.vPM_WeanedForFarrowedAndWeaned (FarmID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowParity, SowGenetics, Qty = SUM(Qty)
	FROM vPM_WeanedForFarrowedAndWeanedBase
	WHERE Qty IS NOT NULL
	GROUP BY FarmID, WeekOfDate, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_WeanedForFarrowedAndWeaned] TO [se\analysts]
    AS [dbo];

