 Create Procedure DMG_10400_GrpUpd_LotSerMst
	/*Begin Process Parameter Group*/
	@BatNbr			Varchar(10),
	@ProcessName		Varchar(8),
	@UserName		Varchar(10),
	@UserAddress		Varchar(21),
	@DecPlQty		SmallInt,
	@DecPlPrcCst		SmallInt,
	@NegQty			Bit,
	/*End Process Parameter Group*/
	/*Begin Decrease Values Parameter Group*/
	@CpnyID			Varchar(10),
	@INTranLineRef		Char(5),
	@SiteID			Varchar(10),
	@TranType		Char(2),
	@LotSerTrack		Char(2),
	@SerAssign		Char(1),
	@ShelfLife		SmallInt,
	@WarrantyDays		SmallInt,
	@Cost			Float
	/*End Decrease Values Parameter Group*/
As
	Set NoCount On
	/*
	Parameters are grouped together functionally.

	This procedure will update the quantity on hand (QTYONHAND) and quantity shipped
	not invoiced for the record matching the primary key fields passed as parameters.
	The primary key fields in the LotSerMst table define a specific warehouse storage
	LotSerMst.

	Automatically determines if record to be updated exists.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@True		Bit,
		@False		Bit,
		@Abort		Bit
	Select	@True 		= 1,
		@False 		= 0,
		@Abort		= 0

	Declare	@SQLErrNbr	SmallInt,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@ReturnStatus	= @True

	Declare	@LT_InvtID		Varchar(30),
		@LT_LotSerNbr		Varchar(15),
		@LT_SiteID		Varchar(10),
		@LT_WhseLoc		Varchar(10)

	/*
	Check to see if the No Quantity Update flag (S4FUTURE09) is set.
	*/
	IF EXISTS(SELECT LOTSERNBR
			FROM	LOTSERT
			WHERE	BatNbr = @BatNbr
				And CpnyID = @CpnyID
				And INTranLineRef = @INTranLineRef
				And SiteID = @SiteID
				And TranType = @TranType
				And S4Future09 = 1
				And Rlsed = 0)
	Begin
		Set	@SerAssign = 'U'
	End
	/*
	Check to see if there are any missing Lot Serial Master records before trying to update them.
	*/
	Insert Into	LotSerMst
			(InvtID, LotSerNbr, SiteID, WhseLoc, Crtd_Prog,
			 Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User, OrigQty,
			Status)
		Select	LotSerT.InvtID, LotSerT.LotSerNbr, LotSerT.SiteID, LotSerT.WhseLoc, @ProcessName,
			@UserName, Convert(SmallDateTime, GetDate()), @ProcessName, @UserName, Sum(LotSerT.Qty),
			'A'
			From	LotSerT Left Join LotSerMst (NoLock)
				On LotSerT.InvtID = LotSerMst.InvtID
				And LotSerT.LotSerNbr = LotSerMst.LotSerNbr
				And LotSerT.SiteID = LotSerMst.SiteID
				And LotSerT.WhseLoc = LotSerMst.WhseLoc
			Where	LotSerMst.InvtID Is Null
				And LotSerT.BatNbr = @BatNbr
				And LotSerT.CpnyID = @CpnyID
				And LotSerT.INTranLineRef = @INTranLineRef
				And LotSerT.SiteID = @SiteID
				And LotSerT.TranType = @TranType
				And LotSerT.Rlsed = 0
			Group By LotSerT.InvtID, LotSerT.LotSerNbr, LotSerT.SiteID, LotSerT.WhseLoc

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_GrpUpd_LotSerMst', @SQLErrNbr, 5,
				@BatNbr, @CpnyID, @INTranLineRef, @SiteID, @TranType)
		Goto Abort
	End
	If @ReturnStatus = @False
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_GrpUpd_LotSerMst', @SQLErrNbr, 5,
				@BatNbr, @CpnyID, @INTranLineRef, @SiteID, @TranType)
		Goto Abort
	End
	/*
	Quantity on hand will be passed in positive and negative.  If quantity on hand
	is increasing, the system should not return an error message because a quantity
	can be received into the warehouse bin LotSerMst that does not completely offset
	the negative on hand quantity.  Also, the system should not fail if the quantity
	on hand value in the quantity on hand (@QTYONHAND) parameter is equal to zero. A
	zero quantity on hand (@QTYONHAND) parameter may occur when when only the quantity
	shipped not invoice (QTYSHIPNOTINV) is to be updated.
	*/
	If Cursor_Status('Local', 'Validate_Qty') > 0
	Begin
		Close Validate_Qty
		Deallocate Validate_Qty
	End
	Declare Validate_Qty CURSOR Local For
		Select	LotSerT.InvtID, LotSerT.LotSerNbr, LotSerT.SiteID, LotSerT.WhseLoc
			From	LotSerT (NoLock) Join LotSerMst (NoLock)
				On LotSerT.InvtID = LotSerMst.InvtID
				And LotSerT.LotSerNbr = LotSerMst.LotSerNbr
				And LotSerT.SiteID = LotSerMst.SiteID
				And LotSerT.WhseLoc = LotSerMst.WhseLoc
			Where	LotSerT.BatNbr = @BatNbr
				And LotSerT.CpnyID = @CpnyID
				And LotSerT.INTranLineRef = @INTranLineRef
				And LotSerT.SiteID = @SiteID
				And LotSerT.TranType = @TranType
				And LotSerT.Rlsed = 0
				And @NegQty = @False
				And Round(LotSerMst.QtyOnHand + (LotSerT.Qty * LotSerT.InvtMult), @DecPlQty) < 0
				And @LotSerTrack = 'LI'
				And @SerAssign = 'R'
	Open Validate_Qty
	Fetch Next From Validate_Qty Into @LT_InvtID, @LT_LotSerNbr, @LT_SiteID, @LT_WhseLoc
	While (@@Fetch_Status = 0)
	Begin
		Set	@Abort = @True
		/*
		Solomon Error Message
		*/
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_GrpUpd_LotSerMst', 16072, 4,
				@LT_InvtID, @LT_SiteID, @LT_WhseLoc, @LT_LotSerNbr)
		Fetch Next From Validate_Qty Into @LT_InvtID, @LT_LotSerNbr, @LT_SiteID, @LT_WhseLoc
	End
	Close Validate_Qty
	Deallocate Validate_Qty
	If @Abort = @True
	Begin
		Goto Abort
	End
