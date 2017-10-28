CREATE VIEW 
    stage.vw_MatingEvent 
AS
SELECT
	MatingEventKey		=	ISNULL( me.MatingEventKey, 0 )
  , ParityEventKey		=   pe.ParityEventKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), m.eventdate, 112 ) AS int )
  , MaleGeneticsKey		=	CAST( ISNULL( g.GeneticsKey, -1 ) AS bigint )
  , MatingGroupKey		=	CAST( ISNULL( mg.MatingGroupKey, -1 ) AS bigint )
  , ObserverKey			=	CAST( ISNULL( o.ObserverKey, -1 ) AS bigint ) 
  , TimeOfDayCode		=	CASE m.time_of_day 
								WHEN 'P' THEN 2 
								ELSE 1 
							END 
  , SourceCode			=	CASE 
								WHEN m.MFGUID IS NOT NULL THEN N'MobileFrame / TIM ' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	m.event_id
  , SourceGUID			=	m.SourceGUID

FROM 
	stage.EV_MATINGS AS m
INNER JOIN 
	stage.BH_EVENTS AS bhe
		ON bhe.event_id = m.event_id
INNER JOIN 
	dimension.Farm AS farm
		on farm.SourceID = m.site_id
OUTER APPLY( 
	SELECT TOP 1 
		mg.MatingGroupKey 
	FROM 
		dimension.MatingGroup AS mg
		where CAST( CONVERT( varchar(08), m.eventdate, 112 ) AS INT ) Between MG.StartDateKey and mg.EndDateKey) as mg
LEFT OUTER JOIN 
	stage.BH_IDENTITY_HISTORY AS bih 
		ON bih.identity_id = m.male_identity_id
OUTER APPLY(
SELECT TOP 1 
	g.GeneticsKey
	FROM
		dimension.Genetics AS g 
		Where g.GeneticsName = bih.primary_identity COLLATE SQL_Latin1_General_CP1_CS_AS) as g
LEFT OUTER JOIN 
	dimension.Observer AS o 
		ON o.SourceID = m.supervisor_id
LEFT OUTER JOIN
	fact.MatingEvent AS me
		ON me.SourceID = m.event_id
CROSS APPLY( 
	SELECT TOP 1 
		ParityEventKey 
	FROM 
		fact.ParityEvent AS pe
	
	INNER JOIN 
		dimension.Animal AS a 
			ON a.AnimalKey = pe.AnimalKey 
	WHERE 
		a.SourceID = bhe.identity_id
			AND CAST( CONVERT( varchar(08), m.eventdate, 112 ) AS INT ) >= pe.ParityDateKey
	ORDER BY 
        pe.ParityNumber DESC ) AS pe
;
	
	