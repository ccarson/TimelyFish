 /****** Object:  Stored Procedure dbo.DeletePOTran_BatNbr_RcptNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure DeletePOTran_BatNbr_RcptNbr @parm1 varchar ( 10), @parm2 varchar ( 10) As
Delete potran from POTran Where BatNbr = @parm1
and RcptNbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeletePOTran_BatNbr_RcptNbr] TO [MSDSL]
    AS [dbo];

