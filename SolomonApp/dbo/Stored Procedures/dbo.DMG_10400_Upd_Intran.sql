 Create Procedure DMG_10400_Upd_Intran
	/*Begin Process Parameter Group*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21)
	/*End Process Parameter Group*/

As
	Set NoCount On
	/*
	Parameters are grouped together functionally.

	This procedure will update the Released flag for the batch matching the
	batch number passed as a parameter.

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

	/*
	Update the released status.
	*/
	Update	Intran
		Set	Rlsed = 1,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName
		Where	BatNbr = @BatNbr
			And Rlsed = 0

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Intran', @SQLErrNbr, 1,
				 @BatNbr)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


