CREATE VIEW 
    stage.vw_FarmAnimal
AS
SELECT 
    FarmAnimalKey		=	ISNULL( fa.FarmAnimalKey, 0 )
  , AnimalKey           =   a.AnimalKey
  , AnimalSourceGUID	=	a.SourceGUID
  , FarmKey				=	f.FarmKey
  , FarmSourceGUID		=	f.SourceGUID
  , ArrivalDateKey		=	CAST( CONVERT( varchar(08), arrival.eventdate, 112 ) AS INT ) 
  , RemovalDateKey		=	CAST( CONVERT( varchar(08), COALESCE( removal.eventdate, sales.eventdate, xferOff.eventdate ), 112 ) AS INT ) 
  , EntrySourceID		=	arrival.event_id
  , EntrySourceGUID		=	COALESCE(factArrival.SourceGUID,  arrival.SourceGUID )
  , RemovalSourceID		=	COALESCE( removal.event_id, sales.event_id, xferOff.event_id )
  , RemovalSourceGUID	=	COALESCE( removal.SourceGUID, sales.SourceGUID, xferOff.SourceGUID )
  , SourceID			=	arrival.identity_id
  , SourceGUID			=	COALESCE(factArrival.SourceGUID,  arrival.SourceGUID )

FROM 
    stage.EV_ARRIVALS AS arrival
INNER JOIN 
	dimension.Animal AS a 
		ON a.SourceID = arrival.identity_id 
INNER JOIN 
	dimension.Farm AS f
		ON f.SourceID = arrival.site_id 
LEFT OUTER JOIN
	stage.EV_DEATHS AS removal
		ON removal.identity_id = a.SourceID
LEFT OUTER JOIN 
	stage.EV_SALES AS sales
		ON sales.identity_id = a.SourceID

OUTER APPLY (Select Top 1 eventdate,event_id,SourceGUID From stage.EV_TRANSFERS AS xferOff WITH (NOLOCK) Where
						 xferOff.identity_id = a.SourceID
			AND xferOff.site_id = arrival.site_id
			and xferOff.eventdate >= arrival.eventdate
			AND xferOff.event_type = 295
			order by xferOff.eventdate) xferOff

LEFT OUTER JOIN 
	dimension.FarmAnimal AS fa
		ON fa.AnimalKey = a.AnimalKey
			AND fa.FarmKey = f.FarmKey
			AND fa.EntryDateKey = CAST( CONVERT( varchar(08), arrival.eventdate, 112 ) AS INT ) 

LEFT OUTER JOIN 
	fact.ArrivalEvent as factArrival
	on factArrival.SourceID = arrival.event_id

Union

SELECT 
   FarmAnimalKey		=	ISNULL( fa.FarmAnimalKey, 0 )
   ,AnimalKey           =   a.AnimalKey
  , AnimalSourceGUID	=	a.SourceGUID
  , FarmKey				=	f.FarmKey
  , FarmSourceGUID		=	f.SourceGUID
  , ArrivalDateKey		=	CAST( CONVERT( varchar(08), arrival.eventdate, 112 ) AS INT ) 
  , RemovalDateKey		=	CAST( CONVERT( varchar(08), COALESCE( removal.eventdate, sales.eventdate, xferOff.eventdate ), 112 ) AS INT ) 
  , EntrySourceID		=	arrival.event_id
  , EntrySourceGUID		=	COALESCE(factTran.SourceGUID,  arrival.SourceGUID )
  , RemovalSourceID		=	COALESCE( removal.event_id, sales.event_id, xferOff.event_id )
  , RemovalSourceGUID	=	COALESCE( removal.SourceGUID, sales.SourceGUID, xferOff.SourceGUID )
  , SourceID			=	arrival.identity_id
  , SourceGUID			=	COALESCE(factTran.SourceGUID,  arrival.SourceGUID )

FROM 
    stage.EV_TRANSFERS AS arrival
INNER JOIN 
	dimension.Animal AS a 
		ON a.SourceID = arrival.identity_id 
INNER JOIN 
	dimension.Farm AS f
		ON f.SourceID = arrival.site_id 
LEFT OUTER JOIN
	stage.EV_DEATHS AS removal
		ON removal.identity_id = a.SourceID
LEFT OUTER JOIN 
	stage.EV_SALES AS sales
		ON sales.identity_id = a.SourceID

OUTER APPLY (Select Top 1 eventdate,event_id,SourceGUID From stage.EV_TRANSFERS AS xferOff WITH (NOLOCK) Where
						 xferOff.identity_id = a.SourceID
			AND xferOff.site_id = arrival.site_id
			and xferOff.eventdate >= arrival.eventdate
			AND xferOff.event_type = 295
			order by xferOff.eventdate) xferOff

LEFT OUTER JOIN 
	dimension.FarmAnimal AS fa
		ON fa.AnimalKey = a.AnimalKey
			AND fa.FarmKey = f.FarmKey
			AND fa.EntryDateKey = CAST( CONVERT( varchar(08), arrival.eventdate, 112 ) AS INT ) 


LEFT OUTER JOIN 
	fact.TransferEvent as factTran
	on factTran.SourceID = arrival.event_id

where arrival.event_type = 294

