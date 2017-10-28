CREATE VIEW 
    stage.vw_MatingGroup
AS
SELECT
	MatingGroupKey	=	ISNULL( mGroup.MatingGroupKey, 0 )
  
  , MatingGroup		=	CAST( mEvent.GROUPNAME AS nvarchar(10) ) 
  , StartDateKey	=	CAST( CONVERT( varchar(08), MIN( mEvent.WEEKOFDATE ), 112 ) AS INT ) 
  , EndDateKey		=	CAST( CONVERT( varchar(08), MIN( mEvent.WEEKENDDATE ), 112 ) AS INT ) 
  
  
FROM 
	stage.WeekDefinition AS mEvent
LEFT OUTER JOIN 
	dimension.MatingGroup AS mGroup
		ON mGroup.MatingGroup = mEvent.GROUPNAME
WHERE 
	mEvent.GROUPNAME IS NOT NULL
	
GROUP BY 
	ISNULL( mGroup.MatingGroupKey, 0 )
  , mEvent.GROUPNAME ; 

