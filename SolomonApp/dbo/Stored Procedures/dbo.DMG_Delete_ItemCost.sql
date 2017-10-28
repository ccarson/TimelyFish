 Create Procedure DMG_Delete_ItemCost
	@InvtID			Varchar(30),
	@SiteID			Varchar(10),
	@LayerType		Char(2),
	@SpecificCostID		Varchar(25),
	@RcptNbr		Varchar(15),
	@RcptDate		SmallDateTime
As
	Set NoCount On
	/*
	Created:	3/30/2000
	Created BY:	Distribution Management Group, Solomon Software

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

	If Exists (	Select	*
				From	ItemCost
				Where	InvtID = @InvtID
					And SiteID = @SiteID
					And LayerType = @LayerType
					And SpecificCostID = @SpecificCostID
					And RcptNbr = @RcptNbr
					And RcptDate = @RcptDate)
	Begin
		Delete	From	ItemCost
			Where	InvtID = @InvtID
				And SiteID = @SiteID
				And LayerType = @LayerType
				And SpecificCostID = @SpecificCostID
				And RcptNbr = @RcptNbr
				And RcptDate = @RcptDate
		Select @SQLErrNbr = @@Error
		If @SQLErrNbr <> 0
		Begin
			Insert 	Into IN10400_RETURN
					(S4Future01, SQLErrorNbr)
				Values
					('DMG_Delete_ItemCost', @SQLErrNbr)
			Goto Abort
		End
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


