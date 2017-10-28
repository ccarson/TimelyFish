 Create Proc INTran_BatNbr2_Adj @parm1 varchar ( 10) as
    Select * from INTran
        where INTran.BatNbr = @parm1
        and INTran.Rlsed = 0
        order by BatNbr DESC, InvtId DESC, SiteId DESC, Qty DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr2_Adj] TO [MSDSL]
    AS [dbo];

