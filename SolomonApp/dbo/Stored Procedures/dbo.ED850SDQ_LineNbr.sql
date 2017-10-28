 CREATE PROCEDURE ED850SDQ_LineNbr
 @parm1min smallint, @parm1max smallint
AS
 SELECT *
 FROM ED850SDQ
 WHERE LineNbr BETWEEN @parm1min AND @parm1max
 ORDER BY LineNbr


