CREATE VIEW 
    stage.vw_ObservedHeatEvent 
AS
SELECT
	ObservedHeatEventKey	=	isnull( oh.ObservedHeatEventKey, 0 )
  , ParityEventKey		=   pEvent.ParityEventKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), hd.eventdate, 112 ) AS int )
  , SourceCode			=	CASE 
								WHEN hd.MFGUID IS NOT NULL THEN N'MobileFrame / TIM' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	hd.event_id
  , SourceGUID			=	hd.SourceGUID 

FROM 
	stage.EV_HEAT_DETECTED AS hd
LEFT OUTER JOIN
	fact.ObservedHeatEvent AS oh
		ON oh.SourceID = hd.event_id
CROSS APPLY( 
	SELECT TOP 1 
		ParityEventKey 
	FROM 
		fact.ParityEvent AS pe
	INNER JOIN
		dimension.Animal AS a
			ON a.AnimalKey = pe.AnimalKey 
	WHERE 
		a.SourceID = hd.identity_id
			AND CAST( CONVERT( varchar(08), hd.eventdate, 112 ) AS INT ) >= pe.ParityDateKey
			AND pe.DeletedDate IS NULL
	ORDER BY 
        pe.ParityNumber DESC ) AS pEvent
; 