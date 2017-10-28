CREATE VIEW [dbo].[vPM_PigsWeanedWithLastWeanDate] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Qty = Sum(Qty)
	FROM dbo.vPM_SowWeanAndNurseOffBase
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsWeanedWithLastWeanDate] TO [se\analysts]
    AS [dbo];

