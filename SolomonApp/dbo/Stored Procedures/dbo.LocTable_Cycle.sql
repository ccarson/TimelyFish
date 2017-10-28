 /****** Object:  Stored Procedure dbo.LocTable_Cycle    Script Date: 4/17/98 10:58:18 AM ******/
Create Proc LocTable_Cycle @parm1 VarChar(10), @parm2 Varchar(10) as
    update LocTable set selected = 1, countstatus = 'P'
    where siteid = @parm1
    and countstatus = 'A'
    and cycleid = @parm2


