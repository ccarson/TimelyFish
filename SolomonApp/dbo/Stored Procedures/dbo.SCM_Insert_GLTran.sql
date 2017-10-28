 Create	Procedure SCM_Insert_GLTran
	@Acct		VarChar(10),
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10),
	@CrAmt		Float,
	@DrAmt		Float,
	@DrCr		Char(1),
	@InvtID		VarChar(30),
	@JrnlType	VarChar(3),
	@Module		VarChar(2),
	@ProjectID	VarChar(16),
	@Qty		Float,
	@RefNbr		VarChar(10),
	@Sub		VarChar(24),
	@TaskID		VarChar(32),
	@TranDate	SmallDateTime,
	@TranDesc	VarChar(30),
	@TranType	Char(2),
	@ProcessName	Varchar(8),
	@UserName	Varchar(10),
	@UserAddress	Varchar(21),
	@NegQty		Bit,
        @BalanceType	Char(1),
	@BaseCuryID	Char(4),
	@GLPostOpt	Char(1),
	@LedgerID	Char(10),
	@Valid_AcctSub	SmallInt,
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	Set NoCount On
	/*
	This procedure posts records into GLTran in either a detail or a
	summary fashion from the GL Work Table (Wrk10400_GLTran) for the
	current Inventory Batch. Once the records for the current batch
	have been posted to GLTran from the GL Work Table, the records are
	deleted from the work table for the current batch.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt,
		@LineID		Integer,
		@RowCnt		Integer,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@RowCnt		= 0,
		@ReturnStatus	= @True

	Select	@GLPostOpt	= 'S',
		@TranDesc = 'Summary Release'
	From	Account
	Where	Acct = @Acct And SummPost = 'Y'

	Declare	@EditScrnNbr	Varchar (5)
	If @GLPostOpt = 'S'
		Select	@EditScrnNbr = EditScrnNbr
		From	Batch (Nolock)
		Where	Module = 'IN' And BatNbr = @BatNbr

	If @Valid_AcctSub = 1
	Begin
		Select	@RowCnt = Count(*)
			From	vs_AcctSub
			Where	CpnyID = @CpnyID
				And Acct = @Acct
				And Sub = @Sub
				And Active = 1
		If	@RowCnt = 0
		Begin
			Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, MsgNbr,
				ParmCnt, Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'SCM_Insert_GLTran', 16070,
				3, @Acct, @Sub, @CpnyID)
			Goto Abort
		End
	End

	Exec	SCM_10400_GLTran_NextLineID @Module, @BatNbr, @CpnyID, @LineID OutPut
	Select @SQLErrNbr = @@Error
	IF @SQLErrNbr <> 0
	BEGIN
		INSERT 	INTO IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
			VALUES
				(@BatNbr, @UserAddress, 'SCM_10400_GLTran_NextLineID', @SQLErrNbr)
		GOTO Abort
	End

	IF @GLPostOpt = 'D'
	Begin
/*	Detail Post	*/
		Insert	Into GLTran
			(Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr,
			CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
			CuryCrAmt, CuryDrAmt, CuryEffDate, CuryID, CuryMultDiv,
			CuryRate, CuryRateType, DrAmt, EmployeeID, ExtRefNbr,
			FiscYr, IC_Distribution, ID, JrnlType, Labor_Class_Cd,
			LedgerID, LineID, LineNbr, LineRef, LUpd_DateTime,
			LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct,
			OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID,
			PC_Status, PerEnt, PerPost, Posted, ProjectID,
			Qty, RefNbr, RevEntryOption, Rlsed, S4Future01,
			S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
			S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
			S4Future12, ServiceDate, Sub, TaskID, TranDate,
			TranDesc, TranType, Units, User1, User2,
			User3, User4, User5, User6, User7,
			User8)
		Select	@Acct, '', @BalanceType, @BaseCuryID, @BatNbr,
			Batch.CpnyID, @CrAmt, GetDate(), @ProcessName, @UserName,
			@CrAmt, @DrAmt, '',
			Case When Len(RTrim(Batch.CuryID)) = 0 Then @BaseCuryID Else Batch.CuryID End,
			'M', 1, Batch.CuryRateType, @DrAmt, '', '',
			SUBSTRING(Batch.PerPost,1,4), 0, '', @JrnlType, '',
			@LedgerID, @LineID, (-32769 + @LineID),
			RIGHT(REPLICATE('0', 5) + RTRIM(CAST(@LineID AS VARCHAR(5))), 5), GetDate(),
			@ProcessName, @UserName, 'IN', 0, '',
			'', '', '', '', '',
			'', Batch.PerEnt, Batch.PerPost, 'U', @ProjectID,
                @Qty, @RefNbr, '', 0, '',
			'', 0, 0, 0, 0,
			'', '', 0, 0, '',
			'', '', @Sub, @TaskID, @TranDate,
			@TranDesc, @Trantype, 0, '', '',
			0, 0, '', '', '',
			''
			From	Batch (NoLock)
			Where	BatNbr = @BatNbr
				And Module = @Module
				And (@CrAmt <> 0
				Or @DrAmt <> 0)

		Select @SQLErrNbr = @@Error
		IF @SQLErrNbr <> 0
		BEGIN
			INSERT 	INTO IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
				VALUES
					(@BatNbr, @UserAddress, 'SCM_Insert_GLTran', @SQLErrNbr)
			GOTO Abort
		End
	End
