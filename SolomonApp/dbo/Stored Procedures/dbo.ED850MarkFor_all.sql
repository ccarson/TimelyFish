 CREATE PROCEDURE ED850MarkFor_all
 @parm1 varchar( 10 ),
 @parm2 varchar( 10 )
AS
 SELECT *
 FROM ED850MarkFor
 WHERE Cpnyid LIKE @parm1
    AND EDIPoId LIKE @parm2
 ORDER BY Cpnyid,
    EDIPoId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850MarkFor_all] TO [MSDSL]
    AS [dbo];

