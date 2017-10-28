 /****** Object:  Stored Procedure dbo.pidetail_settobook    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure pidetail_settobook @parm1 VarChar(10) as
    update pidetail
    set pidetail.status = 'E',
    pidetail.physqty = pidetail.bookqty,
    pidetail.extcostvariance = 0
    where pidetail.piid = @parm1 and pidetail.status = 'N'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pidetail_settobook] TO [MSDSL]
    AS [dbo];

