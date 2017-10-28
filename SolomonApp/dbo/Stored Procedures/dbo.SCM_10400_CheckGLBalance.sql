 Create	Procedure SCM_10400_CheckGLBalance
	@Module		Char(2),
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt
As
	Set	NoCount On

	Select	CrAmt = Round(Sum(CrAmt), @BaseDecPl),
		DrAmt = Round(Sum(DrAmt), @BaseDecPl)
		From	GLTran (NoLock)
		Where	Module = @Module
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID


