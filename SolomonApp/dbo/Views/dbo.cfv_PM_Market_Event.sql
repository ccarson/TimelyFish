



CREATE VIEW [dbo].[cfv_PM_Market_Event]
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
drc.TruckingCompanyName,
wd.PICWeek AS 'Week',
etdr.IDPMEvent AS 'DriverEventID',
CAST(evdr.Event_Value AS bit) AS 'DriverSig',
etgr.IDPMEvent AS 'GrowerEventID',
CAST(evgr.Event_Value AS bit) AS 'GrowerSig',
etsig.IDPMEvent AS 'SignatureEventID',
CAST(evsig.Event_Value AS bit) AS 'Sig',
ettqa.IDPMEvent AS 'TQAEventID',
evtqa.Event_Comment AS 'TQANbr',
etcom.IDPMEvent AS 'CommentEventID',
evcom.Event_Comment  AS 'Comment'
FROM cftPM pm (NOLOCK)
JOIN cftWeekDefinition wd (NOLOCK) ON pm.MovementDate between wd.WeekOfDate and wd.WeekEndDate
LEFT JOIN cftContact sc (NOLOCK) ON pm.SourceContactID = sc.ContactID
LEFT JOIN cftContact dc (NOLOCK) ON pm.DestContactID = dc.ContactID
LEFT JOIN cftContact trk (NOLOCK) ON pm.TruckerContactID = trk.ContactID
LEFT JOIN cfv_DriverCompany drc (NOLOCK) ON pm.TruckerContactID = drc.DriverContactID
LEFT JOIN cftPMEventType etgr (NOLOCK) ON etgr.Descr = 'Grower Signature'
LEFT JOIN cftPMEventType etdr (NOLOCK) ON etdr.Descr = 'Driver Signature'
LEFT JOIN cftPMEventType ettqa (NOLOCK) ON ettqa.Descr = 'TQA Number'
LEFT JOIN cftPMEventType etcom (NOLOCK) ON etcom.Descr = 'Comment'
LEFT JOIN cftPMEventType etsig (NOLOCK) ON etsig.Descr = 'Signature'
LEFT JOIN cftpmtransprecord pt (NOLOCK) ON pt.pmid = pm.pmid
LEFT JOIN cftPMEvents evdr (NOLOCK) ON pm.PMID = evdr.PMID AND evdr.EventID = etdr.IDPMEvent
LEFT JOIN cftPMEvents evgr (NOLOCK) ON pm.PMID = evgr.PMID AND evgr.EventID = etgr.IDPMEvent
LEFT JOIN cftPMEvents evtqa (NOLOCK) ON pm.PMID = evtqa.PMID AND evtqa.EventID = ettqa.IDPMEvent
LEFT JOIN cftPMEvents evcom (NOLOCK) ON pm.PMID = evcom.PMID AND evcom.EventID = etcom.IDPMEvent
LEFT JOIN cftPMEvents evsig (NOLOCK) ON pm.PMID = evsig.PMID AND evsig.EventID = etsig.IDPMEvent
WHERE pm.transubtypeid IN ('fm','tm','sm','so','wm','wo','io','fo','mo','gm','im','ho','go','no','bo','bm', 'hm', 'nm') 
and pm.transubtypeid NOT LIKE 'o%' AND highlight NOT IN ('255', '-65536')


