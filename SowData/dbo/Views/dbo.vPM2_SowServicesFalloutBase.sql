CREATE VIEW [vPM2_SowServicesFalloutBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity, Days)
	AS
	SELECT FarmID, SowID, WeekOfDate, SowGenetics, SowParity, Min(Days)
	FROM vPM2_SowServicesWithFalloutDetail WITH (NOLOCK)
	WHERE Days Is Not Null
	Group By FarmID, SowID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowServicesFalloutBase] TO [se\analysts]
    AS [dbo];

