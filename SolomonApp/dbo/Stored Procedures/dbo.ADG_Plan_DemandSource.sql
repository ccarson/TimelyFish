 create proc ADG_Plan_DemandSource
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
		s.DropShip,
		D.PONbr,
		D.POLineRef,
		D.POAllocRef,
		D.POQtyOrd,
		D.POQtyRcvd,
		D.POCnvFact,
		D.POUnitMultDiv,
		D.POPromDate

	from 	SOLine l

	join 	SOSched s
	on	s.CpnyID = l.CpnyID
	and	s.OrdNbr = l.OrdNbr
	and	s.LineRef = l.LineRef

	join	SOHeader h (nolock)
	on	h.CpnyID = l.CpnyID
	and	h.OrdNbr = l.OrdNbr

	join 	SOType t (nolock)
	on	t.CpnyID = h.CpnyID
	and	t.SOTypeID = h.SOTypeID

	left outer
 	join	(select a.CpnyID,
			a.SOOrdNbr,
			a.SOLineRef,
			a.SOSchedRef,
			a.PONbr,
			a.POLineRef,
			a.AllocRef as POAllocRef,
			a.QtyOrd as POQtyOrd,
			a.QtyRcvd as POQtyRcvd,
			l.CnvFact as POCnvFact,
			l.UnitMultDiv as POUnitMultDiv,
			l.PromDate as POPromDate

		from	POAlloc a

		join	PurOrdDet l
		on	l.PONbr = a.PONbr
		and	l.LineRef = a.POLineRef

		join	PurchOrd h
		on	h.PONbr = a.PONbr

		where	h.POType = 'OR'
		and	h.Status not in ('Q', 'X')	-- Quote, Cancelled
		) as D

	on	D.CpnyID = s.CpnyID
	and	D.SOOrdNbr = s.OrdNbr
	and	D.SOLineRef = s.LineRef
	and	D.SOSchedRef = s.SchedRef

	where	s.Status = 'O'
	and	s.SiteID = @SiteID
	and	(s.DropShip = 0 or s.AutoPO = 1)
	and (s.DropShip = 1 or t.Behavior = 'MO' or s.LotSerialEntered = 0)
	and	s.CancelDate > @CancelDate
	and	s.QtyOrd > 0
	and	(s.QtyOrd - s.QtyShip) <> 0
	and	l.InvtID = @InvtID
	and	l.Status = 'O'
	and	t.Behavior in ('CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SERV', 'SO', 'TR', 'WC', 'WO')

	order by
		s.PrioritySeq,
		h.Priority,
		s.PriorityDate,
		s.PriorityTime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_DemandSource] TO [MSDSL]
    AS [dbo];

