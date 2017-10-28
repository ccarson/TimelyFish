 Create Procedure DMG_10400_Upd_AssyDoc
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
	@KitID			Varchar(30),
	@RefNbr			Varchar(15),
	/* @BatNbr		Varchar(10), is already included as part of the Parameter group */
	@CpnyID			Varchar(10),
	/*End Primary Key Parameter Group*/
	/*Begin Values Parameter Group*/
	@Rlsed    		Smallint
	/*End Values Parameter Group*/
As
	Set NoCount On
	/*
	Parameters are grouped together functionally.

	This procedure will update Rlsed flag for the record matching the primary key
	fields passed as parameters.

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

	Execute	@ReturnStatus = DMG_Insert_AssyDoc	@KitID, @RefNbr, @BatNbr, @CpnyID, @ProcessName, @UserName
	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
 	    			 Parm00, Parm01, Parm02, Parm03)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_AssyDoc', @SQLErrNbr, 4,
				 @KitID, @RefNbr, @BatNbr, @CpnyID)
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		 		 Parm00, Parm01, Parm02, Parm03)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_AssyDoc', @SQLErrNbr, 4,
				 @KitID, @RefNbr, @BatNbr, @CpnyID)
		Goto Abort
	End

	/*
	Update the released status.
	*/
	Update	AssyDoc
		Set	Rlsed = @Rlsed,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName
		Where	KitID = @KitID
			And RefNbr = @RefNbr
			And BatNbr = @BatNbr
			And CpnyID = @CpnyID

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
 				 Parm00, Parm01, Parm02, Parm03)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_AssyDoc', @SQLErrNbr, 4,
				 @KitID, @RefNbr, @BatNbr, @CpnyID)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_Upd_AssyDoc] TO [MSDSL]
    AS [dbo];

