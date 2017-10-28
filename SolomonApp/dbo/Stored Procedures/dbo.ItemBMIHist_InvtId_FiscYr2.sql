 /****** Object:  Stored Procedure dbo.ItemBMIHist_InvtId_FiscYr2    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.ItemBMIHist_InvtId_FiscYr2    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemBMIHist_InvtId_FiscYr2 @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 4) as
    Select * from ItemBMIHist
            where InvtId = @parm1
            and SiteId = @parm2
            and FiscYr <= @parm3
            order by InvtId, SiteId, FiscYr desc




GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemBMIHist_InvtId_FiscYr2] TO [MSDSL]
    AS [dbo];

