CREATE VIEW dbo.vPM_PigsBornforFarrowedAndWeanedBase (FarmID, SowID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS
	SELECT sfe.FarmID, sfe.SowID, sfe.WeekOfDate, sfe.SowParity, sfe.SowGenetics, Qty = SUM(sfe.QtyBornAlive)
	FROM dbo.SowFarrowEvent sfe
	WHERE SowID IN(SELECT distinct SowID From dbo.SowWeanEvent WHERE FarmID = sfe.FarmID and SowID = sfe.SowID
		AND SowParity = sfe.SowParity
		UNION Select DISTINCT SowID From dbo.SowNurseEvent WHERE FarmID = sfe.FarmID and SowID = sfe.SowID
		AND SowParity = sfe.SowParity)
	GROUP BY FarmID, SowID, WeekOfDate, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsBornforFarrowedAndWeanedBase] TO [se\analysts]
    AS [dbo];

