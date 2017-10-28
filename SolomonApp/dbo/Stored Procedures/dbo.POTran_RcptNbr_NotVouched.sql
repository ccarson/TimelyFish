 /****** Object:  Stored Procedure dbo.POTran_RcptNbr_NotVouched    Script Date: 4/16/98 7:50:26 PM ******/
Create proc POTran_RcptNbr_NotVouched @parm1 varchar ( 10) as
        Select * from POTran where RcptNbr = @parm1
            and VouchStage <> 'F'
            Order by RcptNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_RcptNbr_NotVouched] TO [MSDSL]
    AS [dbo];

