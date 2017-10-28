 create proc ADG_CreateShipper_LotQtyNoSplt
	@InvtID	varchar(30),
	@SiteID	varchar(10)
as
	select	max(l.QtyAvail)
	from	LotSerMst  l
	join	LocTable   lt
	  on	lt.SiteID = l.SiteID
	  and	lt.WhseLoc = l.WhseLoc

	where	l.InvtID = @InvtID
	  and	l.SiteID = @SiteID
	  and	lt.InclQtyAvail = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_CreateShipper_LotQtyNoSplt] TO [MSDSL]
    AS [dbo];

