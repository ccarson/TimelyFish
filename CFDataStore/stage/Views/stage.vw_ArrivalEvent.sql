CREATE VIEW 
    stage.vw_ArrivalEvent 
AS
SELECT
    ArrivalEventKey		=	ISNULL( ae.ArrivalEventKey, 0 )
  , FarmAnimalKey		=	fa.FarmAnimalKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), arrival.eventdate, 112 ) AS INT ) 
  , SourceCode			=	CASE 
								WHEN arrival.MobileFrameAnimalEventID IS NOT NULL THEN N'MobileFrame / TIM ' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	arrival.event_id
  , SourceGUID			=	arrival.SourceGUID 

FROM 
    stage.EV_ARRIVALS AS arrival
INNER JOIN 
	dimension.Animal AS a 
		ON a.SourceID = arrival.identity_id
INNER JOIN 
	dimension.Farm AS f
		ON f.SourceID = arrival.site_id 
INNER JOIN 
	dimension.FarmAnimal AS fa 
		ON fa.AnimalKey = a.AnimalKey
			AND fa.FarmKey = f.FarmKey
LEFT OUTER JOIN 
	fact.ArrivalEvent AS ae
		ON ae.SourceID = arrival.event_id

; 

