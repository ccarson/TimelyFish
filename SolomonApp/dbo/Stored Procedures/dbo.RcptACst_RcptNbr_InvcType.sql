 /****** Object:  Stored Procedure dbo.RcptACst_RcptNbr_InvcType    Script Date: 4/16/98 7:50:27 PM ******/
Create Proc RcptACst_RcptNbr_InvcType @parm1 varchar ( 10), @parm2 varchar ( 10) as
    Select * from RcptACst where
        RcptNbr = @parm1 and
                InvcTypeID = @parm2
        Order by RcptNbr, InvcTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RcptACst_RcptNbr_InvcType] TO [MSDSL]
    AS [dbo];

