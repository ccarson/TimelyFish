 /****** Object:  Stored Procedure dbo.DeletePOTranAlloc_RcptNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure DeletePOTranAlloc_RcptNbr @parm1 varchar ( 10) As
Delete from POTranAlloc Where RcptNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeletePOTranAlloc_RcptNbr] TO [MSDSL]
    AS [dbo];

