 /****** Object:  Stored Procedure dbo.RcptACst_InvcType_PO_Vend    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc RcptACst_InvcType_PO_Vend @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 10) as
    Select * from RcptACst
           where RcptACst.VendID = @parm1
             and RcptAcst.Rcptnbr = @parm2
             and RcptACst.VouchStage <> 'F'
             and RcptACst.InvcTypeID like @parm3
        Order by RcptNbr,InvcTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RcptACst_InvcType_PO_Vend] TO [MSDSL]
    AS [dbo];

