CREATE VIEW [dbo].[vSowServicesFallout0To28] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM dbo.vSowServicesFalloutBase
	where Days Between 0 AND 28
	Group By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowServicesFallout0To28] TO [se\analysts]
    AS [dbo];

