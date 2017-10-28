 /****** Object:  Stored Procedure dbo.pidetail_voidrest    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure pidetail_voidrest @parm1 VarChar(10) as
    update pidetail
    set pidetail.status = 'X'
    where pidetail.piid = @parm1 and pidetail.status = 'N'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pidetail_voidrest] TO [MSDSL]
    AS [dbo];

