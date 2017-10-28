 CREATE PROCEDURE ED850LDesc_LineId
 @parm1min int, @parm1max int
AS
 SELECT *
 FROM ED850LDesc
 WHERE LineId BETWEEN @parm1min AND @parm1max
 ORDER BY LineId


