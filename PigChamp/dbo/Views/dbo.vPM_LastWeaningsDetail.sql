

CREATE VIEW [dbo].[vPM_LastWeaningsDetail]
	AS 
	SELECT s.FarmID, s.SowID, s.EventType, s.EventDate, s.WeekOfDate, s.SowGenetics, s.SowParity, s.Qty
	FROM caredata.cfv_SowWeanEvent s
	WHERE SowID Not In(SELECT Distinct SowID FROM caredata.cfv_SowNurseEvent 
				Where FarmID = s.FarmID 
				AND SowID = s.SowID 
				AND SowParity = s.SowParity 
				AND EventDate >=s.EventDate
				AND EventType = 'NURSE ON') -- exclude sows with follow-on NURSE ON event
	UNION
	SELECT FarmID, SowID, EventType, EventDate, WeekOfDate, SowGenetics, SowParity, Qty 
	FROM caredata.cfv_SowNurseEvent s WHERE s.EventType = 'NURSE OFF' 
		AND s.SowID Not In(SELECT Distinct SowID FROM caredata.cfv_SowNurseEvent 
			WHERE FarmID = s.FarmID
			AND SowID = s.SowID 
			AND SowParity = s.SowParity 
			AND EventDate > s.EventDate
			AND EventType = 'NURSE ON') -- exclude sows with follow-on NURSE ON event



