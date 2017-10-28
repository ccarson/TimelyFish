 CREATE PROCEDURE EDNoteExport_Wrk_LineNbr
 @parm1min int, @parm1max int
AS
 SELECT *
 FROM EDNoteExport_Wrk
 WHERE LineNbr BETWEEN @parm1min AND @parm1max
 ORDER BY LineNbr


