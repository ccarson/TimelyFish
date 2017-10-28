 /****** Object:  Stored Procedure dbo.PIDetail_LocTable_Reset    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure PIDetail_LocTable_Reset @parm1 VarChar(10) as
    Update loctable set loctable.countstatus = 'A'
    from loctable, pidetail
    where pidetail.piid = @parm1
    and loctable.countstatus = 'P'
    and loctable.siteid = pidetail.siteid
    and loctable.whseloc = pidetail.whseloc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetail_LocTable_Reset] TO [MSDSL]
    AS [dbo];

