 create proc ADG_Plan_SODropShip
	@InvtID	varchar(30),
	@SiteID	varchar(10)
as
	select	s.CpnyID,
		s.OrdNbr,
		s.LineRef,
		s.SchedRef,
		l.CnvFact,
		l.UnitMultDiv,
		s.ReqDate,
		s.QtyOrd,
		s.QtyShip

	from	SOSched	s
	join	SOHeader	h on s.CpnyID = h.CpnyID and s.OrdNbr = h.OrdNbr
	join	SOLine		l on s.CpnyID = l.CpnyID and s.OrdNbr = l.OrdNbr and s.LineRef = l.LineRef
	join	SOType		t on s.CpnyID = t.CpnyID and h.SOTypeID = t.SOTypeID

	where	s.Status = 'O'
	and	s.SiteID = @SiteID
	and	s.DropShip = 1
	and	s.AutoPO = 0
	and	s.QtyOrd > 0
	and	l.InvtID = @InvtID
	-- Some of the behaviors below should be meaningless for drop ships.
	and	t.Behavior in ('CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SERV', 'SO', 'TR', 'WC', 'WO')

	order by
		h.Priority,
		s.PriorityDate,
		s.PriorityTime


