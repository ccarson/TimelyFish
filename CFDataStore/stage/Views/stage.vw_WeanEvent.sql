CREATE VIEW 
    stage.vw_WeanEvent 
AS
SELECT
	WeanEventKey		=	ISNULL( we.WeanEventKey, 0 )
  , ParityEventKey		=   pEvent.ParityEventKey
  , WeanEventTypeKey	=   weanType.LookupCodesKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), wean.eventdate, 112 ) AS int )
  , WeanedQuantity		=	CAST( ISNULL( wean.weaned_boars, 0 ) + ISNULL( wean.weaned_gilts, 0 ) AS INT ) 
  , SourceCode			=	CASE 
								WHEN wean.MFGUID IS NOT NULL THEN N'MobileFrame / TIM' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	wean.event_id
  , SourceGUID			=	wean.SourceGUID

FROM 
	stage.EV_WEANINGS AS wean
LEFT OUTER JOIN
	fact.WeanEvent AS we
		ON we.SourceID = wean.event_id
CROSS APPLY( 
	SELECT TOP 1 
		ParityEventKey 
	FROM 
		fact.ParityEvent AS pe
	INNER JOIN
		dimension.Animal AS a
			ON a.AnimalKey = pe.AnimalKey 
	WHERE 
		a.SourceID = wean.identity_id
			AND CAST( CONVERT( varchar(08), wean.eventdate, 112 ) AS INT ) >= pe.ParityDateKey
			AND pe.DeletedDate IS NULL
	ORDER BY 
        pe.ParityNumber DESC ) AS pEvent
CROSS APPLY
	dbo.tvf_GetLookupCodesFromPigChamp( 'Wean Type', wean.event_type ) AS weanType
	
	