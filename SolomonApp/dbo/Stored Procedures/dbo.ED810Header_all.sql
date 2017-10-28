 CREATE PROCEDURE ED810Header_all
 @parm1 varchar( 10 )
AS
 SELECT *
 FROM ED810Header
 WHERE EDIInvId LIKE @parm1
 ORDER BY EDIInvId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_all] TO [MSDSL]
    AS [dbo];