/*	Serial Check	*/
	If Cursor_Status('Local', 'Validate_Qty') > 0
	Begin
		Close Validate_Qty
		Deallocate Validate_Qty
	End
	Declare Validate_Qty CURSOR Local For
		Select	LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr
			From	LotSerT (NoLock) Join LotSerMst (NoLock)
				On LotSerT.InvtID = LotSerMst.InvtID
				And LotSerT.LotSerNbr = LotSerMst.LotSerNbr
				And LotSerT.SiteID = LotSerMst.SiteID
				And LotSerT.WhseLoc = LotSerMst.WhseLoc
			Where	LotSerT.BatNbr = @BatNbr
				And LotSerT.CpnyID = @CpnyID
				And LotSerT.INTranLineRef = @INTranLineRef
				And LotSerT.SiteID = @SiteID
				And LotSerT.TranType = @TranType
				And @LotSerTrack = 'SI'
				And @SerAssign = 'R'
			Group By LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr, LotSerMst.QtyOnHand
			Having Round(LotSerMst.QtyOnHand + Sum(LotSerT.Qty * LotSerT.InvtMult), @DecPlQty) < 0
	Open Validate_Qty
	Fetch Next From Validate_Qty Into @LT_InvtID, @LT_SiteID, @LT_WhseLoc, @LT_LotSerNbr
	While (@@Fetch_Status = 0)
	Begin
		Set	@Abort = @True
		/*
		Solomon Error Message
		*/
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_GrpUpd_LotSerMst', 16072, 4,
				@LT_InvtID, @LT_SiteID, @LT_WhseLoc, @LT_LotSerNbr)
		Fetch Next From Validate_Qty Into @LT_InvtID, @LT_SiteID, @LT_WhseLoc, @LT_LotSerNbr
	End
	Close Validate_Qty
	Deallocate Validate_Qty
	If @Abort = @True
	Begin
		Goto Abort
	End

	/*
	Update the warehouse LotSerMst quantity on hand and the quantity shipped not invoiced.
	*/
	Update	LotSerMst
		Set	LotSerMst.QtyOnHand = Round(LotSerMst.QtyOnHand + Case When @SerAssign = 'R' Then (LotSerT.Qty * LotSerT.InvtMult) Else 0 End, @DecPlQty),
			LotSerMst.QtyShipNotInv =	Case	When LotSerT.TranSrc <> 'OM'
									Then LotSerMst.QtyShipNotInv
								When (Round(LotSerMst.QtyShipNotInv  + Case When (LotSerT.Qty * LotSerT.InvtMult) < 0 Then (LotSerT.Qty * LotSerT.InvtMult) Else 0 End, @DecPlQty) > 0)
									Then Round(LotSerMst.QtyShipNotInv  + Case When (LotSerT.Qty * LotSerT.InvtMult) < 0 Then (LotSerT.Qty * LotSerT.InvtMult) Else 0 End, @DecPlQty)
								Else 0
							End,
			Cost = Case When Round(@Cost, @DecPlPrcCst) <> 0 Then Round(@Cost, @DecPlPrcCst) Else LotSerMst.Cost End,
			Status = 'A',
			LUpd_DateTime = Convert(SmallDateTime, GetDate()),
			LUpd_Prog = @ProcessName,
			LUpd_User = @UserName,
			WarrantyDate =			Case	When LotSerMst.WarrantyDate = '01/01/1900' AND @WarrantyDays > 0
									Then Convert(SmallDateTime, DateAdd(dd, @WarrantyDays, GetDate()))
								Else LotSerMst.WarrantyDate
							End,
			ExpDate =			Case 	When LotSerMst.ExpDate = '01/01/1900' AND LotSerT.ExpDate <> '01/01/1900'
									Then LotSerT.ExpDate
								When LotSerMst.ExpDate = '01/01/1900' AND @ShelfLife > 0
									Then Convert(SmallDateTime, DateAdd(dd, @ShelfLife, GetDate()))
								Else LotSerMst.ExpDate
							End,
			LotSerMst.MfgrLotSerNbr = 	Case	When LotSerMst.MfgrLotSerNbr = ''
									Then LotSerT.MfgrLotSerNbr
								Else LotSerMst.MfgrLotSerNbr
							End,
			LotSerMst.Source = 		Case	When LotSerMst.Source = ''
									Then LotSerT.TranSrc
								Else LotSerMst.Source
							End,
			LotSerMst.SrcOrdNbr = 		Case	When LotSerMst.SrcOrdNbr = ''
									Then LotSerT.RefNbr
								Else LotSerMst.SrcOrdNbr
							End,
			LotSerMst.ShipContCode = 	Case	When LotSerMst.ShipContCode = ''
									Then LotSerT.ShipContCode
								Else LotSerMst.ShipContCode
							End
		From	LotSerT Join LotSerMst
			On LotSerT.InvtID = LotSerMst.InvtID
			And LotSerT.LotSerNbr = LotSerMst.LotSerNbr
			And LotSerT.SiteID = LotSerMst.SiteID
			And LotSerT.WhseLoc = LotSerMst.WhseLoc
		Where	LotSerT.BatNbr = @BatNbr
			And LotSerT.CpnyID = @CpnyID
			And LotSerT.INTranLineRef = @INTranLineRef
			And LotSerT.SiteID = @SiteID
			And LotSerT.TranType = @TranType
			And LotSerT.Rlsed = 0

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_GrpUpd_LotSerMst', @SQLErrNbr, 5,
				@BatNbr, @CpnyID, @INTranLineRef, @SiteID, @TranType)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_GrpUpd_LotSerMst] TO [MSDSL]
    AS [dbo];

