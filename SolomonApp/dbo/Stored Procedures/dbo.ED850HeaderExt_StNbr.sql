 CREATE PROCEDURE ED850HeaderExt_StNbr
 @parm1min int, @parm1max int
AS
 SELECT *
 FROM ED850HeaderExt
 WHERE StNbr BETWEEN @parm1min AND @parm1max
 ORDER BY StNbr


