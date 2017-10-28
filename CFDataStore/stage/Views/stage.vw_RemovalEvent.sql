CREATE VIEW 
    stage.vw_RemovalEvent 
AS
SELECT
	RemovalEventKey		=	isnull( re.RemovalEventKey, 0 )
  , FarmAnimalKey		=	fa.FarmAnimalKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), ev.eventdate, 112 ) AS INT ) 
  , RemovalTypeKey		=	CASE 
								WHEN ev.destroyed > 0 THEN euth.LookupCodesKey
								ELSE death.LookupCodesKey
							END
  , RemovalReasonKey	=	reason.LookupCodesKey
  , SourceCode			=	CASE 
								WHEN ev.MFGUID IS NOT NULL THEN N'MobileFrame / TIM' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	ev.event_id
  , SourceGUID			=	ev.SourceGUID

FROM 
	stage.EV_DEATHS AS ev
INNER JOIN 
	dimension.Animal AS a 
		ON a.SourceID = ev.identity_id
INNER JOIN 
	dimension.Farm AS f 
		ON f.SourceID = ev.site_id
INNER JOIN 
	dimension.FarmAnimal AS fa
		ON fa.AnimalKey = a.AnimalKey
			AND fa.FarmKey = f.FarmKey
INNER JOIN
	dbo.LookupCodes AS death 
		ON death.LookupCodesDescription = 'Death'
INNER JOIN
	dbo.LookupCodes AS euth 
		ON euth.LookupCodesDescription = 'Euth'

OUTER APPLY dbo.tvf_GetLookupCodesFromPigChamp( 'Removal Reason', ev.death_reason_id ) AS reason

LEFT OUTER JOIN
	fact.RemovalEvent AS re
		ON re.SourceID = ev.event_id

; 
	
	