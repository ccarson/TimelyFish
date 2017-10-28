 create proc ADG_Plan_Demand
	@InvtID 	varchar(30),
	@SiteID 	varchar(10),
	@CancelDate 	smalldatetime
as
	select	s.CpnyID,
		s.OrdNbr,
		s.LineRef,
		s.SchedRef,
		s.ReqDate,
		s.ReqPickDate,
		s.PromDate,
		s.QtyOrd,
		s.QtyShip,
		s.TransitTime,
		s.WeekendDelivery,
		h.Priority,
		s.PrioritySeq,
		s.PriorityDate,
		s.PriorityTime,
		h.ShipCmplt,
		s.ShipViaID,
		l.CnvFact,
		l.UnitMultDiv,
		t.Behavior,
		h.BuildAssyTime,
		h.BuildAvailDate,
		s.AutoPO,
		s.DropShip

	from 	SOLine l

	join 	SOSched s
	on	s.CpnyID = l.CpnyID
	and	s.OrdNbr = l.OrdNbr
	and	s.LineRef = l.LineRef

	join	SOHeader h (NOLOCK)
	on	h.CpnyID = l.CpnyID
	and	h.OrdNbr = l.OrdNbr

	join 	SOType t (NOLOCK)
	on	t.CpnyID = h.CpnyID
	and	t.SOTypeID = h.SOTypeID

	where	s.Status = 'O'
	and	s.SiteID = @SiteID
	and	(s.DropShip = 0 or s.AutoPO = 1)
	and	s.CancelDate > @CancelDate
	and	s.QtyOrd > 0
	and	(s.QtyOrd - s.QtyShip) <> 0
	and	l.InvtID = @InvtID
	and	l.Status = 'O'
	--and	h.Status = 'O'
	and	t.Behavior in ('CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SERV', 'SO', 'TR', 'WC', 'WO')

	order by
		s.PrioritySeq,
		h.Priority,
		s.PriorityDate,
		s.PriorityTime

	option (force order)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_Demand] TO [MSDSL]
    AS [dbo];

