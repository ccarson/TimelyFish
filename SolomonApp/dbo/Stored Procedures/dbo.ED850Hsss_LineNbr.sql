 CREATE PROCEDURE ED850Hsss_LineNbr
 @parm1min smallint, @parm1max smallint
AS
 SELECT *
 FROM ED850Hsss
 WHERE LineNbr BETWEEN @parm1min AND @parm1max
 ORDER BY LineNbr


