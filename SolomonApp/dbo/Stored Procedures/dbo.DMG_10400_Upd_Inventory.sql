 Create Procedure DMG_10400_Upd_Inventory
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
	@InvtID			Varchar(30),
	/*End Primary Key Parameter Group*/
	/*Begin Decrease Values Parameter Group*/
	@BMILastCost		Float,
	@LastCost     		Float
	/*End Decrease Values Parameter Group*/
As
	Set NoCount On
	/*
	Parameters are grouped together functionally.

	This procedure will update the quantity on hand (QTYONHAND) and quantity shipped
	not invoiced for the record matching the primary key fields passed as parameters.
	The primary key fields in the Inventory table define a specific warehouse storage
	Inventory.

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

	Execute	@ReturnStatus = DMG_Insert_Inventory	@InvtID, @ProcessName, @UserName
	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Inventory', @SQLErrNbr, 1,
			         @InvtID)
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Inventory', @SQLErrNbr, 1,
				 @InvtID)
		Goto Abort
	End

	/*
	Update Last Cost if value is greater than zero.
	*/
	Update	Inventory
		Set	BMILastCost = 	Case 	When @BMILastCost > 0
							Then @BMILastCost
						Else BMILastCost
					End,
			LastCost = Case When @LastCost > 0
					Then @LastCost
					Else LastCost
				   End,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName
		Where	InvtID = @InvtID

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Inventory', @SQLErrNbr, 1,
				 @InvtID)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_Upd_Inventory] TO [MSDSL]
    AS [dbo];

