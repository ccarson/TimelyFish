CREATE VIEW [vPM2_SowServicesFallout0To28] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM vPM2_SowServicesFalloutBase WITH (NOLOCK)
	where Days Between 0 AND 28
	Group By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowServicesFallout0To28] TO [se\analysts]
    AS [dbo];

