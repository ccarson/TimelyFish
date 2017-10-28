CREATE VIEW 
    [stage].[vw_CFT_LOCATION]
AS
SELECT
    ID		=   loc.SourceGUID 
  , BARN	=	loc.Barn
  , ROOM	=	loc.Room
  , CRATE	=	loc.Pen
  , FARMID	=	farm.SourceGUID
  ,DELETED_BY		=	case when loc.DeletedDate IS NULL then -1 Else 0 end


FROM 
    dimension.Location AS loc
INNER JOIN 
    dimension.Farm AS farm
		ON farm.FarmKey = loc.FarmKey ;
