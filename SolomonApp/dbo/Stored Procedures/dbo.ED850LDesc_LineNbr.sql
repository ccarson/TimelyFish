 CREATE PROCEDURE ED850LDesc_LineNbr
 @parm1min smallint, @parm1max smallint
AS
 SELECT *
 FROM ED850LDesc
 WHERE LineNbr BETWEEN @parm1min AND @parm1max
 ORDER BY LineNbr


