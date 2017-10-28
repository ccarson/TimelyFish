CREATE VIEW [vPM2_PigsWeanedWithLastWeanDate] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Qty = Sum(Qty)
	FROM vPM2_SowWeanAndNurseOffBase WITH (NOLOCK)
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigsWeanedWithLastWeanDate] TO [se\analysts]
    AS [dbo];

