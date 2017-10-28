













CREATE PROCEDURE [dbo].[cfp_reload_SLF_KPI_remove]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
truncate table  dbo.cft_SLF_KPI_Sowqty

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
insert into cft_SLF_KPI_Sowqty
select s.farmid,wd.picyear_week,
sum(CASE (datediff(day, wd.WeekOfDate -1, RemovalDate))
			WHEN 1 THEN 1
			WHEN 2 THEN 2
			WHEN 3 THEN 3
			WHEN 4 THEN 4
			WHEN 5 THEN 5
			WHEN 6 THEN 6
			ELSE 7
			END
			-- Subtract any days from entry if entry after beginning of week
			- CASE 7-(datediff(day,s.EntryDate,wd.WeekEndDate))
				WHEN 1  THEN 1
				WHEN 2 THEN 2
				WHEN 3 THEN 3
				WHEN 4 THEN 4
				WHEN 5 THEN 5
				WHEN 6 THEN 6
				ELSE 0
				END 
) SowDays, count(1) sowqty
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo wd
left join earth.sowdata.dbo.Sow s
	on isnull(s.removaldate,wd.weekenddate) between wd.weekofdate and wd.weekenddate and wd.dayname = 'Saturday'
where picyear_week > '09wk01'
group by s.farmid,wd.picyear_week

--clear table for new data
truncate table  dbo.cft_SLF_KPI_farrow_wean_data

insert into cft_SLF_KPI_farrow_wean_data
  select F.farmid, F.weekofdate f_weekofdate, sum(qtybornalive) sumBA, sum(qtystillborn) sumSB, sum(qtymummy) sumM, sum(w.qty) sumWqty, avg(datediff(day,F.eventdate, W.eventdate)) avgage
  , max(w.weekofdate) w_weekofdate, sum(w.qty)*avg(datediff(day,F.eventdate, W.eventdate)) weandays, count(1) sowqty
  from earth.[SowData].[dbo].[SowfarrowEvent] F (nolock)
  join earth.[SowData].[dbo].[SowweanEvent] W (nolock)
	on w.farmid = f.farmid and w.sowid = f.sowid and w.sowparity = f.sowparity and w.qty > 0
 where f.eventdate > '2009-01-01'
  group by f.farmid, f.weekofdate

END


--clear table for new data
truncate table  dbo.cft_SLF_KPI_Gestation


insert into cft_SLF_KPI_Gestation
SELECT  se.farmid,wd.picyear_week, wd.weekofdate,count(1) gestdays
, count(1)/7 gestsowcnt
FROM earth.sowdatadbo.SowGroupEvent se WITH (NOLOCK) -- ESSENTIALLY LATEST GROUP EVENT BEFORE REQUESTED DATE
cross join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo wd
	JOIN earth.sowdata.dbo.Sow s  WITH (NOLOCK) on se.farmid = s.farmid and se.sowid = s.sowid
	LEFT JOIN earth.sowdata.dbo.SowPregExamEvent spee WITH (NOLOCK) ON spee.FarmID = se.FarmID
		AND spee.SowID = se.SowID
		AND spee.EventDate = (	--SELECT Last PregExam event
					SELECT Max(EventDate) FROM earth.sowdatadbo.SowPregExamEvent WITH (NOLOCK)
					WHERE FarmID = se.FarmID
					AND SowID = se.SowID
					AND EventDate > se.EventDate  -- this would allow for sows with preg neg on same day as group event
					AND SowParity = se.SowParity)
		
	-- JOIN FOR FILTERING OUT SOWS WITH ABORTION OR NOT IN PIG AFTER MATE DATE
	LEFT JOIN earth.sowdatadbo.SowFalloutEvent sfe WITH (NOLOCK) 
			ON sfe.FarmID = se.FarmID 
			and sfe.SowID = se.SowID
			AND sfe.EventDate >= se.EventDate
			AND sfe.SowParity = se.SowParity
	-- JOIN FOR FILTERING OUT SOWS THAT HAVE FARROWED BEFORE SELECTED DATE
	LEFT JOIN earth.sowdatadbo.SowFarrowEvent sf WITH (NOLOCK) 
			ON
			sf.FarmID = se.FarmID 
			and sf.SowID = se.SowID
			AND sf.EventDate > se.EventDate
			AND sf.SowParity = se.SowParity + 1
			AND sf.EventDate < wd.daydate  -- FARROW DATE IS INCLUDED AS GESTATING DAY
	-- JOIN FOR FILTERING OUT SOWS THAT WERE REMOVED,CULLED,DIED WITHOUT FARROWING FROM THIS MATE
	LEFT JOIN earth.sowdatadbo.SowRemoveEvent sre WITH (NOLOCK) 
			ON
			sre.FarmID = se.FarmID 
			and sre.SowID = se.SowID
			AND sre.EventDate >= wd.daydate
			AND sre.SowParity = se.SowParity
	-- JOIN FOR FILTERING OUT RECYCLES
	LEFT JOIN earth.sowdatadbo.SowGroupEvent ge2 WITH (NOLOCK) 
			ON
			ge2.FarmID = se.FarmID 
			and ge2.SowID = se.SowID
			AND ge2.EventDate > wd.daydate
			AND ge2.SowParity = se.SowParity
