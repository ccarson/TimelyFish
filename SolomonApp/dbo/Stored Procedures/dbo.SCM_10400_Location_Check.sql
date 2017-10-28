 Create Procedure SCM_10400_Location_Check
	/*Begin Process Parameter Group*/
	@BatNbr			VarChar(10),
	@ProcessName		VarChar(8),
	@UserName		VarChar(10),
	@UserAddress		VarChar(21),
	@InvtID			VarChar(21),
	@ClassID		VarChar(6),
	/*End Process Parameter Group*/
	/*Begin Primary Key Parameter Group*/
	@SiteID			VarChar(10),
	@WhseLoc		VarChar(10)
	/*End Primary Key Parameter Group*/
As
	Set Nocount ON
	Declare	@InclQtyAvail	SmallInt
	Set	@InclQtyAvail = 1	/* Default */

	/*
	Created:	4/06/2000
	Created BY:	Distribution Management Group, Solomon Software

	Determines if the inventory item (INVTID) for the current record
	is a valid inventory item for this warehouse bin location (SITEID, WHSELOC).

	Parameters are grouped together functionally.

	Automatically determines if record to be updated exists.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
		The return value needs to be captured and evaluated by the calling process.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@ReturnStatus	= @True

	Execute	@ReturnStatus = DMG_Insert_LocTable	@SiteID, @WhseLoc, @ProcessName, @UserName
	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'SCM_10400_Location_Check', @SQLErrNbr, 2,
			         @SiteID, @Whseloc)
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'SCM_10400_Location_Check', @SQLErrNbr, 3,
			         @InvtID, @SiteID, @Whseloc)
		Goto Abort
	End
	/*
	Solomon Error Message
	*/
	Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
			ParmCnt, Parm00, Parm01, Parm02)
		Select	@BatNbr, @UserAddress, 'SCM_10400_Location_Check', @SQLErrNbr, 16087,
			3, @InvtID, @SiteID, @Whseloc
			From	LocTable (NoLock)
			Where	SiteID = @SiteID
				And Whseloc = @Whseloc
				And InvtIDValid = 'Y'
				And InvtID <> @InvtID

	/*
	Solomon Error Message
	*/
	Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
			ParmCnt, Parm00, Parm01, Parm02)
		Select	@BatNbr, @UserAddress, 'SCM_10400_Location_Check', @SQLErrNbr, 16094,
			3, @SiteID, @Whseloc, @InvtID
			From	LocTable (NoLock) Inner Join Inventory (NoLock)
				On LocTable.InvtID = Inventory.InvtID
			Where	LocTable.SiteID = @SiteID
				And LocTable.Whseloc = @Whseloc
				And LocTable.InvtIDValid = 'A'
				And Inventory.ClassID <> @ClassID

	Select	@InclQtyAvail = InclQtyAvail
		From	LocTable (NoLock)
		Where	LocTable.SiteID = @SiteID
			And LocTable.Whseloc = @Whseloc

Goto Finish

Abort:
	Select	@InclQtyAvail
	Return @False

Finish:
	Select	@InclQtyAvail
	Return @True


