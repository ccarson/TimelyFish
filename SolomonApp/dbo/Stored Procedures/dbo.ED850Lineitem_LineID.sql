 CREATE PROCEDURE ED850Lineitem_LineID
 @parm1min int, @parm1max int
AS
 SELECT *
 FROM ED850Lineitem
 WHERE LineID BETWEEN @parm1min AND @parm1max
 ORDER BY LineID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Lineitem_LineID] TO [MSDSL]
    AS [dbo];

