 create proc ADG_Plan_Shippers
	@InvtID		varchar(30),
	@SiteID 	varchar(10)
as
	select	l.CpnyID,
		l.ShipperID,
		l.LineRef,
		h.OrdNbr,
		l.OrdLineRef,
		l.CnvFact,
		l.UnitMultDiv,
		h.ShipDateAct,
		h.ShipDatePlan,
		l.QtyShip,
		h.Priority,
		h.ShipViaID,
		h.TransitTime,
		h.WeekendDelivery,
		h.DropShip,
		t.Behavior,
		AutoPO = cast(isnull(	(select	top 1 AutoPO
					from	SOSched os

					join	SOShipSched ss
					on	ss.CpnyID = os.CpnyID
					and	ss.OrdNbr = os.OrdNbr
					and	ss.OrdLineRef = os.LineRef
					and	ss.OrdSchedRef = os.SchedRef

					where	ss.CpnyID = l.CpnyID
					and	ss.ShipperID = l.ShipperID
					and	ss.ShipperLineRef = l.LineRef)

			, 0) as smallint)

	from	SOShipLine l

	join	SOShipHeader h
	on	h.CpnyID = l.CpnyID
	and	h.ShipperID = l.ShipperID

	join	SOType t
	on	t.CpnyID = h.CpnyID
	and	t.SOTypeID = h.SOTypeID

	where	l.InvtID = @InvtID
	and	l.SiteID = @SiteID
	and	l.Status = 'O'
	and	l.QtyShip > 0
	and	h.Status = 'O'
	and	t.Behavior in ('CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SERV', 'SO', 'TR', 'WC', 'WO')


