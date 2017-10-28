CREATE VIEW [vPM2_LastWeaningsDetail]
	AS 
	SELECT s.FarmID, s.SowID, s.EventType, s.EventDate, s.WeekOfDate, s.SowGenetics, s.SowParity, s.Qty
	FROM SowWeanEventTemp s WITH (NOLOCK)
	WHERE SowID Not In(SELECT Distinct SowID FROM SowNurseEventTemp WITH (NOLOCK) 
				Where FarmID = s.FarmID 
				AND SowID = s.SowID 
				AND SowParity = s.SowParity 
				AND EventDate >=s.EventDate
				AND EventType = 'NURSE ON') -- exclude sows with follow-on NURSE ON event
	UNION
	SELECT FarmID, SowID, EventType, EventDate, WeekOfDate, SowGenetics, SowParity, Qty 
	FROM SowNurseEventTemp s WITH (NOLOCK) WHERE s.EventType = 'NURSE OFF' 
		AND s.SowID Not In(SELECT Distinct SowID FROM SowNurseEventTemp WITH (NOLOCK) 
			WHERE FarmID = s.FarmID
			AND SowID = s.SowID 
			AND SowParity = s.SowParity 
			AND EventDate > s.EventDate
			AND EventType = 'NURSE ON') -- exclude sows with follow-on NURSE ON event

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_LastWeaningsDetail] TO [se\analysts]
    AS [dbo];

