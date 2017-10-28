 Create Procedure DMG_10400_Upd_TrnsfrDoc
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
	@TrnsfrDocNbr		Varchar(25),
	@CpnyID			Varchar(10),
	/*End Primary Key Parameter Group*/
	/*Begin Values Parameter Group*/
	@Status     		Char(1)
	/*End Values Parameter Group*/
As
	Set NoCount On
	/*
	Parameters are grouped together functionally.

	This procedure will update the released status for the record matching the primary
	key fields passed as parameters.

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

	Execute	@ReturnStatus = DMG_Insert_TrnsfrDoc	@TrnsfrDocNbr, @CpnyID, @ProcessName, @UserName
	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_TrnsfrDoc', @SQLErrNbr, 2,
				 @TrnsfrDocNbr, @CpnyID)
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_TrnsfrDoc', @SQLErrNbr, 2,
				 @TrnsfrDocNbr, @CpnyID)
		Goto Abort
	End

	/*
	Transfer Status will be checked to see that it falls in one of three pre-defined
	types: P;Pending, I;In Transit, R; Received. A status type different than these
	will return an error message.
	*/
	If @Status NOT IN ('P', 'I', 'R')
	Begin
	/*
	Solomon Error Message
	*/
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
				Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_TrnsfrDoc', 16085, 3,
				@TrnsfrDocNbr, @Status, @CpnyID)
		Goto Abort
	End

	/*
	Update the status.
	*/
	Update	TrnsfrDoc
		Set	Status = @Status,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName
		Where	TrnsfrDocNbr = @TrnsfrDocNbr
			And CpnyID = @CpnyID

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_TrnsfrDoc', @SQLErrNbr, 2,
				 @TrnsfrDocNbr, @CpnyID)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_Upd_TrnsfrDoc] TO [MSDSL]
    AS [dbo];

