
CREATE VIEW 
    [stage].[vw_CFT_ANIMAL]
AS
SELECT
    ID              =   CAST( a.SourceGUID AS nvarchar(36) ) 
  , BIRTHDATE       =   a.DateOfBirth
  , GENETICSID      =   CAST( ISNULL( g.SourceGUID, CAST( 0x0 AS uniqueidentifier ) ) AS nvarchar(36) ) 
  , SEX             =   a.Sex
  , ORIGIN          =   o.OriginName
  , ORIGINID		=	o.SourceGUID
  , PigChampID		=	a.SourceID
  , MFSYNC          =	N'Y'

FROM 
    dimension.Animal AS a 
LEFT OUTER JOIN 
	dimension.Genetics AS g
		ON a.GeneticsKey = g.GeneticsKey
INNER JOIN 
    dimension.Origin AS o 
        ON a.OriginKey = o.OriginKey
INNER JOIN 
    stage.Animal AS sa 
        ON sa.AnimalKey = a.AnimalKey ; 