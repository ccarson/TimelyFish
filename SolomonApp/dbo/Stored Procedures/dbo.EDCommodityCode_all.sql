 CREATE PROCEDURE EDCommodityCode_all
 @parm1 varchar( 30 ),
 @parm2 varchar( 2 ),
 @parm3 varchar( 30 )
AS
 SELECT *
 FROM EDCommodityCode
 WHERE Invtid LIKE @parm1
    AND CommCodeQual LIKE @parm2
    AND CommCode LIKE @parm3
 ORDER BY Invtid,
    CommCodeQual,
    CommCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCommodityCode_all] TO [MSDSL]
    AS [dbo];

