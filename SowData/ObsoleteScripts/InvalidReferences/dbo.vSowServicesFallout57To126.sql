CREATE VIEW [dbo].[vSowServicesFallout57To126] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM dbo.vSowServicesFalloutBase
	where Days Between 57 AND 126
	Group By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowServicesFallout57To126] TO [se\analysts]
    AS [dbo];

