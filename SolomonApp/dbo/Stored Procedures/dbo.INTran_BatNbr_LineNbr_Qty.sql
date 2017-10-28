 /****** Object:  Stored Procedure dbo.INTran_BatNbr_LineNbr_Qty    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_BatNbr_LineNbr_Qty    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_BatNbr_LineNbr_Qty @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
    Select * from INTran where Batnbr = @parm1
                  and LineNbr between @parm2beg and @parm2end
                  and Qty > 0
                  and TranType = 'TR'
                  order by BatNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_LineNbr_Qty] TO [MSDSL]
    AS [dbo];

