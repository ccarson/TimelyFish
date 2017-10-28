 /****** Object:  Stored Procedure dbo.ItemSite_Last    Script Date: 4/17/98 10:58:18 AM ******/
Create Procedure ItemSite_Last @parm1 VarChar(10), @parm2 smalldatetime as
    update itemsite set selected = 1, countstatus = 'P'
    where siteid = @parm1
    and countstatus = 'A'
    and lastcountdate <= @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_Last] TO [MSDSL]
    AS [dbo];

