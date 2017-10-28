 /****** Object:  Stored Procedure dbo.INTran_BatNbr_InvtId    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_BatNbr_InvtId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_BatNbr_InvtId @parm1 varchar ( 10), @parm2 varchar ( 30) as
    Select * from INTran where Batnbr = @parm1
                  and InvtId = @parm2
                  order by BatNbr, InvtId, Qty



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_InvtId] TO [MSDSL]
    AS [dbo];

