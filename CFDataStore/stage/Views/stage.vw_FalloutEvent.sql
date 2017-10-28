CREATE VIEW 
    stage.vw_FalloutEvent 
AS
SELECT
	FalloutEventKey		=	ISNULL( fe.FalloutEventKey, 0 )
  , ParityEventKey		=   pEvent.ParityEventKey
  , FalloutEventTypeKey	=	codes.LookupCodesKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), fallout.eventdate, 112 ) AS int )
  , SourceCode			=	CASE 
								WHEN fallout.MFGUID IS NULL THEN N'PigCHAMP'
								ELSE N'MobileFrame / TIM'
							END	
  , SourceID			=	fallout.event_id
  , SourceGUID			=	fallout.SourceGUID

FROM 
	stage.EV_ABORTIONS AS fallout
LEFT OUTER JOIN
	fact.FalloutEvent AS fe
		ON fe.SourceID = fallout.event_id
INNER JOIN 
	dbo.LookupCodes as codes
		ON codes.LookupCodesDescription = 'Abortion'
CROSS APPLY( 
	SELECT TOP 1 
		ParityEventKey 
	FROM 
		fact.ParityEvent AS pe
	INNER JOIN
		dimension.Animal AS a
			ON a.AnimalKey = pe.AnimalKey 
	WHERE 
		a.SourceID = fallout.identity_id
			
			AND CAST( CONVERT( varchar(08), fallout.eventdate, 112 ) AS INT ) >= pe.ParityDateKey
			AND pe.DeletedDate IS NULL
	ORDER BY 
        pe.ParityNumber DESC ) AS pEvent
; 