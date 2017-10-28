 Create	Procedure SCM_10400_AssyDoc
	@BatNbr	VarChar(10),
	@CpnyID	VarChar(10),
	@KitID	VarChar(30),
	@RefNbr	VarChar(15)
As
	Select	*
		From	AssyDoc (NoLock)
		Where	KitID = @KitID
			And RefNbr = @RefNbr
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_AssyDoc] TO [MSDSL]
    AS [dbo];

