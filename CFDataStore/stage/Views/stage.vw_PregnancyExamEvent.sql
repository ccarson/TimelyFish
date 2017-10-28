CREATE VIEW 
    stage.vw_PregnancyExamEvent 
AS
SELECT
	PregnancyExamEventKey	=	isnull( examEvent.PregnancyExamEventKey, 0 )
  , ParityEventKey			=   pEvent.ParityEventKey
  , EventDateKey			=	CAST( CONVERT( varchar(08), exam.eventdate, 112 ) AS int )
  , IsPositive				=	CAST( 
									CASE exam.result 
										WHEN '+' THEN 1 
										ELSE 0 
									END AS bit )
  , SourceCode				=	CASE 
									WHEN exam.MFGUID IS NOT NULL THEN N'MobileFrame / TIM' 
									ELSE 'PigCHAMP'
								END
  , SourceID				=	exam.event_id
  , SourceGUID				=	exam.SourceGUID

FROM 
	stage.EV_PREG_CHECKS AS exam
LEFT OUTER JOIN
	fact.PregnancyExamEvent AS examEvent
		ON examEvent.SourceID = exam.event_id
CROSS APPLY( 
	SELECT TOP 1 
		ParityEventKey 
	FROM 
		fact.ParityEvent AS pe
	
	INNER JOIN
		dimension.Animal AS a
			ON a.AnimalKey = pe.AnimalKey 
	WHERE 
		a.SourceID = exam.identity_id
			AND CAST( CONVERT( varchar(08), exam.eventdate, 112 ) AS INT ) >= pe.ParityDateKey
			AND pe.DeletedDate IS NULL
	ORDER BY 
        pe.ParityNumber DESC ) AS pEvent
;	