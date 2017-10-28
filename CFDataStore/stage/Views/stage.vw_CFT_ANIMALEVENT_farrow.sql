

CREATE VIEW 
    [stage].[vw_CFT_ANIMALEVENT_farrow]
AS
SELECT DISTINCT
    ID              =   fe.SourceGUID
  , DELETED_BY		=	ISNULL( fe.DeletedBy , -1 )
  , ANIMALID		=	a.SourceGUID
  , PARITYNUMBER	=	pEvent.ParityNumber
  , EVENTTYPEID		=	eType.ID    
  , EVENTDATE      =	ed.FullDate
  , EVENTTHDATE    =	ed.PICCycleAndDay
  , BORNALIVE       =	CAST( fe.Liveborn  AS int )
  , STILLBORN       =	CAST( fe.Stillborn AS int )
  , MUMMY           =	CAST( fe.Mummified AS int )
  , LOCATIONID		=	loc.SourceGUID
  , SOURCEFARMID	=   farms.SourceGUID
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   CAST( 3 AS int )  -- Assume animal is LACTATING on Farrow
  , PIGCHAMP_ID		=	fe.SourceID
FROM 
    fact.FarrowEvent AS fe 
INNER JOIN 
	fact.ParityEvent AS pEvent 
		ON pEvent.ParityEventKey = fe.ParityEventKey 
			AND pEvent.DeletedDate IS NULL
INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = pEvent.AnimalKey
INNER JOIN
	dimension.Date AS ed
		ON ed.DateKey = fe.EventDateKey
LEFT OUTER JOIN 
	dimension.Location AS loc 
		ON loc.LocationKey = fe.LocationKey
INNER JOIN 
	stage.FarrowEvent AS stage
		ON stage.FarrowEventKey = fe.FarrowEventKey
INNER JOIN
	stage.CFT_EVENTTYPE AS eType
		ON eType.EVENTNAME = N'Farrowing'

LEFT JOIN
	stage.BH_EVENTS_ALL as allEvents
		ON allEvents.event_id = fe.SourceID
LEFT JOIN 
	dimension.Farm as farms
		ON farms.SourceID = allEvents.site_id;
GO