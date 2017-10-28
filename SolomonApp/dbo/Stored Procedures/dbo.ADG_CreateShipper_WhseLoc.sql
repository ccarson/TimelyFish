 create proc ADG_CreateShipper_WhseLoc
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	DfltPickBin,
		DfltPutAwayBin,
		DfltRepairBin,
		DfltVendorBin

	from	ItemSite I

	where	I.InvtID = @InvtID
	  and	I.SiteID = @SiteID


