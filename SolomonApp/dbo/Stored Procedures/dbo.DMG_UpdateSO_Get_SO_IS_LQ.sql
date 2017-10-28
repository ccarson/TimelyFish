 create proc DMG_UpdateSO_Get_SO_IS_LQ
	@CpnyID			varchar(10),
	@OrdNbr			varchar(15),
	@LineRef		varchar(5),
	@SchedRef		varchar(5),
	@CancelDate 		smalldatetime,
	@InvtIDParm		varchar(30),
	@SiteIDParm		varchar(10)

as
	IF PATINDEX('%[%]%', @LineRef) > 0 OR PATINDEX('%[%]%', @SchedRef) > 0
		select
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
			l.invtid,
			s.siteid,
			s.dropship,
			s.LotSerialEntered,
			l.BoundToWO,
			l.ProjectID,      -- WO Nbr
			s.ShipSiteID,
			s.AutoPO,
			l.QtyShip

		from	SOSched s

		  join	SOHeader h (NOLOCK)
		  on	s.CpnyID = h.CpnyID
		  and	s.OrdNbr = h.OrdNbr
		  and h.Status = 'O'

		  join	SOLine l WITH (NOLOCK)
		  on	s.CpnyID = l.CpnyID
		  and	s.OrdNbr = l.OrdNbr
		  and	s.LineRef = l.LineRef
		  and l.Status = 'O'

		  join	SOType t (NOLOCK)
		  on	s.CpnyID = t.CpnyID
		  and	h.SOTypeID = t.SOTypeID

		where	s.Status = 'O' and			-- with @CpnyID here, SWIM assertion failure
			s.CpnyID = @CpnyID and
			s.OrdNbr = @OrdNbr and
			s.LineRef + '' LIKE @LineRef and
			s.SchedRef + '' LIKE @SchedRef and
		  	s.CancelDate > @CancelDate and
		  	s.QtyOrd > 0 and
		  	(s.QtyOrd - s.QtyShip) <> 0 and
		  	t.Behavior in ( 'CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SERV', 'SO', 'TR', 'WC', 'WO')
			and l.InvtID like @InvtIDParm
			and s.SiteID like @SiteIDParm
			-- After InvtID, SiteID, then Order By
		--      SO Bound to WO = 1
		--      SOSched.LineRef - keep all for one SOLine together
		-- 	SOSched.ReqDate - put latest reqdate last
		order by l.invtid, s.siteid, l.BoundToWO DESC, s.lineref, s.reqdate
	ELSE
		select
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
			l.invtid,
			s.siteid,
			s.dropship,
			s.LotSerialEntered,
			l.BoundToWO,
			l.ProjectID,      -- WO Nbr
			s.ShipSiteID,
			s.AutoPO,
			l.QtyShip

		from	SOSched s

		  join	SOHeader h (NOLOCK)
		  on	s.CpnyID = h.CpnyID
		  and	s.OrdNbr = h.OrdNbr
		  and h.Status = 'O'

		join	SOLine l WITH (NOLOCK)
		  on	s.CpnyID = l.CpnyID
		  and	s.OrdNbr = l.OrdNbr
		  and	s.LineRef = l.LineRef
		  and l.Status = 'O'

		  join	SOType t (NOLOCK)
		  on	s.CpnyID = t.CpnyID
		  and	h.SOTypeID = t.SOTypeID

		where	s.Status = 'O' and			-- with @CpnyID here, SWIM assertion failure
			s.CpnyID = @CpnyID and
			s.OrdNbr = @OrdNbr and
			s.LineRef = @LineRef and
			s.SchedRef = @SchedRef and
		  	s.CancelDate > @CancelDate and
	  		s.QtyOrd > 0 and
		  	(s.QtyOrd - s.QtyShip) <> 0 and
		  	t.Behavior in ( 'CS', 'INVC', 'MO', 'RMA', 'RMSH', 'SERV', 'SO', 'TR', 'WC', 'WO')
			and l.InvtID like @InvtIDParm
			and s.SiteID like @SiteIDParm

		-- After InvtID, SiteID, then Order By
		--      SO Bound to WO = 1
		--      SOSched.LineRef - keep all for one SOLine together
		-- 	SOSched.ReqDate - put latest reqdate last
		order by l.invtid, s.siteid, l.BoundToWO DESC, s.lineref, s.reqdate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_UpdateSO_Get_SO_IS_LQ] TO [MSDSL]
    AS [dbo];

