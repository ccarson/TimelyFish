 Create Procedure DMG_10400_Upd_ItemCost
	/*Begin Process Parameter Group*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	@BaseDecPl		SmallInt,
	@BMIDecPl		SmallInt,
	@DecPlQty		SmallInt,
	@DecPlPrcCst		SmallInt,
	@NegQty			Bit,
	@ValMthd		Char(1),
	/*End Process Parameter Group*/
	/*Begin Primary Key Parameter Group*/
	@InvtID			Varchar(30),
	@SiteID			Varchar(10),
	@LayerType		Char(2),
	@SpecificCostID		Varchar(25),
	@RcptNbr		Varchar(15),
	@RcptDate		SmallDateTime,
	/*End Primary Key Parameter Group*/
	/*Begin Update Values Parameter Group*/
	@Qty			Float,
	@QtyShipNotInv		Float,
	@BMITotCost		Float,
	@TotCost		Float
	/*End Update Values Parameter Group*/
As
	Set NoCount On
	/*
	Parameters are grouped together functionally. This procedure will update
	the layer quantity (QTY), total layer cost (TOTCOST) and recalculate the per unit cost
	(UNITCOST) for the record matching the primary key fields passed as parameters.
	If the layer quantity equals zero, the record for the layer matching the primary key
	fields passed as parameters will be deleted.  The per unit cost (UNITCOST) will be
	recalculated by rounding the result of the total layer cost (TOTCOST) divided by
	the layer quantity (QTY).

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
	Item Cost field variables.
	*/
	Declare	@IC_Qty		DEC(25,9),
		@IC_TotCost	DEC(28,3),
		@IC_UnitCost	DEC(25,9)
	Select	@IC_Qty		= 0,
		@IC_TotCost	= 0,
		@IC_UnitCost	= 0
	/*
	Check for missing Specific Cost ID value if valuation method is specific cost.
	*/
	If @ValMthd = 'S'
	Begin
		If DataLength(RTrim(@SpecificCostID)) = 0
		Begin
		/*
		Solomon Error Message
		*/
			Insert 	Into IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
					ParmCnt, Parm00, Parm01, Parm02)
				Values
					(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 16084,
					3, @InvtID, @SiteID, @SpecificCostID)
			Goto Abort
		End
	End

	Execute	@ReturnStatus = DMG_Insert_ItemCost 	@InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptNbr,
							@RcptDate, @ProcessName, @UserName
	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04,
				Parm05)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 6,
				@InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptNbr,
				Convert(Char(30), @RcptDate))
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04,
				Parm05)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 6,
				@InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptNbr,
				Convert(Char(30), @RcptDate))
		Goto Abort
	End
	/*
	Retrieves the current costing layers quantity and total cost into variables.
	*/
	Select	@IC_Qty = Round(CONVERT(DEC(25,9),Qty), @DecPlQty),
		@IC_TotCost = Round(CONVERT(DEC(28,3),TotCost), @BaseDecPl),
		@IC_UnitCost = 	Case 	When Round(CONVERT(DEC(25,9),Qty), @DecPlQty) <> 0
					Then Round(Round(CONVERT(DEC(28,3),TotCost), @BaseDecPl) / Round(CONVERT(DEC(25,9),Qty), @DecPlQty), @DecPlPrcCst)
					Else 0
				End
		From ItemCost
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And LayerType = @LayerType
			And SpecificCostID = @SpecificCostID
			And RcptNbr = @RcptNbr
			And RcptDate = @RcptDate
		/*
	Negative Check

	If the Inventory Setup settings does not allow negative quantities, check to keep
	the costing layer from having either a negative quantity or a negative cost.
	*/
	If @NegQty = @False
		And (@IC_Qty + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty) < 0 Or @IC_TotCost + Round(CONVERT(DEC(28,3),@TotCost), @BaseDecPl) < 0)
	Begin
		/*
		Solomon Error Message
		*/
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
				ParmCnt, Parm00, Parm01)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 16080,
				2, @InvtID, @SiteID)
		Goto Abort
	End
	/*
	Check Costing Rules
	*/

	/*
	Costing Rule # 1
		If Quantity equals zero, cost should equal zero, delete the costing layer.

	Determine if issue quantity will completely deplete the costing layer.
	*/
	If @IC_Qty + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty) = 0
	Begin
		Set @TotCost = @IC_TotCost
		Execute	@ReturnStatus = DMG_Delete_ItemCost	@InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptNbr,
								@RcptDate
		Select @SQLErrNbr = @@Error
		If @SQLErrNbr <> 0
		Begin
			Insert 	Into IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
					Parm00, Parm01, Parm02, Parm03, Parm04,
					Parm05)
				Values
					(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 6,
					@InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptNbr,
					Convert(Char(30), @RcptDate))
			Goto Abort
		End
		If @ReturnStatus = @False
		Begin
			Insert 	Into IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
					Parm00, Parm01, Parm02, Parm03, Parm04,
					Parm05)
				Values
					(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 6,
					@InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptNbr,
					Convert(Char(30), @RcptDate))
			Goto Abort
		End
		Goto Finish
	End
	/*
	Costing Rule # 2
		Specific Cost ID valuation method inventory items can't have a negative
		quantity or cost.
	*/
	If @ValMthd = 'S'
	Begin
		If @IC_Qty + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty) < 0
		Begin
		/*
		Solomon Error Message
		*/
			Insert 	Into IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
					ParmCnt, Parm00, Parm01, Parm02)
				Values
					(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 16082,
					3, @InvtID, @SiteID, @SpecificCostID)
			Goto Abort
		End
	End
	/*
	Costing Rule # 3
		Cost and quantity must have the same sign.

	If the quantity is positive the layer total cost must be positive.  If the quantity
	is negative the layer total cost must be negative.
	*/
	If (@IC_Qty + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty) < 0 And @IC_TotCost + Round(CONVERT(DEC(28,3),@TotCost), @BaseDecPl) > 0)
		Or (@IC_Qty + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty) > 0 And @IC_TotCost + Round(CONVERT(DEC(28,3),@TotCost), @BaseDecPl) < 0)
	Begin
		/*
		Solomon Error Message
		*/
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, MsgNbr,
				ParmCnt, Parm00, Parm01, Parm02, Parm03)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 16083,
				2, @InvtID, @SiteID, @RcptNbr, Convert(Varchar(20), @RcptDate))
		Goto Abort
	End
	/*
	Update the layer quantity and total layer cost for the costing layer
	and recalculate the per unit cost.
	*/
	Update	ItemCost
		Set	BMITotCost = Round(CONVERT(DEC(28,3),BMITotCost), @BMIDecPl) + Round(CONVERT(DEC(28,3),@BMITotCost), @BMIDecPl),
			Qty = Round(CONVERT(DEC(25,9),Qty), @DecPlQty) + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty),
			S4Future03 =	Case	When Round(CONVERT(DEC(25,9),S4Future03), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyShipNotInv), @DecPlQty) > 0
							Then Round(CONVERT(DEC(25,9),S4Future03), @DecPlQty) + Round(CONVERT(DEC(25,9),@QtyShipNotInv), @DecPlQty)
						Else 0
					End,
			TotCost = Round(CONVERT(DEC(28,3),TotCost), @BaseDecPl) + Round(CONVERT(DEC(28,3),@TotCost), @BaseDecPl),
			UnitCost = Case When Round(CONVERT(DEC(25,9),Qty), @DecPlQty) + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty) <> 0
						Then Round((Round(CONVERT(DEC(28,3),TotCost), @BaseDecPl) + Round(CONVERT(DEC(28,3),@TotCost), @BaseDecPl)) /
							(Round(CONVERT(DEC(25,9),Qty), @DecPlQty) + Round(CONVERT(DEC(25,9),@Qty), @DecPlQty)), @DecPlPrcCst)
					Else 0
				End,
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName
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
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04,
				Parm05)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 6,
				@InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptNbr,
				Convert(Char(30), @RcptDate))
		Goto Abort
	End
/*
	Checks to see if the latest update was an adjustment that would have reduced the cost layer to negative.
*/
	If Exists(	Select	InvtID
				From	ItemCost
				Where	InvtID = @InvtID
					And SiteID = @SiteID
					And LayerType = @LayerType
					And SpecificCostID = @SpecificCostID
					And RcptNbr = @RcptNbr
					And RcptDate = @RcptDate
					And Qty < 0
					And RcptNbr <> 'OVRSLD')
	BEGIN
		Update	ItemCost
			Set	RcptNbr = 'OVRSLD',
				RcptDate = '01/01/1900'
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
					(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
					Parm00, Parm01, Parm02, Parm03, Parm04,
					Parm05)
				Values
					(@BatNbr, @UserAddress, 'DMG_10400_Upd_ItemCost', @SQLErrNbr, 6,
					@InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptNbr,
					Convert(Char(30), @RcptDate))
			Goto Abort
		End
	END

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_Upd_ItemCost] TO [MSDSL]
    AS [dbo];

