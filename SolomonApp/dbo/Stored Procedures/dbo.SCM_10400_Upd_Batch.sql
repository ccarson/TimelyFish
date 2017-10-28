 Create Procedure SCM_10400_Upd_Batch
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	@BaseDecPl		SmallInt,
	@BMIDecPl		SmallInt,
	@DecPlPrcCst		SmallInt,
	@DecPlQty		SmallInt,
	@NegQty			Bit,
	@Module			Char(2),
	@COGSBatch		Bit,
	@CpnyID			Char(10),
	@CRTot			Float,
	@DRTot			Float,
	@GLPostOpt 		Char(1),
	@LedgerID		Char(10),
	@BalanceType		Char(1),
	@PerNbr			Char(6),
	@UpdateGL		SmallInt,
	@Rlsed			Smallint
As
	Set	NoCount On

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@ReturnStatus	= @True

	Declare	@BaseCuryID	Char(4)
	Select	@BaseCuryID = ''
	Select	@BaseCuryID = COALESCE(l.BaseCuryID, s.BaseCuryID)
	From	GLSetup s (NOLOCK) LEFT JOIN Ledger l (NOLOCK) ON l.LedgerID = s.LedgerID

	DECLARE @savedDRTot FLOAT
	SELECT @savedDRTot = DrTot FROM Batch WHERE Module = @Module AND BatNbr = @BatNbr

	/*
	Update Batch record where BatNbrquals equals @BatNbr and Module equals @Module
	*/
	Update	Batch
		Set	BalanceType = @BalanceType,
			CpnyId = @CpnyId,
			CrTot =  Case When @CrTot > 0 Then @CrTot Else CrTot End,
			CuryCRTot = Case When @CrTot > 0 Then @CrTot Else CuryCRTot End,
			CuryDrTot = Case When @DrTot > 0 Then @DrTot Else CuryDrTot End,
			CuryCtrlTot = Case When @DrTot > 0 Then @DrTot Else CuryCtrlTot End,
			CtrlTot = Case When @DrTot > 0 Then @DrTot Else CtrlTot End,
                        DrTot =  Case When @DrTot > 0 Then @DrTot Else DrTot End,
			GLPostOpt = @GLPostOpt,
			LedgerID = @LedgerID,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName,
                        PerEnt = Case When @COGSBatch = @True Then @PerNbr Else PerEnt End,
                        PerPost = Case When @COGSBatch = @True Then @PerNbr Else PerPost End,
			S4Future07 = Case When @Rlsed = @True Then GetDate() Else S4Future07 End,
			Rlsed = @Rlsed,
			Status =	Case	When	@Rlsed = 0
							Then	Status
						When	@Rlsed = 1 And @UpdateGL = 1
							Then	Case	When	Round(DrTot + @DrTot, @BaseDecPl) > 0
										Then	'U'
									Else	'C'
								End
						Else	'C'
					End,
			BaseCuryID = Case BaseCuryID When '' Then @BaseCuryID Else BaseCuryID End,
			CuryID = Case CuryID When '' Then @BaseCuryID Else CuryID End,
			CuryMultDiv = Case CuryMultDiv When '' Then 'M' Else CuryMultDiv End,
			CuryRate = Case CuryRate When 0 Then 1 Else CuryRate End
		Where	Module = @Module
			And BatNbr = @BatNbr

	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'SCM_10400_Upd_Batch', @SQLErrNbr, 2,
				 @BatNbr, @Module)
		Goto Abort
	End

	IF @savedDrTot IS NOT NULL
		IF @Rlsed = 1 AND @UpdateGL = 1 AND Round(@savedDrTot + @DrTot, @BaseDecPl) > 0
			UPDATE GLTran
			SET Rlsed = 1
			WHERE BatNbr = @BatNbr AND Module = 'IN'

/*
	Balanced Batch check.

	If Batch has been released, check to find the Solomon error.
*/
	If	Exists(Select	Module
				From	Batch (NoLock)
				Where	Module = @Module
					And BatNbr = @BatNbr
					And CpnyID = @CpnyID
					And Rlsed = 1
					And Round(CrTot, @BaseDecPl) <> Round(DrTot, @BaseDecPl))
	Begin
		If @COGSBatch = @True
		Begin
			/*
			Solomon Error Message
			*/
			Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
				ParmCnt, Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'SCM_10400_Upd_Batch', @SQLErrNbr, 16075,
				2, @BatNbr, @Module)
			Goto Abort
		End
		Else
		Begin
			/*
			Solomon Error Message
			*/
			Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
				ParmCnt, Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'SCM_10400_Upd_Batch', @SQLErrNbr, 16074,
				2, @BatNbr, @Module)
			Goto Abort
		End
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


