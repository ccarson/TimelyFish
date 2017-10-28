CREATE VIEW 
    stage.vw_NurseEvent 
AS
SELECT
	NurseEventKey		=	ISNULL( ne.NurseEventKey, 0 )
  , ParityEventKey		=   pe.ParityEventKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), nurse.eventdate, 112 ) AS int )
  , NurseQuantity		=	nurse.piglets_on
  , SourceCode			=	CASE 
								WHEN nurse.MFGUID IS NOT NULL THEN N'MobileFrame / TIM' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	nurse.event_id
  , SourceGUID			=	nurse.SourceGUID

FROM 
	stage.EV_NURSE_ON AS nurse
LEFT OUTER JOIN
	fact.NurseEvent AS ne
		ON ne.SourceID = nurse.event_id
CROSS APPLY( 
	SELECT TOP 1 
		ParityEventKey 
	FROM 
		fact.ParityEvent AS pe
	INNER JOIN
		dimension.Animal AS a
			ON a.AnimalKey = pe.AnimalKey 
	WHERE 
		a.SourceID = nurse.identity_id
			
			AND CAST( CONVERT( varchar(08), nurse.eventdate, 112 ) AS INT ) >= pe.ParityDateKey
			AND pe.DeletedDate IS NULL
	ORDER BY 
        pe.ParityNumber DESC ) AS pe
; 	
	