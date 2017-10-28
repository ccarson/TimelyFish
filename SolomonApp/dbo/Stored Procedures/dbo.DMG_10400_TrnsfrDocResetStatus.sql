 Create	Procedure DMG_10400_TrnsfrDocResetStatus
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10)
As

	Declare @OldStatus	char (1),
		@InvtMult	smallint

	Select	@OldStatus = status
	From 	TrnsfrDoc
	Where	BatNbr = @BatNbr
		And CpnyID = @CpnyID

	If @OldStatus = 'P' Begin
		Select	Top 1 	@InvtMult = InvtMult
		From	INTran (NoLock)
		Where	BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And TranType = 'TR'
		Order by LineId Desc

		If @InvtMult = 1
			Update	TrnsfrDoc
			Set	status = 'R'
			Where	BatNbr = @BatNbr
				And CpnyID = @CpnyID

		If @InvtMult = -1
			Update	TrnsfrDoc
			Set	status = 'I'
			Where	BatNbr = @BatNbr
				And CpnyID = @CpnyID
	End



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_TrnsfrDocResetStatus] TO [MSDSL]
    AS [dbo];

