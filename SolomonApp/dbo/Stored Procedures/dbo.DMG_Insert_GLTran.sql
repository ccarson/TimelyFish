 CREATE PROCEDURE DMG_Insert_GLTran
	/*Begin Process Parameter Group*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	@DecPlQty		SmallInt,
	@DecPlPrcCst		SmallInt,
	@NegQty			Bit,
	/*End Process Parameter Group*/
	/*Begin Primary Key Parameter Group*/
	/*@BatNbr		Varchar(10), is already included as part of the Parameter group*/
	@Module			Char(2),
	/*End Primary Key Parameter Group*/
	/*Begin Values Parameter Group*/
        @BalanceType            Char(1),
	@BaseCuryID	        Char(4),
	@CpnyID			VarChar(10),
	@GLPostOpt		Char(1),
	@JrnlType		Char(3),
	@LedgerID               Char(10)
	/*End Values Parameter Group*/
As
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
		@LineID		SmallInt,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@LineID		= 1,
		@ReturnStatus	= @True

	/*Declare Variables for cursor use*/

	Declare @c_Acct		Char(10),
		@c_CpnyID	Char(10),
	        @c_CrAmt	Float,
		@c_CuryID	Char(4),
	        @c_DrAmt	Float,
	        @c_DrCr		Char(1),
	        @c_Module 	Char(2),
	        @c_ProjectID	Char(16),
	        @c_Qty		Float,
	        @c_RefNbr   	Char(10),
	        @c_Sub		Char(24),
	        @c_TaskID	Char(32),
	        @c_TranDesc 	Char(30),
	        @c_TranType	Char(2)

	IF @GLPostOpt = 'D'
	BEGIN
		/*
		Detail Post
		Creates a record for every record in the GL Work Table (WRK10400_GLTRAN)
		for the current batch.
		*/
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
		Select	GLWork.Acct, '', @BalanceType, @BaseCuryID, GLWork.BatNbr,
			Batch.CpnyID, GLWork.CrAmt, GetDate(), @ProcessName, @UserName,
			GLWork.CrAmt, GLWork.DrAmt, '',
			Case When Len(RTrim(Batch.CuryID)) = 0 Then @BaseCuryID Else Batch.CuryID End,
			'M', 1, Batch.CuryRateType, GLWork.DrAmt, '', '',
			SUBSTRING(Batch.PerPost,1,4), 0, '', GLWork.JrnlType, '',
			@LedgerID, (-32769 + GLWork.LineID), GLWork.LineID,
			RIGHT(REPLICATE('0', 5) + RTRIM(CAST(GLWork.LineID AS VARCHAR(5))), 5), GetDate(),
			@ProcessName, @UserName, 'IN', 0, '',
			'', '', '', '', '',
			'', Batch.PerEnt, Batch.PerPost, 'U', GLWork.ProjectID,
                        GLWork.Qty, GLWork.RefNbr, '', 1, '',
			'', 0, 0, 0, 0,
			'', '', 0, 0, '',
			'', '', GLWork.Sub, GLWork.TaskID, GLWork.TranDate,
			GLWork.TranDesc, GLWork.Trantype, 0, '', '',
			0, 0, '', '', '',
			''
			From	Wrk10400_GLTran GLWork Join Batch
				On GLWork.BatNbr = Batch.BatNbr
				And GLWork.Module = Batch.Module
			Where	GLWork.BatNbr = @BatNbr
				And GLWork.Module = @Module
				And (GLWork.CrAmt <> 0
				Or GLWork.DrAmt <> 0)

		Select @SQLErrNbr = @@Error
		IF @SQLErrNbr <> 0
		BEGIN
			INSERT 	INTO IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
				VALUES
					(@BatNbr, @UserAddress, 'DMG_Insert_GLTran', @SQLErrNbr)
			GOTO Abort
		End
	End
	If @GLPostOpt = 'S'
	Begin
		/*
		Summary Post
		Creates summarized records from the record in the GL Work Table (WRK10400_GLTRAN)
		for the current batch.
		*/
    		If Cursor_Status('Local', 'GLTran_Cursor') > 0
		Begin
			Close GLTran_Cursor
			Deallocate GLTran_Cursor
		End
		Declare	GLTran_Cursor CURSOR LOCAL FOR
			Select	GL.Acct, GL.CpnyID, Sum(GL.CrAmt), Batch.CuryID, Sum(GL.DrAmt),
				GL.DrCr, GL.ProjectID, Sum(GL.Qty), GL.RefNbr, GL.Sub,
				GL.TaskID, GL.TranDesc, GL.TranType
				From	Wrk10400_GLTran GL Join Batch
					On GL.BatNbr = Batch.BatNbr
					And GL.CpnyID = Batch.CpnyID
					And GL.Module = Batch.Module
				Where	GL.BatNbr = @BatNbr
					And GL.CpnyID = @CpnyID
					And GL.Module = @Module
					And (GL.CrAmt <> 0
					Or GL.DrAmt <> 0)
				Group By GL.Acct, GL.CpnyID, Batch.CuryID, GL.DrCr, GL.ProjectID,
					GL.Qty, GL.RefNbr, GL.Sub, GL.TaskID, GL.TranDesc,
					GL.TranType
		Open GLTran_Cursor
		Fetch Next From GLTran_Cursor Into @c_Acct, @c_CpnyID, @c_CrAmt, @c_CuryID, @c_DrAmt,
			@c_DrCr, @c_ProjectID, @c_Qty, @c_RefNbr, @c_Sub,
			@c_TaskID, @c_TranDesc, @c_TranType
		While (@@Fetch_Status = 0)
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
			Select	@c_Acct, '', @BalanceType, @BaseCuryID, Batch.BatNbr,
				Batch.CpnyID, @c_CrAmt, GetDate(), @ProcessName, @UserName,
				@c_CrAmt, @c_DrAmt, '',
				Case When Len(RTrim(Batch.CuryID)) = 0 Then @BaseCuryID Else Batch.CuryID End,
				'M', 1, Batch.CuryRateType, @c_DrAmt, '', '',
				SUBSTRING(Batch.PerPost,1,4), 0, '', Batch.JrnlType, '',
				@LedgerID, (-32769 + @LineID), @LineID,
				RIGHT(REPLICATE('0', 5) + RTRIM(CAST(@LineID AS VARCHAR(5))), 5), GetDate(),
				@ProcessName, @UserName, 'IN', 0, '',
				'', '', '', '', '',
				'', Batch.PerEnt, Batch.PerPost, 'U', @c_ProjectID,
                        	@c_Qty, @c_RefNbr, '', 1, '',
				'', 0, 0, 0, 0,
				'', '', 0, 0, '',
				'', '', @c_Sub, @c_TaskID, GetDate(),
				@c_TranDesc, @c_Trantype, 0, '', '',
				0, 0, '', '', '',
				''
				From	Batch
				Where	Batch.BatNbr = @BatNbr
					And Batch.Module = @Module
					And Batch.CpnyID = @CpnyID

			Select @SQLErrNbr = @@Error
			IF @SQLErrNbr <> 0
			BEGIN
				INSERT 	INTO IN10400_RETURN
						(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
					VALUES
						(@BatNbr, @UserAddress, 'DMG_Insert_GLTran', @SQLErrNbr)
				GOTO Abort
			END
			Select @LineID = @LineID +1
			Fetch Next From GLTran_Cursor Into @c_Acct, @c_CpnyID, @c_CrAmt, @c_CuryID, @c_DrAmt,
				@c_DrCr, @c_ProjectID, @c_Qty, @c_RefNbr, @c_Sub,
				@c_TaskID, @c_TranDesc, @c_TranType
		End
		Close GLTran_Cursor
		Deallocate GLTran_Cursor
	End
	Execute	@ReturnStatus = DMG_Delete_WRK10400_GLTRAN	@BatNbr, @Module
	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		INSERT 	INTO IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
			VALUES
				(@BatNbr, @UserAddress, 'DMG_Insert_GLTran', @SQLErrNbr)
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		INSERT 	INTO IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
			VALUES
				(@BatNbr, @UserAddress, 'DMG_Insert_GLTran', @SQLErrNbr)
		Goto Abort
	End

GOTO Finish

Abort:
	IF Cursor_Status('Local', 'GLTran_Cursor') > 0
	BEGIN
		CLOSE GLTran_Cursor
		DEALLOCATE GLTran_Cursor
	END
	RETURN @False

Finish:

	RETURN @True


