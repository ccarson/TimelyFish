 /****** Object:  Stored Procedure dbo.Item2Hist_InvtId_FiscYr1    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.Item2Hist_InvtId_FiscYr1    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Item2Hist_InvtId_FiscYr1 @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 4) as
    Select * from Item2Hist
            where InvtId = @parm1
            and SiteId = @parm2
            and FiscYr >= @parm3
            order by InvtId,SiteId, FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Item2Hist_InvtId_FiscYr1] TO [MSDSL]
    AS [dbo];

