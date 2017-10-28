 CREATE PROCEDURE ED850Contact_EdiPoId
 @parm1 varchar( 10 )
AS
 SELECT *
 FROM ED850Contact
 WHERE EdiPoId LIKE @parm1
 ORDER BY EdiPoId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Contact_EdiPoId] TO [MSDSL]
    AS [dbo];

