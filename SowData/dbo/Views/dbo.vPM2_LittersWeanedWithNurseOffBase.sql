CREATE VIEW [vPM2_LittersWeanedWithNurseOffBase] (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics)
	AS
	-- This calculation uses the first date of either wean or nurse off for a sow parity record
	-- as the basis for getting the sum of qty born alive.
	SELECT FarmID, SowID, Min(WeekOfDate), Min(EventDate), SowParity, SowGenetics
	FROM vPM2_LittersWeanedWithNurseOffDetail WITH (NOLOCK)
	GROUP BY FarmID, SowID, SowParity, SowGenetics

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_LittersWeanedWithNurseOffBase] TO [se\analysts]
    AS [dbo];

