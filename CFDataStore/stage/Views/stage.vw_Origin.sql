
CREATE VIEW [stage].[vw_Origin]
AS
SELECT  
	OriginKey		=	ISNULL( o.OriginKey, 0 ) 
  , FarmKey			=	ISNULL( f.FarmKey, -1 ) 
  , OriginName		=	CAST( ext.Origin_farm_name AS nvarchar(50) )
  , SourceID        =   ext.farm_id
  , SourceGUID		=	ext.SourceGUID
FROM            
    stage.ORIGIN_FARMS AS ext
LEFT OUTER JOIN 
	dimension.Origin AS o 
		ON o.SourceID = ext.Origin_site_id
LEFT OUTER JOIN 
	dimension.Farm AS f
		ON f.SourceID = ext.farm_id

;

