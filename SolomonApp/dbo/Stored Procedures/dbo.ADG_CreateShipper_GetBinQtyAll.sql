 create proc ADG_CreateShipper_GetBinQtyAll
	@InvtID	varchar(30),
	@SiteID	varchar(10)
as
	select	sum(l.QtyAvail)
	from	Location  l
	join	LocTable  lt
	  on	lt.SiteID = l.SiteID
	  and	lt.WhseLoc = l.WhseLoc

	where	l.InvtID = @InvtID
	  and	l.SiteID = @SiteID
	  and	lt.InclQtyAvail = 1


