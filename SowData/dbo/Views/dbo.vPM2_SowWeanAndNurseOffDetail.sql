CREATE VIEW [vPM2_SowWeanAndNurseOffDetail]
	AS 
	SELECT s.FarmID, s.SowID, s.EventType, 
			EventDate = IsNull((SELECT Max(EventDate) FROM SowNurseEventTemp
			Where FarmID = s.FarmID
			AND SowID = s.SowID 
			AND SowParity = s.SowParity 
			AND EventDate > s.EventDate
			AND EventType = 'NURSE OFF'), s.EventDate),
			WeekOfDate = IsNull((SELECT Max(WeekOfDate) FROM SowNurseEventTemp WITH (NOLOCK)
			Where FarmID = s.FarmID
			AND SowID = s.SowID 
			AND SowParity = s.SowParity 
			AND EventDate > s.EventDate
			AND EventType = 'NURSE OFF'), s.WeekOfDate),
		s.SowGenetics, s.SowParity, s.Qty
	FROM SowWeanEventTemp s WITH (NOLOCK)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowWeanAndNurseOffDetail] TO [se\analysts]
    AS [dbo];

