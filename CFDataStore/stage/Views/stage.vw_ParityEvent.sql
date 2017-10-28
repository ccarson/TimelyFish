CREATE VIEW 
    stage.vw_ParityEvent
AS
SELECT
	ParityEventKey		=	ISNULL( pEvent.ParityEventKey, 0 )
  , AnimalKey			=	a.AnimalKey
  , ParityNumber		=	stage.parity_number
  , ParityDateKey		=	CAST( CONVERT( varchar(08), stage.eventdate, 112 ) AS INT ) 
  , MatingGroupKey		=	CAST( null AS int ) 
  , SourceCode			=	CASE 
								WHEN stage.MobileFrameSourceGUID IS NOT NULL THEN N'MobileFrame / TIM'
								ELSE N'PigCHAMP'
							END
  , SourceID			=	stage.event_id
  , SourceGUID			=	COALESCE( stage.MobileFrameSourceGUID, stage.SourceGUID )

FROM 
    stage.EV_PARITY AS stage
INNER JOIN 
	dimension.Animal AS a 
		ON a.SourceID = stage.identity_id
LEFT OUTER JOIN
	fact.ParityEvent AS pEvent 
		ON pEvent.SourceID = stage.event_id
; 
	
	