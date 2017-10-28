 create proc ADG_Plan_QOH_ExpireLotSer
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	sum(l.QtyOnHand - l.QtyShipNotInv)

	from	LotSerMst l

	join	LocTable lt
	on	lt.SiteID = l.SiteID
	and	lt.WhseLoc = l.WhseLoc

	where	l.InvtID = @InvtID
	and	l.SiteID = @SiteID
	and	lt.InclQtyAvail = 1


