

CREATE VIEW 
    [stage].[vw_CFT_GENETICS]
AS
SELECT
    ID              =   CAST( g.SourceGUID AS nvarchar(36) ) 
  , NAME			=   g.GeneticsName 
  , PIGCHAMP_ID		=   CAST( g.SourceID AS bigint )
  , SEX             =   CAST( g.Sex AS nvarchar(10) )
  , [STATUS]		=	case when g.IsDisabled = 1 then N'0' Else N'1' end
  ,	DELETED_BY		=	case when g.DeletedDate IS NULL then -1 Else 0 end
FROM 
    dimension.Genetics AS g ;
