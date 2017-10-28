CREATE VIEW [dbo].[vSowServicesFallout29To37] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM dbo.vSowServicesFalloutBase
	where Days Between 29 AND 37
	Group By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowServicesFallout29To37] TO [se\analysts]
    AS [dbo];

