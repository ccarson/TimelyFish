 CREATE PROCEDURE ED850Lsss_LineNbr
 @parm1min smallint, @parm1max smallint
AS
 SELECT *
 FROM ED850Lsss
 WHERE LineNbr BETWEEN @parm1min AND @parm1max
 ORDER BY LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Lsss_LineNbr] TO [MSDSL]
    AS [dbo];

