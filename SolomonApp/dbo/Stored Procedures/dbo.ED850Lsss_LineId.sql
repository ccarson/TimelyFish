 CREATE PROCEDURE ED850Lsss_LineId
 @parm1min int, @parm1max int
AS
 SELECT *
 FROM ED850Lsss
 WHERE LineId BETWEEN @parm1min AND @parm1max
 ORDER BY LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Lsss_LineId] TO [MSDSL]
    AS [dbo];

