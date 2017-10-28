 /****** Object:  Stored Procedure dbo.DeletePOTran_RcptNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure DeletePOTran_RcptNbr @parm1 varchar ( 10) As
Delete from POTran Where RcptNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeletePOTran_RcptNbr] TO [MSDSL]
    AS [dbo];

