





CREATE VIEW [dbo].[cfv_PM_Transportation_Event]
AS
SELECT
pm.PMLoadID, 
pm.PMID,
SC.ContactName AS Origin,
pm.SourcePigGroupID,
pm.SourceBarnNbr,
pm.EstimatedQty,
pm.MovementDate,
pm.LoadingTime,
pm.ArrivalDate,
pm.ArrivalTime,
DC.ContactName AS Dest,
pm.TranSubTypeID,
trk.ContactName AS TruckerName,
CAST(trk.ContactID as int) AS TruckerContactID,
vdc.TruckingCompanyContactID,
wd.PICWeek AS 'Week'
FROM cftPM pm (NOLOCK)
JOIN cftContact sc (NOLOCK) ON pm.SourceContactID = sc.ContactID
JOIN cftContact dc (NOLOCK) ON pm.DestContactID = dc.ContactID
JOIN cftContact trk (NOLOCK) ON pm.TruckerContactID = trk.ContactID
JOIN cftWeekDefinition wd (NOLOCK) ON pm.MovementDate between wd.WeekOfDate and wd.WeekEndDate
LEFT JOIN cfv_DriverCompany vdc (NOLOCK) ON pm.TruckerContactID = vdc.DriverContactID
Where (PM.Highlight <> 255 and PM.Highlight <> -65536)
AND pm.PMTypeID = '02'





