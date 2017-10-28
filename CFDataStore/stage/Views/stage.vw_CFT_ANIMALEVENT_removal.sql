CREATE VIEW 
    stage.vw_CFT_ANIMALEVENT_removal
AS
SELECT DISTINCT
    ID              =   removal.SourceGUID 
  , DELETED_BY		=	ISNULL( removal.DeletedBy, -1 )
  , ANIMALID		=	a.SourceGUID
  , PARITYNUMBER	=	pEvent.ParityNumber    
  , EVENTTYPEID		=	CAST( evType.MobileFrameValue AS nvarchar(36) ) 
  , EVENTDATE		=	eDate.FullDate
  , QTY				=	CAST( -1 AS INT )
  , EVENTTHDATE		=	eDate.PICCycleAndDay
  , SOURCEFARMID	=   farms.SourceGUID
  , REMOVALREASONID =   CAST( evReason.MobileFrameReasonID AS int ) 
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   CAST( 0 AS int )  -- Assume animal is REMOVED
  , PIGCHAMP_ID		=	removal.SourceID
  

FROM 
    fact.RemovalEvent AS removal
INNER JOIN 
	stage.FarmAnimal AS fAnimal
		ON fAnimal.FarmAnimalKey = removal.FarmAnimalKey
INNER JOIN 
    dimension.Animal AS a 
		ON a.AnimalKey = fAnimal.AnimalKey
INNER JOIN
	dbo.LookupCodes AS evType
        ON evType.LookupCodesKey = removal.RemovalTypeKey
INNER JOIN
	dbo.LookupCodes AS evReason
        ON evReason.LookupCodesKey = removal.RemovalReasonKey
INNER JOIN
	dimension.Date AS eDate
		ON eDate.DateKey = removal.EventDateKey
CROSS APPLY( 
	SELECT TOP 1 
		pe.ParityNumber
	FROM 
		fact.ParityEvent AS pe
	WHERE 
		pe.AnimalKey = fAnimal.AnimalKey
			AND removal.EventDateKey >= pe.ParityDateKey
			AND pe.DeletedDate IS NULL
	ORDER BY 
        pe.ParityDateKey DESC ) AS pEvent
LEFT JOIN
	stage.BH_EVENTS_ALL as allEvents
		ON allEvents.event_id = removal.SourceID
LEFT JOIN 
	dimension.Farm as farms
		ON farms.SourceID = allEvents.site_id;
;