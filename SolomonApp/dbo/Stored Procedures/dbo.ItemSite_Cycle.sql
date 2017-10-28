 /****** Object:  Stored Procedure dbo.ItemSite_Cycle    Script Date: 4/17/98 10:58:18 AM ******/
Create Procedure ItemSite_Cycle @parm1 varChar(10), @parm2 varchar(10) as
    update itemsite set selected = 1, countstatus = 'P'
    where siteid = @parm1
    and countstatus = 'A'
    and cycleid = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_Cycle] TO [MSDSL]
    AS [dbo];

