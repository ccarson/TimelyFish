CREATE VIEW [dbo].[vPM_SowWeanAndNurseOffBase]
	AS 
	SELECT FarmID, SowID, EventDate = Max(EventDate), WeekOfDate = Max(WeekOfDate), SowGenetics, SowParity, Qty = Sum(Qty)
	FROM dbo.vPM_SowWeanAndNurseOffDetail
	GROUP BY FarmID, SowID, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_SowWeanAndNurseOffBase] TO [se\analysts]
    AS [dbo];

