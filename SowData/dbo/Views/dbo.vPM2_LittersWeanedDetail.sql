CREATE VIEW vPM2_LittersWeanedDetail (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics)
	AS
	Select FarmID, SowID, Min(WeekOfDate), Min(EventDate), SowParity, SowGenetics	
	FROM SowWeanEventTemp WITH (NOLOCK)
	WHERE EventType = 'WEAN'
	GROUP BY FarmID, SowID, SowParity, SowGenetics


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_LittersWeanedDetail] TO [se\analysts]
    AS [dbo];

