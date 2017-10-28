 Create	Procedure SCM_Insert_Wrk10400_GLTran
	@Acct 		VarChar(10),
	@BatNbr 	VarChar(10),
	@CpnyID 	VarChar(10),
	@CrAmt 		Float,
	@DrAmt 		Float,
	@DrCr 		Char(1),
	@InvtID 	VarChar(30),
	@JrnlType 	VarChar(3),
	@LineID 	Integer,
	@LineNbr 	SmallInt,
	@Module 	Char(2),
	@ProjectID 	VarChar(16),
	@Qty 		Float,
	@RefNbr 	VarChar(15),
	@Sub 		VarChar(24),
	@TaskID 	VarChar(32),
	@TranDate 	SmallDateTime,
	@TranDesc 	VarChar(30),
	@TranType 	Char(2)
As
	Set	NoCount On

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	Insert	Into Wrk10400_GLTran
			(Acct, BatNbr, CpnyID, CrAmt, DrAmt,
			DrCr, InvtID, JrnlType, LineID, LineNbr,
			Module, ProjectID, Qty, RefNbr, Sub,
			TaskID, TranDate, TranDesc, TranType)
		Values
			(@Acct, @BatNbr, @CpnyID, @CrAmt, @DrAmt,
			@DrCr, @InvtID, @JrnlType, @LineID, @LineNbr,
			@Module, @ProjectID, @Qty, @RefNbr, @Sub,
			@TaskID, @TranDate, @TranDesc, @TranType)

		Select @SQLErrNbr = @@Error
		If @SQLErrNbr <> 0
		Begin
			Insert 	Into IN10400_RETURN
					(S4Future01, SQLErrorNbr)
				Values
					('SCM_Insert_Wrk10400_GLTran', @SQLErrNbr)
		End


