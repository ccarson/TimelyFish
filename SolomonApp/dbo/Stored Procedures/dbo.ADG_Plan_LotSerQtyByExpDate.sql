 create proc ADG_Plan_LotSerQtyByExpDate
	@InvtID		varchar(30),
	@SiteID 	varchar(10)
as
	select		ls.ExpDate,
			sum(ls.QtyAlloc),
			sum(ls.QtyOnHand),
			sum(ls.QtyShipNotInv)

	from		LotSerMst ls

	join		LocTable lt
	on		lt.SiteID = ls.SiteID
	and		lt.WhseLoc = ls.WhseLoc

	where		ls.InvtID = @InvtID
	and		ls.SiteID = @SiteID
	and		lt.InclQtyAvail = 1

	group by	ls.ExpDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_LotSerQtyByExpDate] TO [MSDSL]
    AS [dbo];

