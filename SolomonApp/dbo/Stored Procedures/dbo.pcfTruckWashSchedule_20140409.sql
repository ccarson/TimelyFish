







CREATE  PROC [dbo].[pcfTruckWashSchedule_20140409]
 (@StartDate as varchar(10))
AS

--*************************************************************
--	Purpose: Truck Wash Weekly Schedule
--	Author: Charity Anderson
--	Date: 5/18/2005
--	Usage: Truck Wash Weekly Schedule Report
--	Parameters: (StartDate)
-- 2014-01-13  smr original version (optimizer went insane, reworked proc to make it simplier for it)  caused the proc to suck up all the temp space and run long until no more temp space.
-- 2014-01-20  smr added the pigtypeid and estimated quantity as per user request.   they want to know how much wood chips to add to trailer as it goes out.
--*************************************************************
DECLARE @EndDate as smalldatetime
--SET @EndDate=DateAdd(d,1,@StartDate)
SET @EndDate=DateAdd(d,6,@StartDate)


select pm.id, pm.cpnyid, pm.sourcecontactid, pm.movementdate, pm.pigtrailerid, pm.loadingtime,
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


Select Distinct
	pm.CpnyID,
	pm.SourceContactID,
	pm.MovementDate,
	pm.PigTrailerID,
	pm.LoadingTime AS MinLoadTime,
	pm.DestContactID ,
	pm.TruckerContactID,
	pm.MaxTime,
	cw.ContactName,
	cd.ContactName As LastDest,
	ct.ContactName As Trucker,
	pt.Description As Trailer,
	mm.OneWayHours As OneWayHours,
	ms.OneWayHours as StartOneWayHours,
	ptype.[PigTypeDesc]
	, pm.estimatedqty
from #pm pm
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
join [SolomonApp].[dbo].[cftPigType] ptype (nolock)	on ptype.[PigTypeID] = pm.[PigTypeID]




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pcfTruckWashSchedule_20140409] TO [MSDSL]
    AS [dbo];

