CREATE VIEW 
    [stage].[vw_CFT_ANIMALEVENT_arrival]
AS
SELECT
    ID              =   arrival.SourceGUID
  , DELETED_BY		=	ISNULL( arrival.DeletedBy, -1 )
  , ANIMALID		=	a.SourceGUID
  , PARITYNUMBER	=	pEvent.ParityNumber   
  , EVENTTYPEID		=	eType.ID
  , EVENTDATE		=	eDate.FullDate
  , QTY				=	CAST( -1 AS INT )
  , EVENTTHDATE		=	eDate.PICCycleAndDay
  , SOURCEFARMID	=   farms.SourceGUID
  , REMOVALREASONID =   CAST( -1 AS int ) 
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   CAST( 1 AS int )  -- Assume animal is OPEN on Arrival
  , PIGCHAMP_ID		=	arrival.SourceID

FROM 
    fact.ArrivalEvent AS arrival
INNER JOIN 
	dimension.FarmAnimal AS fAnimal
		ON fAnimal.FarmAnimalKey = arrival.FarmAnimalKey
INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = fAnimal.AnimalKey
INNER JOIN 
	fact.ParityEvent AS pEvent
		ON pEvent.AnimalKey = fAnimal.AnimalKey
			AND arrival.SourceID = pEvent.SourceID
			AND pEvent.DeletedDate IS NULL
INNER JOIN
	stage.CFT_EVENTTYPE AS eType
		ON eType.EVENTNAME = N'ARRIVAL'
INNER JOIN 
	dimension.Date AS eDate
		ON eDate.DateKey = arrival.EventDateKey
INNER JOIN 
	stage.ArrivalEvent AS stage
		ON stage.ArrivalEventKey = arrival.ArrivalEventKey
LEFT JOIN
	stage.BH_EVENTS_ALL as allEvents
		ON allEvents.event_id = arrival.SourceID
LEFT JOIN 
	dimension.Farm as farms
		ON farms.SourceID = allEvents.site_id
;