CREATE VIEW 
    stage.vw_FosterEvent 
AS
SELECT
	FosterEventKey		=	COALESCE( 
								fe.FosterEventKey
							  , CAST( 0 AS bigint ) )
  , ParityEventKey		=   pe.ParityEventKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), ev.eventdate, 112 ) AS int )
  , FosterQuantity		=	CAST( ISNULL( f.piglets, 0 ) AS tinyint )
  , SourceID			=	ev.event_id

FROM 
    stage.BH_EVENTS AS ev
INNER JOIN 
	stage.EV_FOSTERS AS f
		ON f.event_id = ev.event_id 
			AND f.identity_id = ev.identity_id
LEFT OUTER JOIN
	fact.FosterEvent AS fe
		ON fe.SourceID = f.event_id
CROSS APPLY( 
	SELECT TOP 1 
		ParityEventKey 
	FROM 
		fact.ParityEvent AS pe
	INNER JOIN 
		dimension.Animal AS a 
			ON a.AnimalKey = pe.AnimalKey 
	WHERE 
		a.SourceID = ev.identity_id
			AND CAST( CONVERT( varchar(08), ev.eventdate, 112 ) AS INT ) !< pe.ParityDateKey
	ORDER BY 
        pe.ParityNumber DESC ) AS pe
; 
	