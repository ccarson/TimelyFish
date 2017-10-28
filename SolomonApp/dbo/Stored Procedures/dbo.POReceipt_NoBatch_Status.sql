 /****** Object:  Stored Procedure dbo.POReceipt_NoBatch_Status    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POReceipt_NoBatch_Status @parm1 varchar ( 01) As
        Select * from POReceipt where
                BatNbr = '' And
                Status = @parm1
        Order by CuryID, RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_NoBatch_Status] TO [MSDSL]
    AS [dbo];