/*	Summary Post	*/
	If @GLPostOpt = 'S'
	Begin
		If Exists(	Select	BatNbr
					From	GLTran (NoLock)
					Where	Acct = @Acct
						And BatNbr = @BatNbr
						And CpnyID = @CpnyID
						And BaseCuryID = @BaseCuryID
						And ((@DrCR = 'D' And DrAmt > 0)
						Or (@DrCr = 'C' And CrAmt > 0))
						And Sub = @Sub
						And TranType = @TranType
						And (RefNbr = @RefNbr Or @EditScrnNbr NOT IN('10050','11010')))
		Begin
			Update	GLTran
				Set	CrAmt = Case	When	@DrCr = 'C'
								Then	Round(CrAmt + @CrAmt, @BaseDecPl)
							Else
								CrAmt
						End,
					DrAmt =	Case	When	@DrCr = 'D'
								Then	Round(DrAmt + @DrAmt, @BaseDecPl)
							Else
								DrAmt
						End,
					CuryCrAmt = 	Case	When	@DrCr = 'C'
									Then	Round(CuryCrAmt + @CrAmt, @BaseDecPl)
								Else
									CuryCrAmt
							End,
					CuryDrAmt =	Case	When	@DrCr = 'D'
									Then	Round(CuryDrAmt + @DrAmt, @BaseDecPl)
								Else
									CuryDrAmt
							End,
					Qty = Round(Qty + @Qty, @DecPlQty)
				Where	Acct = @Acct
					And BatNbr = @BatNbr
					And CpnyID = @CpnyID
					And BaseCuryID = @BaseCuryID
					And ((@DrCR = 'D' And DrAmt > 0)
					Or (@DrCr = 'C' And CrAmt > 0))
					And Sub = @Sub
					And TranType = @TranType
					And (RefNbr = @RefNbr Or @EditScrnNbr NOT IN('10050','11010'))

			Select @SQLErrNbr = @@Error
			IF @SQLErrNbr <> 0
			BEGIN
				INSERT 	INTO IN10400_RETURN
						(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
					VALUES
						(@BatNbr, @UserAddress, 'SCM_Insert_GLTran', @SQLErrNbr)
				GOTO Abort
			End
		End
		Else
		Begin
			Insert	Into GLTran
				(Acct, AppliedDate, BalanceType, BaseCuryID, BatNbr,
				CpnyID, CrAmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
				CuryCrAmt, CuryDrAmt, CuryEffDate, CuryID, CuryMultDiv,
				CuryRate, CuryRateType, DrAmt, EmployeeID, ExtRefNbr,
				FiscYr, IC_Distribution, ID, JrnlType, Labor_Class_Cd,
				LedgerID, LineID, LineNbr, LineRef, LUpd_DateTime,
				LUpd_Prog, LUpd_User, Module, NoteID, OrigAcct,
				OrigBatNbr, OrigCpnyID, OrigSub, PC_Flag, PC_ID,
				PC_Status, PerEnt, PerPost, Posted, ProjectID,
				Qty, RefNbr, RevEntryOption, Rlsed, S4Future01,
				S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
				S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
				S4Future12, ServiceDate, Sub, TaskID, TranDate,
				TranDesc, TranType, Units, User1, User2,
				User3, User4, User5, User6, User7,
				User8)
			Select	@Acct, '', @BalanceType, @BaseCuryID, @BatNbr,
				Batch.CpnyID, @CrAmt, GetDate(), @ProcessName, @UserName,
				@CrAmt, @DrAmt, '',
				Case When Len(RTrim(Batch.CuryID)) = 0 Then @BaseCuryID Else Batch.CuryID End,
				'M', 1, Batch.CuryRateType, @DrAmt, '', '',
				SUBSTRING(Batch.PerPost,1,4), 0, '', @JrnlType, '',
				@LedgerID, @LineID, (-32769 + @LineID),
				RIGHT(REPLICATE('0', 5) + RTRIM(CAST(@LineID AS VARCHAR(5))), 5), GetDate(),
				@ProcessName, @UserName, 'IN', 0, '',
				'', '', '', '', '',
				'', Batch.PerEnt, Batch.PerPost, 'U', @ProjectID,
	                        @Qty, @RefNbr, '', 0, '',
				'', 0, 0, 0, 0,
				'', '', 0, 0, '',
				'', '', @Sub, @TaskID, @TranDate,
				@TranDesc, @Trantype, 0, '', '',
				0, 0, '', '', '',
				''
				From	Batch (NoLock)
				Where	BatNbr = @BatNbr
					And Module = @Module
					And (@CrAmt <> 0
					Or @DrAmt <> 0)
				Select @SQLErrNbr = @@Error
			IF @SQLErrNbr <> 0
			BEGIN
				INSERT 	INTO IN10400_RETURN
						(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
					VALUES
						(@BatNbr, @UserAddress, 'SCM_Insert_GLTran', @SQLErrNbr)
				GOTO Abort
			End
		End
	End

GOTO Finish

Abort:
	RETURN @False

Finish:

	RETURN @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Insert_GLTran] TO [MSDSL]
    AS [dbo];

