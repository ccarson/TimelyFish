CREATE VIEW 
    stage.vw_AnimalTag_alternate
AS
SELECT
	AnimalTagKey		=	ISNULL( aTag.AnimalTagKey, 0 ) 
  , AnimalKey           =   animal.AnimalKey
  , AnimalSourceGUID	=	animal.SourceGUID
  , TagNumber			=	CAST( a.tattoo AS nvarchar(20) ) 
  , TagDate				=	tag.ConvertedDatetime
  , IsPrimaryTag		=   CAST( 0 AS bit ) 
  , IsPrimaryTagINT		=   CAST( 0 AS int ) 
  , IsCurrentTag		=	CAST( 1 AS bit )
  , SourceID			=	a.identity_id
  , SourceGUID			=	a.SourceGUID

FROM 
    stage.EV_ALTERNATE_TAGS AS a
LEFT OUTER JOIN 
	dimension.AnimalTag AS aTag 
		ON aTag.SourceID = a.identity_id
			AND aTag.IsPrimaryTag = 0 
INNER JOIN 
	dimension.Animal AS animal
		ON animal.SourceID = a.identity_id
CROSS APPLY
	dimension.tvf_CentralTimeConverter( a.audit_date, N'To UTC' ) AS tag

;
