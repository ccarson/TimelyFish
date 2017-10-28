CREATE VIEW vPM2_WeanedForFarrowedAndWeanedBase (FarmID, SowID, WeekOfDate, SowParity, SowGenetics, Qty)
	AS
	SELECT sfe.FarmID, sfe.SowID, sfe.WeekOfDate, sfe.SowParity, sfe.SowGenetics, 
	Qty = (Select SUM(Qty) FROM SowWeanEventTemp WITH (NOLOCK) WHERE FarmID = sfe.FarmID and SowID = sfe.SowID
		AND SowParity = sfe.SowParity)
	FROM SowFarrowEventTemp sfe WITH (NOLOCK)
	WHERE SowID IN(SELECT distinct SowID From SowWeanEventTemp WITH (NOLOCK) WHERE FarmID = sfe.FarmID and SowID = sfe.SowID
		AND SowParity = sfe.SowParity
		UNION Select DISTINCT SowID From SowNurseEventTemp WITH (NOLOCK) WHERE FarmID = sfe.FarmID and SowID = sfe.SowID
		AND SowParity = sfe.SowParity)
	GROUP BY FarmID, SowID, WeekOfDate, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_WeanedForFarrowedAndWeanedBase] TO [se\analysts]
    AS [dbo];

