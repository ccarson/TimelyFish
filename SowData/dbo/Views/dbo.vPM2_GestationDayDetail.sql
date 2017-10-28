CREATE VIEW vPM2_GestationDayDetail (FarmID, WeekOfDate, DayDate, SowID, SowGenetics, SowParity)
AS
select distinct se.farmid, dd.weekofdate, dd.daydate, se.sowid, se.sowgenetics, se.sowparity
	FROM SowGroupEventTemp se WITH (NOLOCK) -- ESSENTIALLY LATEST GROUP EVENT BEFORE REQUESTED DATE
	CROSS JOIN DayDefinitionTemp  dd WITH (NOLOCK)
 	--JOIN DayDefinitionTemp  dd WITH (NOLOCK) ON se.EventDate=dd.DayDate
	JOIN SowTemp s  WITH (NOLOCK) on se.farmid = s.farmid and se.sowid = s.sowid
	LEFT JOIN SowPregExamEventTemp spee WITH (NOLOCK) ON spee.FarmID = se.FarmID
		AND spee.SowID = se.SowID
		AND spee.EventDate = (	--SELECT Last PregExam event
					SELECT Max(EventDate) FROM SowPregExamEventTemp WITH (NOLOCK)
					WHERE FarmID = se.FarmID
					AND SowID = se.SowID
					AND EventDate > se.EventDate  -- this would allow for sows with preg neg on same day as group event
					AND SowParity = se.SowParity)
		
	-- JOIN FOR FILTERING OUT SOWS WITH ABORTION OR NOT IN PIG AFTER MATE DATE
	LEFT JOIN SowFalloutEventTemp sfe WITH (NOLOCK) 
			ON sfe.FarmID = se.FarmID 
			and sfe.SowID = se.SowID
			AND sfe.EventDate >= se.EventDate
			AND sfe.SowParity = se.SowParity
	-- JOIN FOR FILTERING OUT SOWS THAT HAVE FARROWED BEFORE SELECTED DATE
	LEFT JOIN SowFarrowEventTemp sf WITH (NOLOCK) 
			ON
			sf.FarmID = se.FarmID 
			and sf.SowID = se.SowID
			AND sf.EventDate > se.EventDate
			AND sf.SowParity = se.SowParity + 1
			AND sf.EventDate < dd.daydate  -- FARROW DATE IS INCLUDED AS GESTATING DAY
	-- JOIN FOR FILTERING OUT SOWS THAT WERE REMOVED,CULLED,DIED WITHOUT FARROWING FROM THIS MATE
	LEFT JOIN SowRemoveEventTemp sre WITH (NOLOCK) 
			ON
			sre.FarmID = se.FarmID 
			and sre.SowID = se.SowID
			AND sre.EventDate >= dd.daydate
			AND sre.SowParity = se.SowParity
	-- JOIN FOR FILTERING OUT RECYCLES
	LEFT JOIN SowGroupEventTemp ge2 WITH (NOLOCK) 
			ON
			ge2.FarmID = se.FarmID 
			and ge2.SowID = se.SowID
			AND ge2.EventDate > dd.daydate
			AND ge2.SowParity = se.SowParity
	WHERE
	(s.RemovalDate is Null or s.RemovalDate > dd.daydate)
	AND s.EntryDate <= dd.daydate

	-- FILTER OUT SOWS WITH ABORTION OR NOT IN PIG AFTER MATE DATE
	AND sfe.SowID is null 
	-- FILTER OUT SOWS THAT HAVE FARROWED BEFORE SELECTED DATE
	AND sf.SowID is null
	-- FILTER OUT SOWS THAT WERE REMOVED,CULLED,DIED WITHOUT FARROWING FROM THIS MATE
	AND sre.SowID is Null
	-- FILTER OUT RECYCLES
	AND ge2.SowID is Null
	-- SELECT THE LATEST GROUP (MATING) EVENT ONLY
	AND se.EventDate = (Select Max(EventDate) FROM SowGroupEventTemp WITH (NOLOCK)
				WHERE FarmID = se.FarmID and SowID = se.SowID	
					--CHANGED BY CHARITY 5/16/2006
					--AND EventDate <= dd.daydate)	
					AND EventDate < dd.daydate)
	-- FILTER OUT SOWS THAT ARE past 115 days of gestation
	AND DATEDIFF (day,se.EventDate,dd.daydate ) < 116

	-- FILTER OUT SOWS WITH NEG RESULT IN PREG CHECK
	AND IsNull(spee.ExamResult,'') In ('POSITIVE','')

