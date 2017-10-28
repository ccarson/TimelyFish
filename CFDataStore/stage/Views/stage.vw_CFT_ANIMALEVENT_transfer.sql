CREATE VIEW 
    [stage].[vw_CFT_ANIMALEVENT_transfer]
AS
SELECT
	ID	=	ISNULL( xfer.SourceGUID, 0 )
   , ANIMALID		=	a.SourceGUID
   , PARITYNUMBER	=	pe.ParityNumber 
  , EVENTTYPEID		=	CASE
							WHEN xfer.event_type = 294 Then (Select top 1 ID from stage.CFT_EVENTTYPE eType Where eType.EVENTNAME =N'Transfer On')
							WHEN xfer.event_type = 295 Then (Select top 1 ID from stage.CFT_EVENTTYPE eType Where eType.EVENTNAME =N'Transfer Off')
						END 
  , EVENTDATE      =	xfer.eventdate
  , EVENTTHDATE    =	eDate.PICCycleAndDay
  , SOURCEFARMID   =	f.SourceGUID
  
  , SYNCSTATUS		=	N'Valid'
  , MFSYNC			=	N'Y'
  , ANIMALSTATUS    =   CASE 
							WHEN xfer.event_type = 294 Then CAST( 1 AS int )  -- Assume animal is OPEN on Arrival
							WHEN xfer.event_type = 295 Then CAST( 0 AS int )  -- Assume animal is Removed
							ELSE CAST( 1 AS int )  -- Assume animal is OPEN
						END 
  , PIGCHAMP_ID		=	xfer.event_id


FROM 
	stage.EV_TRANSFERS AS xfer
INNER JOIN 
	dimension.Animal AS a 
		ON a.SourceID = xfer.identity_id
INNER JOIN 
	dimension.Farm AS f
		ON f.SourceID = xfer.site_id 
INNER JOIN 
	dimension.FarmAnimal AS fa 
		ON fa.AnimalKey = a.AnimalKey
			AND fa.FarmKey = f.FarmKey
INNER JOIN 
	dimension.Date AS eDate
		ON eDate.FullDate = xfer.EventDate

CROSS APPLY( 
	SELECT TOP 1 
		ParityNumber 
	FROM 
		fact.ParityEvent AS pe
	
	INNER JOIN 
		dimension.Animal AS a 
			ON a.AnimalKey = pe.AnimalKey 
	WHERE 
		a.SourceID = xfer.identity_id
			AND CAST( CONVERT( varchar(08), xfer.eventdate, 112 ) AS INT ) >= pe.ParityDateKey
	ORDER BY 
        pe.ParityNumber DESC ) AS pe

	Group by
	xfer.SourceGUID,pe.ParityNumber ,a.SourceGUID,xfer.eventdate,xfer.event_type,eDate.PICCycleAndDay,f.SourceGUID,xfer.event_id
; 
