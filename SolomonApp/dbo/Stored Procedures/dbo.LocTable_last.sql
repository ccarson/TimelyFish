 /****** Object:  Stored Procedure dbo.LocTable_last    Script Date: 4/17/98 10:58:18 AM ******/
Create Procedure LocTable_last @parm1 VarChar(10), @parm2 smalldatetime as
    update LocTable set selected = 1, countstatus = 'P'
    where siteid = @parm1
    and countstatus = 'A'
    and lastcountdate <= @parm2


