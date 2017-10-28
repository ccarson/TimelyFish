 CREATE PROCEDURE ED850Lineitem_LineNbr
 @parm1min smallint, @parm1max smallint
AS
 SELECT *
 FROM ED850Lineitem
 WHERE LineNbr BETWEEN @parm1min AND @parm1max
 ORDER BY LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Lineitem_LineNbr] TO [MSDSL]
    AS [dbo];

