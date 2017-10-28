CREATE VIEW vPM2_WeanedForFarrowedAndWeaned (FarmID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowParity, SowGenetics, Qty = SUM(Qty)
	FROM vPM2_WeanedForFarrowedAndWeanedBase WITH (NOLOCK)
	WHERE Qty IS NOT NULL
	GROUP BY FarmID, WeekOfDate, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_WeanedForFarrowedAndWeaned] TO [se\analysts]
    AS [dbo];

