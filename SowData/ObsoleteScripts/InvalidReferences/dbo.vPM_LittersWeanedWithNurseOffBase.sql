CREATE VIEW [dbo].[vPM_LittersWeanedWithNurseOffBase] (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics)
	AS
	-- This calculation uses the first date of either wean or nurse off for a sow parity record
	-- as the basis for getting the sum of qty born alive.
	SELECT FarmID, SowID, Min(WeekOfDate), Min(EventDate), SowParity, SowGenetics
	FROM dbo.vPM_LittersWeanedWithNurseOffDetail
	GROUP BY FarmID, SowID, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_LittersWeanedWithNurseOffBase] TO [se\analysts]
    AS [dbo];

