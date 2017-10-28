 create proc ADG_Plan_SupplyPOFloat
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	l.PONbr,
		l.LineRef,
		'AllocRef' = space(5),
		l.QtyOrd,
		l.QtyRcvd,
		l.CnvFact,
		l.UnitMultDiv,
		l.PromDate,
		h.CpnyID,
		'SOOrdNbr' = space(15),
		'SOLineRef' = space(5),
		'SOSchedRef' = space(5),
--		l.ShelfLife
		convert(smallint, l.S4Future09),	-- ShelfLife (temporary)
        l.PurchaseType 

	from	PurOrdDet l
	join	PurchOrd h
	on	l.PONbr = h.PONbr

	where	l.InvtID = @InvtID
	and	l.SiteID = @SiteID
	and	(((l.PurchaseType = 'GI')	-- Goods for Inventory
		or (l.PurchaseType = 'GN'  -- Non-Inventory Goods that are not allocated to a Sales Order
		and (select COUNT (*) from POAlloc
		where POAlloc.PONbr = l.PONbr and POAlloc.POlineRef = l.LineRef) = 0)))
	and	l.OpenLine = 1
	and	h.POType = 'OR'
	and	h.Status in ('O', 'P')	-- Open Order, Purchase Order

	order by
		l.PromDate


