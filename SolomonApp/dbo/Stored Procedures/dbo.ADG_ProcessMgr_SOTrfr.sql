 create proc ADG_ProcessMgr_SOTrfr
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
as
	select	l.InvtID,
		h.ShipSiteID

	from	SOSched s

	join	SOLine l
	on	s.CpnyID = l.CpnyID
	and	s.OrdNbr = l.OrdNbr
	and	s.LineRef = l.LineRef

	join	SOHeader h
	on	s.CpnyID = h.CpnyID
	and	s.OrdNbr = h.OrdNbr

	where	s.CpnyID = @CpnyID
	and	s.OrdNbr = @OrdNbr
	and	s.LineRef like @LineRef
	and	s.SchedRef like @SchedRef

	group by
		l.InvtID,
		h.ShipSiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOTrfr] TO [MSDSL]
    AS [dbo];

