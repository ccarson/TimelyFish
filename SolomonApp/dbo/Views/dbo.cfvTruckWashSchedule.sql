CREATE     VIEW dbo.cfvTruckWashSchedule
AS

--*************************************************************
--	Purpose: Truck Wash Weekly Schedule
--	Author: Eric Lind
--	Date: 4/19/2005
--	Usage: Truck Wash Weekly Schedule Report
--	Parameters: (None)
--*************************************************************

SELECT DISTINCT
	cw.ContactName,pm.CpnyID,
	pm.MovementDate,
	min(pm.LoadingTime)
	AS MinLoadTime,
	max(cd.ContactName) As LastDest,
	max(ct.ContactName) As Trucker,
	max(pt.Description) As Trailer,
	
	(Select MAX(ArrivalTime)  FROM cftPM pm2
		WHERE pm2.PigTrailerID = pm.PigTrailerID
		AND pm2.MovementDate = pm.MovementDate)
	AS MaxTime,
	max(mm.OneWayHours) As OneWayHours,
	max(ms.OneWayHours) as StartOneWayHours
	

FROM cftPM pm
JOIN cftPigTrailer pt ON pt.PigTrailerID = pm.PigTrailerID
JOIN cftContact cw ON cw.ContactID = pt.TrailerWashContactID
JOIN vCFContactMilesMatrix mm ON mm.SourceSite = pt.TrailerWashContactID
	AND mm.DestSite = pm.DestContactID
JOIN vCFContactMilesMatrix ms ON ms.SourceSite = pm.SourceContactID
	AND ms.DestSite =  pt.TrailerWashContactID
JOIN cftContact ct ON ct.ContactID = pm.TruckerContactID
JOIN cftContact cd ON cd.ContactID = pm.DestContactID

WHERE 
--pm.MovementDate BETWEEN '5/1/2005' AND '5/7/2005' and 
pm.TrailerWashFlag=-1

GROUP BY pm.CpnyID,cw.ContactName, pm.MovementDate, pm.PMLoadID,pm.PigTrailerID

--ORDER BY cw.ContactName, pm.MovementDate, pm.MaxTime
 






