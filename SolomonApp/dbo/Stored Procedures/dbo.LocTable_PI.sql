 /****** Object:  Stored Procedure dbo.LocTable_PI    Script Date: 4/17/98 10:58:18 AM ******/
Create Procedure LocTable_PI @parm1 varchar(10) as
    update LocTable set selected = 1, countstatus = 'P'
    where siteid = @parm1
    and countstatus = 'A'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LocTable_PI] TO [MSDSL]
    AS [dbo];

