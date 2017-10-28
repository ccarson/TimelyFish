CREATE VIEW [stage].[vw_Observer]
AS
SELECT       
    ObserverKey			=	CAST( ISNULL( o.ObserverKey, 0 ) AS bigint )
  , FarmKey				=   CAST( ISNULL( f.FarmKey, -1 ) AS bigint )
  , ObserverName		=   CAST( sup.last_name AS nvarchar(50) ) 
  , ObserverSynonym		=	CAST( sup.[synonym] AS nvarchar(05) ) 
  , IsDisabled			=	CAST( sup.[disabled] AS bit ) 
  , SourceCode			=	N'PigCHAMP'
  , SourceID			=	sup.supervisor_id
  , SourceGUID			=	sup.SourceGUID
  , deletion_date		=	sup.deletion_date
FROM            
    stage.SUPERVISORS AS sup
LEFT OUTER JOIN 
	dimension.Observer AS o 
		ON o.SourceID = sup.supervisor_id
LEFT OUTER JOIN 
	dimension.Farm AS f
		ON f.SourceID = sup.site_id 
;


