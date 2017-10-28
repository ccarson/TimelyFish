 Create Proc INTran_BatNbr_RefNBr_DrCr @BatNbr varchar ( 10),
	@RefNbr varchar (15), @DrCr varchar (10) as
	Select * from INTran
		Where BatNbr = @BatNbr
		and RefNbr = @RefNbr
		and DrCr = @DrCr
           	order by BatNbr, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_RefNBr_DrCr] TO [MSDSL]
    AS [dbo];

