 Create	Procedure SCM_10400_CheckKitGLBalance
	@Module		Char(2),
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10),
	@RefNbr		VarChar(15),
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
			And RefNbr = @RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_CheckKitGLBalance] TO [MSDSL]
    AS [dbo];

