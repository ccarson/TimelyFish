 create proc ADG_Plan_QShp
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@QtyPrec	smallint
as
	select	isnull(sum(	case when l.UnitMultDiv = 'D' then
				case when l.CnvFact <> 0 then
					round(l.QtyShip / l.CnvFact, @QtyPrec)
				else
					0
				end
			else
				round(l.QtyShip * l.CnvFact, @QtyPrec)
			end), 0) QtyShip

	from	SOShipLine l

	join	SOShipHeader h (nolock)	-- Use NOLOCK to eliminate a deadlock problem
	on	l.CpnyID = h.CpnyID
	and	l.ShipperID = h.ShipperID

	join	SOType t
	on	t.CpnyID = l.CpnyID
	and	t.SOTypeID = h.SOTypeID

	where	l.InvtID = @InvtID
	and	l.SiteID = @SiteID
	and	l.Status = 'O'
	and	l.QtyShip > 0
	and	h.DropShip = 0
	and	t.Behavior in ('CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SERV', 'SO', 'TR', 'WC', 'WO')


