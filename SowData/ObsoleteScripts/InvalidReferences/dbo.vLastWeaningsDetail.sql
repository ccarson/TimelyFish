CREATE VIEW [dbo].[vLastWeaningsDetail]
	AS 
	SELECT s.FarmID, s.SowID, s.EventType, s.EventDate, s.WeekOfDate, s.SowGenetics, s.SowParity, s.Qty
	FROM dbo.SowWeanEventTemp s
	WHERE SowID Not In(SELECT Distinct SowID FROM dbo.SowNurseEvent 
				Where FarmID = s.FarmID 
				AND SowID = s.SowID 
				AND SowParity = s.SowParity 
				AND EventDate >=s.EventDate
				AND EventType = 'NURSE ON') -- exclude sows with follow-on NURSE ON event
	UNION
	SELECT FarmID, SowID, EventType, EventDate, WeekOfDate, SowGenetics, SowParity, Qty 
	FROM dbo.SowNurseEventTemp s WHERE s.EventType = 'NURSE OFF' 
		AND s.SowID Not In(SELECT Distinct SowID FROM dbo.SowNurseEvent 
			WHERE FarmID = s.FarmID
			AND SowID = s.SowID 
			AND SowParity = s.SowParity 
			AND EventDate > s.EventDate
			AND EventType = 'NURSE ON') -- exclude sows with follow-on NURSE ON event


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vLastWeaningsDetail] TO [se\analysts]
    AS [dbo];

