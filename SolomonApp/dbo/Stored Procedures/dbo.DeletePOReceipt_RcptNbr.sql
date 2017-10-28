 /****** Object:  Stored Procedure dbo.DeletePOReceipt_RcptNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure DeletePOReceipt_RcptNbr @parm1 varchar ( 10) As
Delete poreceipt from POReceipt Where RcptNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeletePOReceipt_RcptNbr] TO [MSDSL]
    AS [dbo];

