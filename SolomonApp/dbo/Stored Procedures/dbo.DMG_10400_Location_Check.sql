 Create Procedure DMG_10400_Location_Check
	/*Begin Process Parameter Group*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	@InvtID			Varchar(21),
	/*End Process Parameter Group*/
	/*Begin Primary Key Parameter Group*/
	@SiteID			Varchar(10),
	@WhseLoc		Varchar(10)
	/*End Primary Key Parameter Group*/
As
	Set NoCount On
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

	Declare	@ClassID	Varchar(6)
	Select	@ClassID = ClassID
		From	Inventory
		Where	InvtID = @InvtID

	Execute	@ReturnStatus = DMG_Insert_LocTable	@SiteID, @WhseLoc, @ProcessName, @UserName
	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Location_Check', @SQLErrNbr, 2,
			         @SiteID, @Whseloc)
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				 Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Location_Check', @SQLErrNbr, 3,
			         @InvtID, @SiteID, @Whseloc)
		Goto Abort
	End
	IF EXISTS(	Select	*
				From	LocTable
				Where	SiteID = @SiteID
					And Whseloc = @Whseloc
					And InvtIDValid = 'Y'
					And InvtID <> @InvtID)
	Begin
		/*
		Solomon Error Message
		*/
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
				ParmCnt, Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Location_Check', @SQLErrNbr, 16087,
				3, @InvtID, @SiteID, @Whseloc)
		Goto Abort
	End

	IF EXISTS(	Select	*
				From	LocTable Join Inventory
					On LocTable.InvtID = Inventory.InvtID
				Where	LocTable.SiteID = @SiteID
					And LocTable.Whseloc = @Whseloc
					And LocTable.InvtIDValid = 'A'
					And Inventory.ClassID <> @ClassID)
	Begin
		/*
		Solomon Error Message
		*/
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
				ParmCnt, Parm00, Parm01, Parm02)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Location_Check', @SQLErrNbr, 16094,
				3, @SiteID, @Whseloc, @InvtID)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_Location_Check] TO [MSDSL]
    AS [dbo];

