CREATE VIEW [vPM2_LittersWeanedWithNurseOffDetail] (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics)
	AS
	SELECT * FROM vPM2_LittersWeanedDetail WITH (NOLOCK)
	UNION 
	SELECT FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics
	FROM SowNurseEventTemp s WITH (NOLOCK) 
	WHERE EventType = 'NURSE OFF'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_LittersWeanedWithNurseOffDetail] TO [se\analysts]
    AS [dbo];

