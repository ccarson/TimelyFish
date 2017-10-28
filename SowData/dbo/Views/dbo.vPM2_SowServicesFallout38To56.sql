CREATE VIEW [vPM2_SowServicesFallout38To56] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM vPM2_SowServicesFalloutBase WITH (NOLOCK)
	where Days Between 38 AND 56
	Group By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowServicesFallout38To56] TO [se\analysts]
    AS [dbo];

