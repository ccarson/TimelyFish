 Create Procedure DMG_10400_Upd_Batch
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
	/*@BatNbr is already part of the key */
	@Module			Char(2),
	/*End Primary Key Parameter Group*/
	/*Begin Decrease Values Parameter Group*/
	@COGSBatch		Bit,
	@CpnyID			Char(10),
	@CRTot			Float,
	@DRTot			Float,
	@GLPostOpt 		Char(1),
	@LedgerID		Char(10),
	@PerNbr			Char(6),
	@Rlsed			Smallint,
	@Status			Char(1)
	/*End Decrease Values Parameter Group*/
As
	Set NoCount On
	/*
	Parameters are grouped together functionally.

	This procedure will update the batch record with the required fields.

	Automatically determines if record to be updated exists.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@ReturnStatus	= @True

	Declare	@BalanceType	Char(1)
	Select	@BalanceType = BalanceType
		From	Ledger
		Where	LedgerID = @LedgerID
	/*
	Balanced Batch check.

	If Batch has been released, check to find the Solomon error.
	*/
	If @Rlsed = 1
	Begin
		If (Round(@CrTot, @DecPlQty) <> Round(@DrTot, @DecPlQty))
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
					(@BatNbr, @UserAddress, 'DMG_10400_Upd_Batch', @SQLErrNbr, 16075,
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
					(@BatNbr, @UserAddress, 'DMG_10400_Upd_Batch', @SQLErrNbr, 16074,
					2, @BatNbr, @Module)
				Goto Abort
			End
		End
	End
	/*
	Update Batch record where BatNbrquals equals @BatNbr and Module equals @Module
	*/
	UPDATE	Batch
		Set	BalanceType = @BalanceType,
			CpnyId = @CpnyId,
			CrTot =  @CrTot,
			CuryCRTot = @CrTot,
			CuryDrTot = @DrTot,
			CuryCtrlTot = @DrTot,
			CtrlTot = @DrTot,
                        DrTot =  @DrTot,
			GLPostOpt = @GLPostOpt,
			LedgerID = @LedgerID,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName,
                        PerEnt = Case When @COGSBatch = @True Then @PerNbr Else PerEnt End,
                        PerPost = Case When @COGSBatch = @True Then @PerNbr Else PerPost End,
			S4Future07 = Case When @Rlsed = @True Then GetDate() Else S4Future07 End,
			Rlsed = @Rlsed,
			Status = @Status
               From Batch
              Where BatNbr = @BatNbr
                And Module = @Module

	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Batch', @SQLErrNbr, 2,
				 @BatNbr, @Module)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


