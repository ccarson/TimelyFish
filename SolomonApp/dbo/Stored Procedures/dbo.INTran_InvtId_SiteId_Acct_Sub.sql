 /****** Object:  Stored Procedure dbo.INTran_InvtId_SiteId_Acct_Sub    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_InvtId_SiteId_Acct_Sub    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_InvtId_SiteId_Acct_Sub @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 smalldatetime as
    Select Acct, InvtID, Sum(Qty), SiteID, Sub, TranType from INTran
          where InvtId = @parm1
            and SiteId = @parm2
            and TranDate >= @parm3
            and Qty <> 0
          Group by InvtId, SiteId, TranType, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_InvtId_SiteId_Acct_Sub] TO [MSDSL]
    AS [dbo];

