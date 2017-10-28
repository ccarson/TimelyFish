
CREATE VIEW 
    stage.vw_Genetics 
AS
SELECT
	GeneticsKey			=	ISNULL( dim.GeneticsKey, 0 ) 
  , SourceID            =   stage.genetics_id       
  , GeneticsName        =   CAST( stage.longname AS nvarchar(30) ) 
  , Sex                 =   CAST( ISNULL( stage.sex, N'' ) AS nchar(01) )   
  , IsDisabled          =   stage.[disabled]
  , IsSystem            =   stage.[system]
  , GeneticsSynonym     =   CAST( ISNULL( stage.[synonym], N'' ) AS nvarchar(05) ) 
  , SourceGUID			=	stage.SourceGUID
  , deletion_date		=	stage.deletion_date
FROM 
    stage.GENETICS AS stage
LEFT OUTER JOIN
	dimension.Genetics AS dim 
		ON dim.SourceID = stage.genetics_id
;