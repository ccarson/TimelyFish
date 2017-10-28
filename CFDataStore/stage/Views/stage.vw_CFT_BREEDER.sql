
CREATE VIEW 
    [stage].[vw_CFT_BREEDER]
AS
SELECT
    ID              =   o.SourceGUID
  , NAME			=   o.ObserverName
  , FARMID			=   CAST( ISNULL( f.SourceGUID, CAST( 0x0 AS uniqueidentifier ) ) AS nvarchar(36) ) 
  , BREEDERID		=   o.ObserverSynonym
  , [STATUS]		=	case when o.IsDisabled = 1 then 0 Else 1 end
  ,	DELETED_BY		=	case when o.DeletedDate IS NULL then -1 Else 0 end

FROM 
    dimension.Observer AS o
LEFT OUTER JOIN 
	dimension.Farm AS f
		ON f.FarmKey = o.FarmKey ;