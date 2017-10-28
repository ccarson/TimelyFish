 /****** Object:  Stored Procedure dbo.INTran_BatNbr_CmpnentId    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_BatNbr_CmpnentId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_BatNbr_CmpnentId @parm1 varchar ( 10), @parm2 varchar ( 30) as
    Select * from INTran where Batnbr = @parm1
                  and KitID = @parm2
                  order by BatNbr, KitID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_CmpnentId] TO [MSDSL]
    AS [dbo];

