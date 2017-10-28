 create proc ADG_CreateShipper_SchedPlan
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15),
	@ReqPickDate	smalldatetime
as
	select	p.SOLineRef,
		p.SOSchedRef,
		p.Qty,
		p.Hold,
		p.SOETADate,
		p.PlanRef,
		'PlanDate' =		case	when ((s.S4Future09 = 1) or (t.S4Future09 = 1) or
                                                      ((s.autopo = 1) and (s.dropship = 1)) ) then @ReqPickDate	-- S4Future09 = ShipNow
						else p.PlanDate
						end,
		'SOReqPickDate' = 	case	when ((s.S4Future09 = 1) or
                                                      ((s.autopo = 1) and (s.dropship = 1))) then @ReqPickDate	-- s.S4Future09 = ShipNow
						else p.SOReqPickDate
						end,
		p.PlanType

	from	SOPlan p

   	  join	SOSched	s
	  on	s.CpnyID = p.CpnyID
	  and	s.OrdNbr = p.SOOrdNbr
	  and	s.LineRef = p.SOLineRef
	  and	s.SchedRef = p.SOSchedRef

	  join	SOHeader h
	  on	h.CpnyID = p.CpnyID
	  and	h.OrdNbr = p.SOOrdNbr

	  left
	  join	SOSchedMark m
	  on	m.CpnyID = p.CpnyID
	  and	m.OrdNbr = p.SOOrdNbr
	  and	m.LineRef = p.SOLineRef
	  and	m.SchedRef = p.SOSchedRef

	  left
	  join	Site t
	  on	t.SiteID = p.SiteID

	where	p.CpnyID = @CpnyID
	  and	p.SOOrdNbr = @SOOrdNbr
--	  and	p.SOReqPickDate <= @ReqPickDate
	  and	p.PlanType in ('50', '52', '54', '60', '61', '62', '64', '70')
--	  and	p.Hold = 0
	  and	p.Qty < 0	-- failsafe; negative sched qtys (which would be inverted on plan) shouldn't be planned
	  and	(h.ShipCmplt <> 1 or not exists (select * from SOSched a where a.CpnyID = @CpnyID and a.OrdNbr = @SOOrdNbr and a.LotSerialEntered < a.LotSerialReq) or s.LotSerialEntered < s.LotSerialReq)
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


