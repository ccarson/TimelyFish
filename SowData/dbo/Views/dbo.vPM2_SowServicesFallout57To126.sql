CREATE VIEW [vPM2_SowServicesFallout57To126] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM vPM2_SowServicesFalloutBase WITH (NOLOCK)
	where Days Between 57 AND 126
	Group By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowServicesFallout57To126] TO [se\analysts]
    AS [dbo];

