 /****** Object:  Stored Procedure dbo.INTran_BatNbr2    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_BatNbr2    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_BatNbr2 @parm1 varchar ( 10) as
    Select * from INTran
        where INTran.BatNbr = @parm1
        and INTran.BatNbr <> ''
        and INTran.Rlsed = 0
        order by BatNbr, InvtId, SiteId, WhseLoc, RefNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr2] TO [MSDSL]
    AS [dbo];

