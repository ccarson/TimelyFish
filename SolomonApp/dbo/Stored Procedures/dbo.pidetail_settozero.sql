 /****** Object:  Stored Procedure dbo.pidetail_settozero    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure pidetail_settozero @parm1 VarChar(10) as
    update pidetail
    set pidetail.status = 'E', pidetail.physqty = 0
    where pidetail.piid = @parm1 and pidetail.status = 'N'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pidetail_settozero] TO [MSDSL]
    AS [dbo];

