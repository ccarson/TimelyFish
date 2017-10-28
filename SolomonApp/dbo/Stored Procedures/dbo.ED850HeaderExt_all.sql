 CREATE PROCEDURE ED850HeaderExt_all
 @parm1 varchar( 10 ),
 @parm2 varchar( 10 )
AS
 SELECT *
 FROM ED850HeaderExt
 WHERE CpnyId LIKE @parm1
    AND EDIPoId LIKE @parm2
 ORDER BY CpnyId,
    EDIPoId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850HeaderExt_all] TO [MSDSL]
    AS [dbo];

