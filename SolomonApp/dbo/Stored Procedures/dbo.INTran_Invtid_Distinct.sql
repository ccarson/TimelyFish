 Create Proc INTran_Invtid_Distinct @parm1 varchar ( 30) as
	Set NoCount ON
        Select distinct InvtId,SiteId from INTran where InvtId = @parm1 group by InvtId, SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_Invtid_Distinct] TO [MSDSL]
    AS [dbo];

