 Create	Procedure SCM_10400_GLTran_NextLineID
	@Module	Char(2),
	@BatNbr	VarChar(10),
	@CpnyID	VarChar(10),
	@LineID	Integer OutPut
As
	Set	NoCount On
	Select	@LineID = Max(LineID)
		From	GLTran (NoLock)
		Where	Module = @Module
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID
	Select	@LineID = Coalesce(@LineID, 0) + 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_GLTran_NextLineID] TO [MSDSL]
    AS [dbo];

