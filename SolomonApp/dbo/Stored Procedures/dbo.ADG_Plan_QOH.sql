 create proc ADG_Plan_QOH
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	sum(l.QtyOnHand
		- l.QtyAllocBM
		- l.QtyAllocIN
		- l.QtyAllocPORet
		- l.QtyAllocSD
		- l.QtyShipNotInv
		- case when left(isnull(WOSetup.S4Future11,' '),1) in ('F','R') then l.QtyWORlsedDemand else 0 End
		- case when left(isnull(WOSetup.S4Future11,' '),1) = 'F' then l.S4Future03 else 0 end
		)

	from	Location l

	join	LocTable lt
	on	lt.SiteID = l.SiteID
	and	lt.WhseLoc = l.WhseLoc

	left join WOSetup (nolock) on SetupID = 'WO' and Init = 'Y'

	where	l.InvtID = @InvtID
	and	l.SiteID = @SiteID
	and	lt.InclQtyAvail = 1


