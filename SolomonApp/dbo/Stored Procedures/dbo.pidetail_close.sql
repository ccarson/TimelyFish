 /****** Object:  Stored Procedure dbo.pidetail_close    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure pidetail_close @parm1 VarChar(6), @parm2 VarChar(10) as
    update pidetail set perclosed = @parm1
    where piid = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pidetail_close] TO [MSDSL]
    AS [dbo];

