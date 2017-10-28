 CREATE PROCEDURE EDNoteExport_Wrk_nId
 @parm1min int, @parm1max int
AS
 SELECT *
 FROM EDNoteExport_Wrk
 WHERE nId BETWEEN @parm1min AND @parm1max
 ORDER BY nId


