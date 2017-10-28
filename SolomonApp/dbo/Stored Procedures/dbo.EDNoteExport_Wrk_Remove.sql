 CREATE PROCEDURE EDNoteExport_Wrk_Remove  @parm1 varchar(21), @parm2 int AS
delete
from EDNoteExport_Wrk
where  ComputerName like @Parm1
and nID = @parm2


