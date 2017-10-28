 /****** Object:  Stored Procedure dbo.Picycle_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Picycle_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc Picycle_All @parm1 varchar ( 10) as
            Select * from picycle where CycleID like @parm1
                order by CycleID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Picycle_All] TO [MSDSL]
    AS [dbo];

