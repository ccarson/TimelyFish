 Create Procedure SCM_Insert_LotSerT
        @BatNbr 	VarChar(10),
        @CpnyID 	VarChar(10),
        @Crtd_Prog 	VarChar(8),
        @Crtd_User 	VarChar(10),
        @CustID 	VarChar(15),
        @ExpDate 	SmallDateTime,
        @INTranLineID 	Integer,
        @INTranLineRef 	VarChar(5),
        @InvtID 	VarChar(30),
        @InvtMult 	SmallInt,
        @KitID 		VarChar(30),
        @LineNbr 	SmallInt,
        @LotSerNbr 	VarChar(25),
        @LotSerRef 	VarChar(5),
        @LUpd_DateTime 	SmallDateTime,
        @LUpd_Prog 	VarChar(8),
        @LUpd_User 	VarChar(10),
        @MfgrLotSerNbr 	VarChar(25),
        @NoteID 	Integer,
        @ParInvtID 	VarChar(30),
        @ParLotSerNbr 	VarChar(25),
        @Qty 		Float,
        @RcptNbr 	VarChar(10),
        @RefNbr 	VarChar(15),
        @S4Future01 	VarChar(30),
        @S4Future02 	VarChar(30),
        @S4Future03 	Float,
        @S4Future04 	Float,
        @S4Future05 	Float,
        @S4Future06 	Float,
        @S4Future07 	SmallDateTime,
        @S4Future08 	SmallDateTime,
        @S4Future09 	Integer,
        @S4Future10 	Integer,
        @S4Future11 	VarChar(10),
        @S4Future12 	VarChar(10),
        @ShipContCode 	VarChar(20),
        @ShipmentNbr 	SmallInt,
        @SiteID 	VarChar(10),
        @ToSiteID 	VarChar(10),
        @ToWhseLoc 	VarChar(10),
        @TranDate 	SmallDateTime,
        @TranSrc 	VarChar(2),
        @TranTime 	SmallDateTime,
        @TranType 	VarChar(2),
        @UnitCost 	Float,
        @UnitPrice 	Float,
        @User1 		VarChar(30),
        @User2 		VarChar(30),
        @User3 		Float,
        @User4 		Float,
        @User5 		VarChar(10),
        @User6 		VarChar(10),
        @User7 		SmallDateTime,
        @User8 		SmallDateTime,
        @WarrantyDate 	SmallDateTime,
        @WhseLoc 	VarChar(10)
As

	Set	NoCount On

	Insert 	LotSerT
		(
		BatNbr, CpnyID, Crtd_Prog, Crtd_User, CustID,
		ExpDate, INTranLineID, INTranLineRef, InvtID, InvtMult,
		KitID, LineNbr, LotSerNbr, LotSerRef, LUpd_DateTime,
		LUpd_Prog, LUpd_User, MfgrLotSerNbr, NoteID, ParInvtID,
		ParLotSerNbr, Qty, RcptNbr, RefNbr, S4Future01,
		S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
		S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
		S4Future12, ShipContCode, ShipmentNbr, SiteID, ToSiteID,
		ToWhseLoc, TranDate, TranSrc, TranTime, TranType,
		UnitCost, UnitPrice, User1, User2, User3,
		User4, User5, User6, User7, User8,
		WarrantyDate, WhseLoc
		)
		Values
		(
		@BatNbr, @CpnyID, @Crtd_Prog, @Crtd_User, @CustID,
		@ExpDate, @INTranLineID, @INTranLineRef, @InvtID, @InvtMult,
		@KitID, @LineNbr, @LotSerNbr, @LotSerRef, @LUpd_DateTime,
		@LUpd_Prog, @LUpd_User, @MfgrLotSerNbr, @NoteID, @ParInvtID,
		@ParLotSerNbr, @Qty, @RcptNbr, @RefNbr, @S4Future01,
		@S4Future02, @S4Future03, @S4Future04, @S4Future05, @S4Future06,
		@S4Future07, @S4Future08, @S4Future09, @S4Future10, @S4Future11,
		@S4Future12, @ShipContCode, @ShipmentNbr, @SiteID, @ToSiteID,
		@ToWhseLoc, @TranDate, @TranSrc, @TranTime, @TranType,
		@UnitCost, @UnitPrice, @User1, @User2, @User3,
		@User4, @User5, @User6, @User7, @User8,
		@WarrantyDate, @WhseLoc
		)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Insert_LotSerT] TO [MSDSL]
    AS [dbo];

