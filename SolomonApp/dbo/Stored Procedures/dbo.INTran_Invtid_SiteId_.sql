 Create Proc INTran_Invtid_SiteId_ @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 2) as
	Set NoCount ON
	Select * from INTran where Invtid = @parm1 and SiteId = @parm2
      		and TranType = @parm3 and rlsed = 1 order by InvtId, SiteId, TranType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invtid_SiteId_] TO [MSDSL]
    AS [dbo];

