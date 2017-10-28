 /****** Object:  Stored Procedure dbo.DeletePOReceipt_BatNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure DeletePOReceipt_BatNbr @parm1 varchar ( 10) As
   Delete poreceipt from POReceipt Where BatNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeletePOReceipt_BatNbr] TO [MSDSL]
    AS [dbo];

