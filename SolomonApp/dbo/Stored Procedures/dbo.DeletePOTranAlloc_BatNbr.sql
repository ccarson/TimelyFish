 /****** Object:  Stored Procedure dbo.DeletePOTranAlloc_BatNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure DeletePOTranAlloc_BatNbr
	@BatNbr varchar (10)
As
	Delete from POTranAlloc
	from POTranAlloc
	join POTran on POTran.RcptNbr = POTranAlloc.RcptNbr
	Where POTran.BatNbr = @BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeletePOTranAlloc_BatNbr] TO [MSDSL]
    AS [dbo];

