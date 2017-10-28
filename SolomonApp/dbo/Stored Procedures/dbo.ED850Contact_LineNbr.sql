 CREATE PROCEDURE ED850Contact_LineNbr
 @parm1min smallint, @parm1max smallint
AS
 SELECT *
 FROM ED850Contact
 WHERE LineNbr BETWEEN @parm1min AND @parm1max
 ORDER BY LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Contact_LineNbr] TO [MSDSL]
    AS [dbo];

