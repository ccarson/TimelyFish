 Create Procedure DMG_Insert_WrkRelease
	@BatNbr			Varchar(10),
	@Module			Varchar(2),
	@UserAddress		Varchar(21)
As
	Set NoCount On
	/*
	Deletes any records within this work table that have the same Batch Number
	or User (Computer) Address.  Insert a new record into the Wrkrelease table.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	Insert Into WrkRelease
			(BatNbr, Module, UserAddress)
		Values
			(@BatNbr, @Module, @UserAddress)

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
			Values
				(@BatNbr, @UserAddress, 'DMG_Insert_WrkRelease', @SQLErrNbr)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Insert_WrkRelease] TO [MSDSL]
    AS [dbo];

