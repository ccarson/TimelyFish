 /****** Object:  Stored Procedure dbo.INTran_BatNbr_NegPos    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_BatNbr_NegPos    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_BatNbr_NegPos @parm1 varchar ( 10) as
    Select * from INTran
        where INTran.BatNbr = @parm1
        and INTran.Rlsed = 0
        order by BatNbr, InvtId, LineId, LineNbr, Qty



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_NegPos] TO [MSDSL]
    AS [dbo];

