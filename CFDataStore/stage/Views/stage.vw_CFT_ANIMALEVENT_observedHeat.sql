CREATE VIEW 
    [stage].[vw_CFT_ANIMALEVENT_observedHeat]
AS
SELECT
    ID              =   heat.SourceGUID
  , DELETED_BY		=	ISNULL( heat.DeletedBy, -1 )
  , ANIMALID		=	a.SourceGUID 
  , PARITYNUMBER    =	pe.ParityNumber   
  , EVENTTYPEID		=	eType.ID
  , EVENTDATE		=	eDate.FullDate
  , QTY				=	CAST( -1 AS INT )
  , EVENTTHDATE		=	eDate.PICCycleAndDay
  , SOURCEFARMID	=   farms.SourceGUID
  , REMOVALREASONID =   CAST( -1 AS int ) 
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   CAST( 1 AS int ) -- Assume animal is OPEN on OH
  , PIGCHAMP_ID		=	heat.SourceID
  

FROM 
    fact.ObservedHeatEvent AS heat
INNER JOIN 
	fact.ParityEvent AS pe
	ON pe.ParityEventKey = heat.ParityEventKey
INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = pe.AnimalKey
INNER JOIN 
	stage.ParityEvent AS peStage
		ON peStage.ParityEventKey = pe.ParityEventKey
INNER JOIN
	stage.CFT_EVENTTYPE AS eType
		ON eType.EVENTNAME = N'Observed Heat'
INNER JOIN
	dimension.Date AS eDate
		ON eDate.DateKey = heat.EventDateKey 
LEFT JOIN
	stage.BH_EVENTS_ALL as allEvents
		ON allEvents.event_id = heat.SourceID
LEFT JOIN 
	dimension.Farm as farms
		ON farms.SourceID = allEvents.site_id;		 
;