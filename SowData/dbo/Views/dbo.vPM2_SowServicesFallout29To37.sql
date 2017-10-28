CREATE VIEW [vPM2_SowServicesFallout29To37] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM vPM2_SowServicesFalloutBase WITH (NOLOCK)
	where Days Between 29 AND 37
	Group By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowServicesFallout29To37] TO [se\analysts]
    AS [dbo];

