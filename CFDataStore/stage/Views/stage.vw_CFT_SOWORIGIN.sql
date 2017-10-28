

CREATE VIEW 
    [stage].[vw_CFT_SOWORIGIN]
AS
SELECT
    ID      =   o.SourceGUID 
  , FARMID	=   f.SourceGUID
  , NAME	=   o.OriginName
FROM 
    dimension.Origin AS o
INNER JOIN
	dimension.Farm AS f 
		ON f.FarmKey = o.FarmKey ; 
