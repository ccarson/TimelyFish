CREATE VIEW 
    stage.vw_SalesEvent 
AS
SELECT
	SalesEventKey		=	ISNULL( se.SalesEventKey, 0 )
  , FarmAnimalKey		=	fa.FarmAnimalKey
  , EventDateKey		=	CAST( CONVERT( varchar(08), sales.eventdate, 112 ) AS INT ) 
  , SalesTypeKey		=   cull.LookupCodesKey
  , SalesReasonKey		=   salesReason.LookupCodesKey
  , SourceCode			=	CASE 
								WHEN sales.MFGUID IS NOT NULL THEN N'MobileFrame / TIM' 
								ELSE 'PigCHAMP'
							END
  , SourceID			=	sales.event_id
  , SourceGUID			=	sales.SourceGUID

FROM 
	stage.EV_SALES AS sales
INNER JOIN 
	dimension.Animal AS a 
		ON a.SourceID = sales.identity_id
INNER JOIN 
	dimension.Farm AS f 
		ON f.SourceID = sales.site_id
INNER JOIN 
	dimension.FarmAnimal AS fa
		ON fa.AnimalKey = a.AnimalKey
			AND fa.FarmKey = f.FarmKey
LEFT OUTER JOIN
	fact.SalesEvent AS se
		ON se.SourceID = sales.event_id
INNER JOIN
	dbo.LookupCodes AS cull
		ON cull.LookupCodesDescription = 'Cull'
CROSS APPLY
	dbo.tvf_GetLookupCodesFromPigChamp( 'Removal Reason', sales.sale_reason_id ) AS salesReason
;
