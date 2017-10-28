 Create Procedure DMG_Delete_WRK10400_GLTRAN
	@BatNbr			Varchar(10),
	@Module   		Char(2)

As
	Set NoCount On
	/*
	All of the parameters being passed to this procedure are parts of the
	table's primary key.  This procedure will use those parameters to delete
	a record that exists matching the primary key.  If a record does not
	exist matching the primary key, nothing will be Deleted.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
		The return value needs to be captured and evaluated by the calling process.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	Delete	From	WRK10400_GLTRAN
		Where	BatNbr = @BatNbr
			And Module = @Module

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(S4Future01, SQLErrorNbr)
			Values
				('DMG_Delete_WRK10400_GLTRAN', @SQLErrNbr)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


