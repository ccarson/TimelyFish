 CREATE PROCEDURE ED850Lineitem_Qty
 @parm1min float, @parm1max float
AS
 SELECT *
 FROM ED850Lineitem
 WHERE Qty BETWEEN @parm1min AND @parm1max
 ORDER BY Qty



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Lineitem_Qty] TO [MSDSL]
    AS [dbo];

