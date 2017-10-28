CREATE VIEW 
    stage.vw_TransferEvent
AS
SELECT
	TransferEventKey	=	ISNULL( xEvent.TransferEventKey, 0 )
  , ArrivalEventKey		=	arrival.ArrivalEventKey 
  , RemovalEventKey		=	removal.RemovalEventKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), xfer.eventdate, 112 ) AS INT ) 
  , SourceCode			=	CASE 
								WHEN xfer.MFGUID IS NOT NULL THEN N'MobileFrame / TIM' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	xfer.event_id
  , SourceGUID			=	xfer.SourceGUID

FROM 
	stage.EV_TRANSFERS AS xfer
INNER JOIN 
	fact.ArrivalEvent AS arrival
		ON arrival.SourceID = xfer.event_id
INNER JOIN 
	fact.RemovalEvent AS removal
		ON removal.SourceID = xfer.other_event_id
LEFT OUTER JOIN
	fact.TransferEvent AS xEvent
		ON xEvent.SourceID = xfer.event_id 
; 
	