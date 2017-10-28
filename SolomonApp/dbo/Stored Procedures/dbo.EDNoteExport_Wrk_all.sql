 CREATE PROCEDURE EDNoteExport_Wrk_all
 @parm1 varchar( 21 ),
 @parm2min int, @parm2max int,
 @parm3min int, @parm3max int
AS
 SELECT *
 FROM EDNoteExport_Wrk
 WHERE ComputerName LIKE @parm1
    AND nId BETWEEN @parm2min AND @parm2max
    AND LineNbr BETWEEN @parm3min AND @parm3max
 ORDER BY ComputerName,
    nId,
    LineNbr


