CREATE VIEW [dbo].[vPM_SowWeanAndNurseOffDetail]
	AS 
	SELECT s.FarmID, s.SowID, s.EventType, 
			EventDate = IsNull((SELECT Max(EventDate) FROM dbo.SowNurseEvent
			Where FarmID = s.FarmID
			AND SowID = s.SowID 
			AND SowParity = s.SowParity 
			AND EventDate > s.EventDate
			AND EventType = 'NURSE OFF'), s.EventDate),
			WeekOfDate = IsNull((SELECT Max(WeekOfDate) FROM dbo.SowNurseEvent
			Where FarmID = s.FarmID
			AND SowID = s.SowID 
			AND SowParity = s.SowParity 
			AND EventDate > s.EventDate
			AND EventType = 'NURSE OFF'), s.WeekOfDate),
		s.SowGenetics, s.SowParity, s.Qty
	FROM dbo.SowWeanEvent s

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_SowWeanAndNurseOffDetail] TO [se\analysts]
    AS [dbo];

