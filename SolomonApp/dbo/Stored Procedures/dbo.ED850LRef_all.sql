 CREATE PROCEDURE ED850LRef_all
 @parm1 varchar( 10 ),
 @parm2 varchar( 10 ),
 @parm3min smallint, @parm3max smallint
AS
 SELECT *
 FROM ED850LRef
 WHERE CpnyId LIKE @parm1
    AND EDIPOID LIKE @parm2
    AND LineNbr BETWEEN @parm3min AND @parm3max
 ORDER BY CpnyId,
    EDIPOID,
    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LRef_all] TO [MSDSL]
    AS [dbo];

