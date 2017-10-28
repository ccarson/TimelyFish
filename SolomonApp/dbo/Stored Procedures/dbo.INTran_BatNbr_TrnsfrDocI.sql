 /****** Object:  Stored Procedure dbo.INTran_BatNbr_TrnsfrDocI    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_BatNbr_TrnsfrDocI    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_BatNbr_TrnsfrDocI @parm1 varchar ( 10) as
    Select * from INTran
        where INTran.BatNbr = @parm1
        and INTran.ToSiteId <> ''
        order by BatNbr, InvtId, SiteId, WhseLoc, RefNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_TrnsfrDocI] TO [MSDSL]
    AS [dbo];

