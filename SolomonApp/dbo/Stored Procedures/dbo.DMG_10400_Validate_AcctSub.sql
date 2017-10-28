 Create Procedure DMG_10400_Validate_AcctSub
	/*Begin Parameters*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	@Module			Varchar(30),
	@CpnyId   		Varchar(10)
	/*End Parameters*/

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	SET NoCount On
	/*
	This procedure will be used to validate account and sub-account combinations that
	are to be written into GLTran.  This procedure will only be called if the account/sub account
	validation option is selected within the GL setup screen.
	*/
DECLARE	@Acct			Varchar(10),
	@Sub            	Varchar(24),
	@SQLErrorNbr		SmallInt
SELECT	@Acct			= '',
	@Sub			= '',
	@SQLErrorNbr		= 0

Declare	@True		Bit,
	@False		Bit
Select	@True 		= 1,
	@False 		= 0

If Cursor_Status('Local', 'Status_Cursor') > 0
Begin
	Close Status_Cursor
	Deallocate Status_Cursor
End
Declare	Status_Cursor Cursor Local For
	Select	Acct, Sub
		From	Wrk10400_GLTran
		Where	BatNbr = @BatNbr
			And Module = @Module
			And CpnyID = @CpnyID
		Group By Acct, Sub
Open Status_Cursor
Fetch Next From Status_Cursor Into @Acct, @Sub
While (@@Fetch_Status = 0)
Begin
	IF Not Exists(	Select	*
				From vs_AcctSub
				Where	Acct = @Acct
					And Sub = @Sub
					And CpnyID = @CpnyID
					And Active = 1)
	Begin
		/*
		Solomon Error Message
		*/
		Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
			ParmCnt, Parm00, Parm01, Parm02)
		Values
			(@BatNbr, @UserAddress, 'DMG_10400_Validate_AcctSub', @SQLErrorNbr, 16070,
			3, @Acct, @Sub, @CpnyID)
		Goto Abort
	End
	Fetch Next from Status_Cursor INTO @Acct, @Sub
End
Close Status_Cursor
Deallocate Status_Cursor

Goto Finish

Abort:
	If Cursor_Status('Local', 'Status_Cursor') > 0
	Begin
		Close Status_Cursor
		Deallocate Status_Cursor
	End
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_Validate_AcctSub] TO [MSDSL]
    AS [dbo];

