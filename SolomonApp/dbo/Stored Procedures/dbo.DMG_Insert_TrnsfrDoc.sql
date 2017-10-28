 Create Procedure DMG_Insert_TrnsfrDoc
	@TrnsfrDocNbr		Varchar(10),
	@CpnyID			Varchar(10),
	@Crtd_Prog		Varchar(8),
	@Crtd_User		Varchar(10)
As
	Set NoCount On
	/*
	All of the parameters being passed to this procedure are parts of the
	table's primary key except @Crtd_Prog and @Crtd_User.  This procedure will
	use those parameters to determine if a record already exists matching
	the primary key.  If a record does not exist matching the primary key,
	a record will be inserted.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	If Not Exists (	Select	*
				From	TrnsfrDoc
				Where	TrnsfrDocNbr = @TrnsfrDocNbr
					And CpnyID = @CpnyID)

	Begin
		Insert Into	TrnsfrDoc
				(TrnsfrDocNbr, CpnyID, Crtd_Prog, Crtd_User, LUpd_DateTime,
				 LUpd_Prog, LUpd_User)
			Values
				(@TrnsfrDocNbr, @CpnyID, @Crtd_Prog, @Crtd_User, Convert(SmallDateTime, GetDate()),
				 @Crtd_Prog, @Crtd_User)

		Select @SQLErrNbr = @@Error
		If @SQLErrNbr <> 0
		Begin
			Insert 	Into IN10400_RETURN
					(S4Future01, SQLErrorNbr)
				Values
					('DMG_Insert_TrnsfrDoc', @SQLErrNbr)
			Goto Abort
		End
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


