 /****** Object:  Stored Procedure dbo.ItemHist_InvtId_FiscYr3    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.ItemHist_InvtId_FiscYr3    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemHist_InvtId_FiscYr3 @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 4) as
    Select * from ItemHist
            where ItemHist.InvtId = @parm1
            and ItemHist.SiteId = @parm2
            and ItemHist.FiscYr < @parm3
            order by ItemHist.InvtId, ItemHist.SiteId, ItemHist.FiscYr desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemHist_InvtId_FiscYr3] TO [MSDSL]
    AS [dbo];

