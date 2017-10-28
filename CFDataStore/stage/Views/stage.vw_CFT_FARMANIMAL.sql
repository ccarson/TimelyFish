CREATE VIEW 
    [stage].[vw_CFT_FARMANIMAL]
AS
SELECT
    ID              =   CAST( fa.SourceGUID AS nvarchar(36) ) 
  , FARMID			=	CAST( f.SourceGUID	AS nvarchar(36) )
  , ANIMALID		=	CAST( a.SourceGUID  AS nvarchar(36) ) 
  , ENTRYDATE		=	ed.FullDate
  , REMOVALDATE		=	rd.FullDate
  , DELETED_BY		=	fa.DeletedBy
  , MFSYNC          =	N'Y'

FROM 
    dimension.FarmAnimal AS fa
INNER JOIN 
	dimension.Farm AS f 
		ON f.FarmKey= fa.FarmKey
INNER JOIN 
	dimension.Animal AS a 
		ON a.AnimalKey = fa.AnimalKey
LEFT OUTER JOIN 
	dimension.Date AS ed 
		ON ed.DateKey = fa.EntryDateKey
LEFT OUTER JOIN 
	dimension.Date AS rd 
		ON rd.DateKey = fa.RemovalDateKey
INNER JOIN 
	stage.FarmAnimal AS sfa
		ON sfa.FarmAnimalKey = fa.FarmAnimalKey ; 
