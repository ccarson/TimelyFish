 /****** Object:  Stored Procedure dbo.pidetail_resetall    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure pidetail_resetall @parm1 VarChar(10) as
    update pidetail
    set pidetail.status = 'N', pidetail.physqty = 0, pidetail.extcostvariance = 0, pidetail.s4future03 = 0
    where pidetail.piid = @parm1

    Delete pidetcost
    where pidetcost.piid = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pidetail_resetall] TO [MSDSL]
    AS [dbo];

