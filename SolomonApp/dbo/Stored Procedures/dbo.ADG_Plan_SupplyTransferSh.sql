 create proc ADG_Plan_SupplyTransferSh
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	l.CpnyID,
		l.ShipperID,
		l.LineRef,
		l.QtyShip,
		h.TransitTime,
		h.WeekendDelivery,
		l.CnvFact,
		l.UnitMultDiv,
		h.ShipDateAct,
		h.ShipDatePlan,
		l.OrdNbr,
		l.OrdLineRef,
		h.ShipViaID

	from	SOShipLine l

	join	SOShipHeader h (NOLOCK)
	on	h.CpnyID = l.CpnyID
	and	h.ShipperID = l.ShipperID

	join	SOType t
	on	h.CpnyID = t.CpnyID
	and	h.SOTypeID = t.SOTypeID

--	left
--	join	TrnsfrDoc td
--	on	td.CpnyID = l.CpnyID
--	and	td.BatNbr = h.INBatNbr

	where	l.InvtID = @InvtID
--	and	((l.Status = 'O') or (td.Status is null) or (td.Status <> 'R'))
	and	h.S4Future02 <> 'R'
	and	l.QtyShip > 0
	and	t.Behavior = 'TR'
	and	h.ShipSiteID = @SiteID
	and	h.DropShip = 0
	and	h.Cancelled = 0


