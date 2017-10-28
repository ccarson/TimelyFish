 CREATE PROCEDURE EDBOLClass_all
 @parm1 varchar( 20 )
AS
 SELECT *
 FROM EDBOLClass
 WHERE BOLClass LIKE @parm1
 ORDER BY BOLClass



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDBOLClass_all] TO [MSDSL]
    AS [dbo];

