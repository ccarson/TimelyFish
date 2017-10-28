
CREATE VIEW 
    [stage].[vw_CFT_ANIMALTAG]
AS
SELECT
    ID              =   CAST( aTag.SourceGUID AS nvarchar(36) ) 
  , ANIMALID		=	CAST( a.SourceGUID AS nvarchar(36) )
  , TAGNBR			=   aTag.TagNumber 
  , TAGDATE			=   aTag.TagDate
  , PRIMARYTAG		=   CAST( aTag.IsPrimaryTag AS int ) 
  , ISCURRENT		=	CAST( aTag.IsCurrentTag AS int )
  , DELETED_BY		=	ISNULL( aTag.DeletedBy, -1 )
  , MFSYNC          =	N'Y'
FROM 
    dimension.AnimalTag AS aTag
INNER JOIN 
    dimension.Animal AS a
        ON a.AnimalKey= aTag.AnimalKey
INNER JOIN 
    stage.AnimalTag AS stage
        ON stage.AnimalTagKey = aTag.AnimalTagKey ;