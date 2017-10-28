CREATE VIEW vPM2_LactationDayDetail (FarmID, WeekOfDate, DayDate, SowID, SowGenetics, SowParity)
AS
SELECT distinct sfe.farmid, dd.weekofdate, dd.daydate, sfe.sowid, sfe.sowgenetics, sfe.sowparity
	FROM SowFarrowEventTemp sfe WITH (NOLOCK)
 	CROSS JOIN DayDefinitionTemp  dd WITH (NOLOCK)
	JOIN SowTemp s  WITH (NOLOCK) 
		ON
		sfe.farmid = s.farmid 
		and sfe.sowid = s.sowid
	--JOIN FOR FILTERING OUT SOWS THAT have weaned
	LEFT JOIN SowWeanEventTemp we WITH (NOLOCK)
		ON sfe.FarmID = we.FarmID 
		AND sfe.SowID = we.SowID
		AND sfe.SowParity = we.SowParity
		AND we.EventDate >= sfe.EventDate
		AND we.EventType = 'WEAN'
		AND we.EventDate < dd.DayDate
		AND we.SowID Not In
			(Select SowID From SowNurseEventTemp WITH (NOLOCK)
				WHERE FarmID = we.FarmID
				AND SowID = we.SowID
				AND SowParity = we.SowParity
				AND EventDate >= we.EventDate
				AND EventType = 'NURSE ON')
	--JOIN FOR FILTERING OUT SOWS THAT HAVE NURSED OFF
	LEFT JOIN SowNurseEventTemp ne WITH (NOLOCK)
		ON sfe.FarmID = ne.FarmID 
		AND sfe.SowID = ne.SowID
		AND sfe.SowParity = ne.SowParity
		AND ne.EventDate >= sfe.EventDate
		AND ne.EventType = 'NURSE OFF' 
		AND ne.EventDate < dd.DayDate
		AND ne.SowID Not In
			(Select SowID From SowNurseEventTemp WITH (NOLOCK)
				WHERE FarmID = ne.FarmID
				AND SowID = ne.SowID
				AND SowParity = ne.SowParity
				AND EventDate >= ne.EventDate
				AND EventType = 'NURSE ON') 
	WHERE
	sfe.EventDate < dd.daydate
	-- FILTER OUT SOWS THAT ARE past 42 days of gestation
	AND DATEDIFF (day,sfe.EventDate,dd.daydate ) < 43

	AND ne.SowID is null
	AND we.SowID is null
	AND (s.RemovalDate is Null or s.RemovalDate >= dd.daydate)
	AND s.EntryDate <= dd.daydate


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_LactationDayDetail] TO [se\analysts]
    AS [dbo];

