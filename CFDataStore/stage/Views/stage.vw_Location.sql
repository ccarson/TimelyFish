CREATE VIEW [stage].[vw_Location]
AS
SELECT    
	LocationKey		=	CAST( ISNULL( l.LocationKey, 0 ) AS bigint )
  , FarmKey			=	f.FarmKey  
  , Barn			=	CAST( loc.barn AS nvarchar(10) ) 
  , Room			=	CAST( loc.room AS nvarchar(10) ) 
  , Pen				=	CAST( loc.pen AS nvarchar(10) ) 
  , SourceID		=	loc.location_id
  , SourceGUID		=	loc.SourceGUID
  , deletion_date	=	loc.deletion_date
FROM            
    stage.LOCATIONS AS loc 
LEFT OUTER JOIN 
	dimension.Location AS l 
		ON l.SourceID = loc.location_id
INNER JOIN 
	dimension.Farm AS f 
		ON f.SourceID = loc.site_id 
; 



