 Create	Procedure SCM_Plan_WO_MissingLotSerMst
		@CpnyID		VarChar(10),	/* Company ID */
		@InvtID		VarChar(30),	/* Inventory ID */
		@SiteID		VarChar(10),	/* Site ID */
		@LUpd_Prog	VarChar(8),
		@LUpd_User	VarChar(10)
As
/*
	This stored procedure will be called during the CPS Off Planning process to
	insure that any missing Lot/Serial Master Table records that are missing are added.
*/
	Set	NoCount On
	Insert	Into	LotSerMst
			(InvtID, LotSerNbr, SiteID, WhseLoc, Crtd_Prog,
			 Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User, OrigQty,
			Status)
		Select	WOLotSerT.InvtID, WOLotSerT.LotSerNbr, WOLotSerT.SiteID, WOLotSerT.WhseLoc, @LUpd_Prog,
			@LUpd_User, Convert(SmallDateTime, GetDate()), @LUpd_Prog, @LUpd_User, Sum(WOLotSerT.Qty),
			'A'
			From	WOLotSerT Left Join LotSerMst
				On WOLotSerT.InvtID = LotSerMst.InvtID
				And WOLotSerT.LotSerNbr = LotSerMst.LotSerNbr
				And WOLotSerT.SiteID = LotSerMst.SiteID
				And WOLotSerT.WhseLoc = LotSerMst.WhseLoc
			Where	LotSerMst.InvtID Is Null
				And WOLotSerT.CpnyID = @CpnyID
				And WOLotSerT.InvtID = @InvtID
				And WOLotSerT.SiteID = @SiteID
				And WOLotSerT.Status = 'H'		/* Hold */
			Group By WOLotSerT.InvtID, WOLotSerT.SiteID, WOLotSerT.WhseLoc, WOLotSerT.LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_WO_MissingLotSerMst] TO [MSDSL]
    AS [dbo];

