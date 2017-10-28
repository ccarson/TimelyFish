

CREATE PROC [dbo].[pcfTruckWashSchedule]
(@StartDate as varchar(10)
,@NumWeeks as int = Null)
AS

--*************************************************************
--    Purpose: Truck Wash Weekly Schedule
--    Author: Charity Anderson
--    Date: 5/18/2005
--    Usage: Truck Wash Weekly Schedule Report
--    Parameters: (StartDate)
-- 2014-01-13  smr original version (optimizer went insane, reworked proc to make it simplier for it)  caused the proc to suck up all the temp space and run long until no more temp space.
-- 2014-01-20  smr added the pigtypeid and estimated quantity as per user request.   they want to know how much wood chips to add to trailer as it goes out.
-- 2014-04-09  smr modified code to get the total of estimated quantity for the pmloadid, not just one of the loads within the global load
-- 2015-07-06  NJH Changed from using PigTrailerID in cftpm to Description in cftPigTrailer, so that they have more than 3 characters to use.
-- 2016-01-21  NJH Changed trucker to use ShortName instead of ContactName.
-- 2016-02-10  BMD Added in functionality to return an optional user selected number of weeks.
--*************************************************************
DECLARE @EndDate as smalldatetime
    -- BMD: Added in ability to select number of weeks worth of schedule to report on.
	if @NumWeeks is null
	Begin
		SET @EndDate=DateAdd(d,6,@StartDate)
	End
	Else
	Begin
		SET @EndDate=DateAdd(ww,@NumWeeks,@StartDate)
	End


select pm.pmloadid, pm.id, pm.cpnyid, pm.sourcecontactid, pm.movementdate, pm.pigtrailerid, pm.loadingtime,
      pn.DestContactID ,
      pn.TruckerContactID,
      pn.ArrivalTime as MaxTime,
      pm.pigtypeid, pm.estimatedqty
into #pm
from cftpm pm (nolock)
JOIN cftPM pn WITH (NOLOCK) on 
      pn.ID=dbo.fxnGetLastLoad(pm.PigTrailerID,pm.MovementDate,pm.LoadingTime)
where pm.TrailerWashFlag<>0
and pm.MovementDate between @StartDate and @EndDate
and(pm.Highlight <> 255 and pm.Highlight <> -65536)

-- 20140409 get total estimated quantity for the pmloadid
select pm.pmloadid, sum(pm.estimatedqty) sumqty
into #pmqty
from cftpm pm (nolock)
where pm.MovementDate between @StartDate and @EndDate
and(pm.Highlight <> 255 and pm.Highlight <> -65536)
group by pm.pmloadid





Select Distinct
      pm.CpnyID,
      pm.SourceContactID,
      pm.MovementDate,
      pt.Description AS PigTrailerID,                 -- REPORTS-2286 2015-07-06 Changed from PigTrailerID to Description    NJH
      pm.LoadingTime AS MinLoadTime,
      pm.DestContactID ,
      pm.TruckerContactID,
      pm.MaxTime,
      cw.ContactName,
      cd.ContactName As LastDest,
      ct.ShortName As Trucker,
      pt.Description As Trailer,
      mm.OneWayHours As OneWayHours,
      ms.OneWayHours as StartOneWayHours,
      ptype.[PigTypeDesc]
      , pmqty.sumqty as estimatedqty            --  20140409 replaced this , pm.estimatedqty
from #pm pm
join #pmqty pmqty on pmqty.pmloadid = pm.pmloadid     --  20140409 added this 
JOIN cftPigTrailer pt WITH (NOLOCK) on pm.PigTrailerID=pt.PigTrailerID and pt.TruckWashFlag<>0
JOIN cftContact cw WITH (NOLOCK) ON cw.ContactID = pt.TrailerWashContactID
JOIN dbo.cftContactAddress caTW WITH (NOLOCK) on caTW.contactid = pt.TrailerWashContactID and caTW.AddressTypeID='01'
JOIN dbo.cftContactAddress caD WITH (NOLOCK) on caD.contactid = pm.destcontactid and caD.AddressTypeID='01'
JOIN dbo.cftContactAddress caS WITH (NOLOCK) on caS.contactid = pm.SourceContactID and caD.AddressTypeID='01'
JOIN dbo.cftMilesMatrix mm WITH (NOLOCK) ON  mm.AddressIDFrom = caTW.AddressID
      AND mm.AddressIDTo = caD.AddressID
JOIN dbo.cftMilesMatrix ms WITH (NOLOCK) ON ms.AddressIDFrom = caS.AddressID
      AND ms.AddressIDTo = caTW.AddressID
JOIN cftContact ct WITH (NOLOCK) ON ct.ContactID = pm.TruckerContactID
JOIN cftContact cd WITH (NOLOCK) ON cd.ContactID = isnull(caD.contactid,0)
join [SolomonApp].[dbo].[cftPigType] ptype (nolock)   on ptype.[PigTypeID] = pm.[PigTypeID]


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pcfTruckWashSchedule] TO PUBLIC
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pcfTruckWashSchedule] TO [MSDSL]
    AS [dbo];

