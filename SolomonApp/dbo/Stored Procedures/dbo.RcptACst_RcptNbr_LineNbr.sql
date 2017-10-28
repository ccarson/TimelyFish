 /****** Object:  Stored Procedure dbo.RcptACst_RcptNbr_LineNbr    Script Date: 4/16/98 7:50:27 PM ******/
Create Proc RcptACst_RcptNbr_LineNbr @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
    Select * from RcptACst where
        RcptNbr = @parm1 and
                LineNbr between @parm2beg and @parm2end
        Order by RcptNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RcptACst_RcptNbr_LineNbr] TO [MSDSL]
    AS [dbo];

