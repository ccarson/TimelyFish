CREATE VIEW [dbo].[vSowServicesFalloutBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity, Days)
	AS
	SELECT FarmID, SowID, WeekOfDate, SowGenetics, SowParity, Min(Days)
	FROM dbo.vSowServicesWithFalloutDetail
	WHERE Days Is Not Null
	Group By FarmID, SowID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowServicesFalloutBase] TO [se\analysts]
    AS [dbo];

