 create proc DMG_SOSH_Ins_LotSerMst
	@InvtID varchar(30),
	@SiteID varchar(10),
	@WhseLoc varchar(10),
	@LotSerNbr varchar(25),
	@Crtd_Prog varchar(10),
	@Crtd_User varchar(10) as

insert LotSerMst(Cost, Crtd_DateTime, Crtd_Prog, Crtd_User, ExpDate, InvtID, LIFODate, LotSerNbr, LUpd_DateTime, LUpd_Prog, LUpd_User,
MfgrLotSerNbr, NoteID, OrigQty, QtyAlloc, QtyAllocBM, QtyAllocIN, QtyAllocOther, QtyAllocPORet, QtyAllocSD, QtyAllocSO, QtyAvail, QtyOnHand,
QtyShipNotInv, QtyWORlsedDemand, RcptDate, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
S4Future09, S4Future10, S4Future11, S4Future12, ShipContCode, SiteID, Source, SrcOrdNbr, Status, StatusDate, User1, User2, User3, User4,
User5, User6, User7, User8, WarrantyDate, WhseLoc)
select 0, getdate(), @Crtd_Prog, @Crtd_User, '', @InvtID, '', @LotSerNbr, getdate(), @Crtd_Prog, @Crtd_User,
'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, '', '', '', 0, 0, 0, 0, '', '',
0, 0, '', '', '', @SiteID, 'IN', '', 'H', '', '', '', 0, 0,
'', '', '', '', '', @WhseLoc
where not exists(select * from LotSerMst where InvtID = @InvtID and SiteID = @SiteID and WhseLoc = @WhseLoc and LotSerNbr = @LotSerNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSH_Ins_LotSerMst] TO [MSDSL]
    AS [dbo];

