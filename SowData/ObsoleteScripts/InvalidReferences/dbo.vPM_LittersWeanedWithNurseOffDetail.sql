CREATE VIEW [dbo].[vPM_LittersWeanedWithNurseOffDetail] (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics)
	AS
	SELECT * FROM dbo.vPM_LittersWeanedDetail
	UNION 
	SELECT FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics
	FROM dbo.SowNurseEvent s WHERE EventType = 'NURSE OFF'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_LittersWeanedWithNurseOffDetail] TO [se\analysts]
    AS [dbo];

