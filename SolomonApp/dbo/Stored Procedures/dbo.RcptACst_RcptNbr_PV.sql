 /****** Object:  Stored Procedure dbo.POReceipt_PONbr_PV    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure RcptACst_RcptNbr_PV @parm1 varchar ( 15), @parm2 varchar ( 10) As
        Select * From RcptACst
                Where Vendid = @parm1
                And VouchStage <> 'F'
                And RcptNbr LIKE @parm2
        Order By RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RcptACst_RcptNbr_PV] TO [MSDSL]
    AS [dbo];