--	WHERE wd.picyear_week > '13wk01'
where se.eventdate > '2008-12-28 00:00:00'
	and (s.RemovalDate is Null or s.RemovalDate > wd.daydate)
	AND s.EntryDate <= wd.daydate

	-- FILTER OUT SOWS WITH ABORTION OR NOT IN PIG AFTER MATE DATE
	AND sfe.SowID is null 
	-- FILTER OUT SOWS THAT HAVE FARROWED BEFORE SELECTED DATE
	AND sf.SowID is null
	-- FILTER OUT SOWS THAT WERE REMOVED,CULLED,DIED WITHOUT FARROWING FROM THIS MATE
	AND sre.SowID is Null
	-- FILTER OUT RECYCLES
	AND ge2.SowID is Null
	-- SELECT THE LATEST GROUP (MATING) EVENT ONLY
	AND se.EventDate = (Select Max(EventDate) FROM earth.sowdatadbo.SowGroupEvent WITH (NOLOCK)
				WHERE FarmID = se.FarmID and SowID = se.SowID	
					--CHANGED BY CHARITY 5/16/2006
					--AND EventDate <= wd.daydate)	
					AND EventDate < wd.daydate)
	-- FILTER OUT SOWS THAT ARE past 115 days of gestation
	-- 20130626 smr changed 116 to 120 (pigchamp uses 119 days
	AND DATEDIFF (day,se.EventDate,wd.daydate ) < 120
	-- FILTER OUT SOWS WITH NEG RESULT IN PREG CHECK
	AND IsNull(spee.ExamResult,'') In ('POSITIVE','')
group by se.farmid,wd.picyear_week, wd.weekofdate





--clear table for new data
truncate table  dbo.cft_SLF_KPI_Lactation


insert into cft_SLF_KPI_Lactation
SELECT  sfe.farmid,dd.picyear_week, dd.weekofdate,count(1) lacdays
, count(1)/7 lacsowcnt
FROM earth.sowdatadbo.SowFarrowEvent sfe WITH (NOLOCK)
cross join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
JOIN earth.sowdatadbo.Sow s  WITH (NOLOCK) 
		ON sfe.farmid = s.farmid and sfe.sowid = s.sowid
--JOIN FOR FILTERING OUT SOWS THAT have weaned
LEFT JOIN earth.sowdatadbo.SowWeanEvent we WITH (NOLOCK)
	ON sfe.FarmID = we.FarmID 
	AND sfe.SowID = we.SowID
	AND sfe.SowParity = we.SowParity
	AND we.EventDate >= sfe.EventDate
	AND we.EventType = 'WEAN'
	AND we.EventDate < dd.DayDate
	AND we.SowID Not In
		(Select SowID From earth.sowdatadbo.SowNurseEvent WITH (NOLOCK)
			WHERE FarmID = we.FarmID
			AND SowID = we.SowID
			AND SowParity = we.SowParity
			AND EventDate >= we.EventDate
			AND EventType = 'NURSE ON')
--JOIN FOR FILTERING OUT SOWS THAT HAVE NURSED OFF
LEFT JOIN earth.sowdatadbo.SowNurseEvent ne WITH (NOLOCK)
	ON sfe.FarmID = ne.FarmID 
	AND sfe.SowID = ne.SowID
	AND sfe.SowParity = ne.SowParity
	AND ne.EventDate >= sfe.EventDate
	AND ne.EventType = 'NURSE OFF' 
	AND ne.EventDate < dd.DayDate
	AND ne.SowID Not In
		(Select SowID From earth.sowdatadbo.SowNurseEvent WITH (NOLOCK)
			WHERE FarmID = ne.FarmID
			AND SowID = ne.SowID
			AND SowParity = ne.SowParity
			AND EventDate >= ne.EventDate
			AND EventType = 'NURSE ON') 
where sfe.eventdate > '2008-12-28 00:00:00'
and sfe.EventDate < dd.daydate
-- FILTER OUT SOWS THAT ARE past 42 days of gestation
AND DATEDIFF (day,sfe.EventDate,dd.daydate ) < 43
AND ne.SowID is null
AND we.SowID is null
AND (s.RemovalDate is Null or s.RemovalDate >= dd.daydate)
AND s.EntryDate <= dd.daydate
group by sfe.farmid,dd.picyear_week, dd.weekofdate

--clear table for new data
--clear table for new data
truncate table  dbo.cft_SLF_KPI_AvgLactDays

insert into  dbo.cft_SLF_KPI_AvgLactDays
select swe.farmid, dd.picyear_week, swe.weekofdate
, avg(datediff(day,sfe.eventdate, swe.eventdate)) avglactdays
, count(1) sowcnt
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
join earth.sowdatadbo.SowweanEvent swe WITH (NOLOCK)	-- sows that have weaned during the time interval
	on swe.eventdate = dd.daydate
join earth.sowdatadbo.SowFarrowEvent sfe WITH (NOLOCK)	-- sows that have farrowed 
	on sfe.farmid = swe.farmid and sfe.sowid = swe.sowid and sfe.sowparity = swe.sowparity
where dd.picyear_week > '09wk01'
group by swe.farmid, dd.picyear_week, swe.weekofdate

--clear table for new data
truncate table  dbo.cft_SLF_KPI_AvgGestDays

insert into  dbo.cft_SLF_KPI_AvgGestDays
select sfe.farmid, dd.picyear_week, sfe.weekofdate
, avg(datediff(day,sme.eventdate, sfe.eventdate)) avggestdays
, count(1) sowcnt
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
join earth.sowdatadbo.SowFarrowEvent sfe WITH (NOLOCK)	-- sows that have farrowed 
	on sfe.eventdate = dd.daydate
join (select farmid, sowid, sowparity, min(eventdate) eventdate from earth.sowdatadbo.SowmatingEvent (nolock) group by farmid, sowid, sowparity) sme -- sows that were mated
	on sme.farmid = sfe.farmid and sme.sowid = sfe.sowid and sme.sowparity = sfe.sowparity - 1
where dd.picyear_week > '09wk01'
group by sfe.farmid, dd.picyear_week, sfe.weekofdate





