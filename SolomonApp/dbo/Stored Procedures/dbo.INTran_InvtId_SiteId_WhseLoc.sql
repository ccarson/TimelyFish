 /****** Object:  Stored Procedure dbo.INTran_InvtId_SiteId_WhseLoc    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_InvtId_SiteId_WhseLoc    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_InvtId_SiteId_WhseLoc @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 10), @parm4beg int, @parm4end int as
    Select * from INTran
          where InvtId = @parm1
            and SiteId = @parm2
            and WhseLoc = @parm3
            and Rlsed = 1
            and TranType Not In ('CT', 'CG')
	    and TranDesc <> 'Standard Cost Variance'
            and RecordId between @parm4beg and @parm4end
          Order by InvtId, SiteId, WhseLoc, TranDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_InvtId_SiteId_WhseLoc] TO [MSDSL]
    AS [dbo];

