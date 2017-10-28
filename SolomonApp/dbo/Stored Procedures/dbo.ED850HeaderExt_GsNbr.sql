 CREATE PROCEDURE ED850HeaderExt_GsNbr
 @parm1min int, @parm1max int
AS
 SELECT *
 FROM ED850HeaderExt
 WHERE GsNbr BETWEEN @parm1min AND @parm1max
 ORDER BY GsNbr


