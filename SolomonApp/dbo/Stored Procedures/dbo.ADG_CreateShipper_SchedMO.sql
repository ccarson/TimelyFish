 create proc ADG_CreateShipper_SchedMO
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15),
	@RMA		smallint
as
	select	s.LineRef,
		s.SchedRef,
		-(s.QtyToInvc),
		l.CnvFact,
		l.UnitMultDiv

	from	SOSched s

	  join	SOLine l
	  on	l.CpnyID = s.CpnyID
	  and	l.OrdNbr = s.OrdNbr
	  and	l.LineRef = s.LineRef

	  join	SOHeader h
	  on	h.CpnyID = s.CpnyID
	  and	h.OrdNbr = s.OrdNbr

	  left
	  join	SOSchedMark m
	  on	m.CpnyID = s.CpnyID
	  and	m.OrdNbr = s.OrdNbr
	  and	m.LineRef = s.LineRef
	  and	m.SchedRef = s.SchedRef

	where	s.CpnyID = @CpnyID
	  and	s.OrdNbr = @SOOrdNbr
	  and	s.Status = 'O'
	  and	1 =	case	when ((@RMA = 0) and (s.QtyToInvc > 0 or s.QtyToInvc = 0 and h.ShipCmplt = 1
					and exists (select * from SOSched a where a.CpnyID = @CpnyID and a.OrdNbr = @SOOrdNbr and a.SiteID=s.SiteID and a.DropShip = s.DropShip and a.QtyToInvc>0)))
					then 1
				when ((@RMA = 1) And (s.QtyToInvc < 0)) then 1
									else 0
			end

	-- The order by clause must be the 'schedule group' fields
	-- followed by s.LineRef.
	order by
		s.DropShip,
		s.SiteID,
		s.ShipViaID,
		s.ShiptoType,
		s.ShipCustID,
		s.ShiptoID,
		s.ShipAddrID,
		s.ShipSiteID,
		s.ShipVendID,
		s.WeekendDelivery,
		s.MarkFor,
		m.MarkForType,
		m.CustID,
		m.MarkForID,
		m.AddrID,
		m.SiteID,
		m.VendID,
		s.LineRef,
		s.LotSerialEntered


