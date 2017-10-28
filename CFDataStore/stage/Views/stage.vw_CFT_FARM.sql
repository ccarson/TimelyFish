

CREATE VIEW 
    [stage].[vw_CFT_FARM]
AS
SELECT
    ID              =   CAST( f.SourceGUID AS nvarchar(36) ) 
  , NAME			=   f.FarmName 
  , CONTACTID		=   f.FarmNumber
  , PIGCHAMP_NAME	=   LEFT( f.FarmName, 10 )
  , PIGCHAMP_ID		=   CAST( f.SourceID AS bigint )
FROM 
    dimension.Farm AS f 
;
