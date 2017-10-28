

CREATE  PROC [dbo].[pcfTruckWashSchedule_restrict]
 (@StartDate as varchar(10))
AS

--*************************************************************
--	Purpose: Truck Wash Weekly Schedule
--	Author: Charity Anderson
--	Date: 5/18/2005
--	Usage: Truck Wash Weekly Schedule Report
--	Parameters: (StartDate)
--*************************************************************
DECLARE @EndDate as smalldatetime
SET @EndDate=DateAdd(d,6,@StartDate)

Select Distinct
	pm.CpnyID,
	pm.SourceContactID,
	pm.MovementDate,
	pm.PigTrailerID,
	pm.LoadingTime AS MinLoadTime,
	pn.DestContactID ,
	pn.TruckerContactID,
	pn.ArrivalTime as MaxTime,
	cw.ContactName,
	cd.ContactName As LastDest,
	ct.ContactName As Trucker,
	pt.Description As Trailer,
	mm.OneWayHours As OneWayHours,
	ms.OneWayHours as StartOneWayHours
	
	
FROM cftPM pm WITH (NOLOCK)

JOIN 
cftPM pn WITH (NOLOCK) on 
pm.TrailerWashFlag<>0
and pm.MovementDate between @StartDate and @EndDate
and(pm.Highlight <> 255 and pm.Highlight <> -65536)
and pn.ID=dbo.fxnGetLastLoad(pm.PigTrailerID,pm.MovementDate,pm.LoadingTime)

JOIN cftPigTrailer pt WITH (NOLOCK) on pm.PigTrailerID=pt.PigTrailerID and pt.TruckWashFlag<>0
JOIN cftContact cw WITH (NOLOCK) ON cw.ContactID = pt.TrailerWashContactID
JOIN vCFContactMilesMatrix mm WITH (NOLOCK) ON mm.SourceSite = pt.TrailerWashContactID
	AND mm.DestSite = 
	(Select DestContactID from cftPM where ID=dbo.fxnGetLastLoad(pm.PigTrailerID,pm.MovementDate,pm.LoadingTime))
--isnull(pm.DestContactID,0)
JOIN vCFContactMilesMatrix ms WITH (NOLOCK) ON ms.SourceSite = pm.SourceContactID
	AND ms.DestSite =  pt.TrailerWashContactID
JOIN cftContact ct WITH (NOLOCK) ON ct.ContactID = pn.TruckerContactID
--(Select TruckerContactID from cftPM where ID=dbo.fxnGetLastLoad(pm.PigTrailerID,pm.MovementDate,pm.LoadingTime))
JOIN cftContact cd WITH (NOLOCK) ON cd.ContactID = isnull(mm.DestSite,0)







GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pcfTruckWashSchedule_restrict] TO PUBLIC
    AS [dbo];

