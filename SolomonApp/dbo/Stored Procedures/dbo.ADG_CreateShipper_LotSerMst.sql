 create proc ADG_CreateShipper_LotSerMst
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@WhseLoc	varchar(10),
	@LotSerNbr	varchar(25)
as
	select	MfgrLotSerNbr,
		ShipContCode

	from	LotSerMst  l

	where	l.InvtID = @InvtID
	  and	l.SiteID = @SiteID
	  and	l.WhseLoc = @WhseLoc
	  and	l.LotSerNbr = @LotSerNbr


