 create proc DMG_Plan_QOH
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@TotalQty	decimal(25,9) OUTPUT
as
	select	@TotalQty = coalesce(sum(l.QtyOnHand - l.QtyShipNotInv), 0)
	from	Location l (NOLOCK)
	join	LocTable lt (NOLOCK)
	  on	lt.SiteID = l.SiteID
	  and	lt.WhseLoc = l.WhseLoc
	where	l.InvtID = @InvtID
	  and	l.SiteID = @SiteID
	  and	lt.InclQtyAvail = 1


