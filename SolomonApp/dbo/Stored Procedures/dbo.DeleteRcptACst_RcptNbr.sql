 /****** Object:  Stored Procedure dbo.DeleteRcptACst_RcptNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure DeleteRcptACst_RcptNbr @parm1 varchar ( 10) As
Delete from RcptACst Where RcptNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteRcptACst_RcptNbr] TO [MSDSL]
    AS [dbo];

