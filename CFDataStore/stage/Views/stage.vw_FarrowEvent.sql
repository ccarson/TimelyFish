CREATE VIEW
	stage.vw_FarrowEvent
AS
SELECT
    FarrowEventKey		=	isnull( fe.FarrowEventKey, 0 )
  , ParityEventKey		=	pEvent.ParityEventKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), f.eventdate, 112 ) AS INT ) 
  , LocationKey			=	ISNULL( loc.LocationKey, -1 ) 
  , Liveborn			=	ISNULL( f.liveborn_gilts, 0 ) + ISNULL( f.liveborn_boars, 0 ) 
  , Stillborn      		=	f.stillborn
  , Mummified         	=	f.mummified
  , WasAssisted			=	f.assisted
  , WasInduced        	=	f.induced
  , WasSubstandard		=	CAST( ISNULL( f.substandard, 0 ) AS BIT )
  , SourceCode			=	CASE 
								WHEN f.MFGUID IS NOT NULL THEN N'MobileFrame / TIM' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	f.event_id
  , SourceGUID			=	f.SourceGUID

FROM 
    stage.EV_FARROWINGS AS f
INNER JOIN 
	dimension.Farm AS farm
		on farm.SourceID = f.site_id
INNER join 
	dimension.Animal AS a
		on a.SourceID = f.identity_id

LEFT OUTER JOIN 
	dimension.Location AS loc
		ON f.location_id = loc.SourceID
LEFT OUTER JOIN
	fact.FarrowEvent AS fe
		ON fe.SourceID = f.event_id
CROSS APPLY( 
	SELECT TOP 1 
		pe.ParityEventKey
	FROM 
		fact.ParityEvent AS pe 
	WHERE 
		pe.AnimalKey = a.AnimalKey
			AND cast( convert( varchar(08), f.eventdate, 112) as int ) = pe.ParityDateKey
			AND pe.DeletedDate IS NULL 

	ORDER BY
		pe.ParityNumber DESC ) AS pEvent
;                                                          