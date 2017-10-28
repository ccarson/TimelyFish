 Create	Proc DMG_10990_Missing_LotSerMst
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will populate the LotSerMst comparison table with any records that are missing from
	the comparison table.  The Master Timestamp field will alway be defaulted to a binary zero for all
	inserted records.  This will cause the Master Timestamp not to match with the LotSerMst table insuring
	that the Inventory Item will be validated and rebuilt if that option is selected.
*/
	Set	NoCount On

/*	This section of code will create any missing Lot/Serial Master records where Lot/Serial Transaction
	Records exist.	*/
	Insert Into	LotSerMst
			(InvtID, LotSerNbr, SiteID, WhseLoc, Crtd_Prog,
			 Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User, OrigQty,
			Status)
		Select	LotSerT.InvtID, LotSerT.LotSerNbr, LotSerT.SiteID, LotSerT.WhseLoc, '10990',
			'SYSADMIN', Convert(SmallDateTime, GetDate()), '10990', 'SYSADMIN',
			Sum(LotSerT.Qty), 'A'
			From	LotSerT Left Join LotSerMst (NoLock)
				On LotSerT.InvtID = LotSerMst.InvtID
				And LotSerT.LotSerNbr = LotSerMst.LotSerNbr
				And LotSerT.SiteID = LotSerMst.SiteID
				And LotSerT.WhseLoc = LotSerMst.WhseLoc
			Where	LotSerMst.InvtID Is Null
				AND LotSerT.InvtID LIKE @InvtIDParm
			Group By LotSerT.InvtID, LotSerT.LotSerNbr, LotSerT.SiteID, LotSerT.WhseLoc

	Insert	Into IN10990_LotSerMst
		(Changed, Cost, Crtd_DateTime, Crtd_Prog, Crtd_User,
		ExpDate, InvtID, LotSerNbr, LUpd_DateTime, LUpd_Prog,
		LUpd_User, MfgrLotSerNbr, MstStamp, OrigQty, QtyOnHand,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12,
		ShipContCode, SiteID, Source, SrcOrdNbr,
		User1, User2, User3, User4, User5, User6, User7, User8,
		WarrantyDate, Whseloc)
	Select	Changed = 0, LotSerMst.Cost, LotSerMst.Crtd_DateTime, LotSerMst.Crtd_Prog, LotSerMst.Crtd_User,
		LotSerMst.ExpDate, LotSerMst.InvtID, LotSerMst.LotSerNbr, LotSerMst.LUpd_DateTime, LotSerMst.LUpd_Prog,
		LotSerMst.LUpd_User, LotSerMst.MfgrLotSerNbr, MstStamp = Cast(0 As Binary(8)), LotSerMst.OrigQty, LotSerMst.QtyOnHand,
		LotSerMst.S4Future01, LotSerMst.S4Future02, LotSerMst.S4Future03,
		LotSerMst.S4Future04, LotSerMst.S4Future05, LotSerMst.S4Future06,
		LotSerMst.S4Future07, LotSerMst.S4Future08, LotSerMst.S4Future09,
		LotSerMst.S4Future10, LotSerMst.S4Future11, LotSerMst.S4Future12,
		LotSerMst.ShipContCode, LotSerMst.SiteID, LotSerMst.Source, LotSerMst.SrcOrdNbr,
		LotSerMst.User1, LotSerMst.User2, LotSerMst.User3, LotSerMst.User4,
		LotSerMst.User5, LotSerMst.User6, LotSerMst.User7, LotSerMst.User8,
		LotSerMst.WarrantyDate, LotSerMst.Whseloc
		From	LotSerMst Left Join IN10990_LotSerMst
			On LotSerMst.InvtID = IN10990_LotSerMst.InvtID
			And LotSerMst.SiteID = IN10990_LotSerMst.SiteID
			And LotSerMst.WhseLoc = IN10990_LotSerMst.WhseLoc
			And LotSerMst.LotSerNbr = IN10990_LotSerMst.LotSerNbr
		Where	IN10990_LotSerMst.InvtID Is Null
			AND LotSerMst.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_Missing_LotSerMst] TO [MSDSL]
    AS [dbo];

