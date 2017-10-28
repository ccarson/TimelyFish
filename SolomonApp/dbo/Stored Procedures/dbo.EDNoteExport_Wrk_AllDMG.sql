 /****** Object:  Stored Procedure dbo.EDNoteExport_Wrk_All    Script Date: 5/28/99 1:17:43 PM ******/
CREATE PROCEDURE EDNoteExport_Wrk_AllDMG @parm1 varchar(21), @parm2 int AS
Select *
from EDNoteExport_Wrk
where  ComputerName like @Parm1
and nID = @parm2
Order by ComputerName, Nid, LineNbr


