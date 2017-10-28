CREATE VIEW 
    stage.vw_AnimalTag_primary
AS
SELECT
	AnimalTagKey		=	ISNULL( aTag.AnimalTagKey, 0 ) 
  , AnimalKey           =   a.AnimalKey
  , AnimalSourceGUID	=	a.SourceGUID
  , TagNumber			=	CAST( LTRIM( RTRIM( p.primary_identity ) ) AS nvarchar(20) ) 
  , TagDate				=	a.CreatedDate
  , IsPrimaryTag		=   CAST( 1 AS bit )
  , IsPrimaryTagINT		=   CAST( 1 AS int )
  , IsCurrentTag		=	CAST( 1 AS bit ) 
  , SourceID			=	p.identity_id
  , SourceGUID			=	p.SourceGUID
  , DeletedDate			=	p.deletion_date
  , DeletedBy			=	CAST(	CASE
										WHEN p.deletion_date IS NOT NULL THEN 0 
									END AS bigint )

FROM 
    stage.EV_PRIMARY_TAGS AS p
INNER JOIN 
	dimension.Animal AS a 
		ON a.SourceID = p.identity_id
LEFT OUTER JOIN 
	dimension.AnimalTag AS aTag 
		ON aTag.SourceID = p.identity_id
			AND aTag.IsPrimaryTag = 1

WHERE 
	p.is_current_site = 1
