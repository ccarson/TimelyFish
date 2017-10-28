 create proc ADG_ProcessMgr_SOObsolete
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15),
	@SOLineRef	varchar(5),
	@SOSchedRef	varchar(5)
as
	select	p.InvtID,
		p.SiteID

	from	SOPlan p

	left join SOLine l
	on	l.CpnyID = p.CpnyID
	and	l.OrdNbr = p.SOOrdNbr
	and	l.LineRef = p.SOLineRef

	left join SOSched s
	on	s.CpnyID = p.CpnyID
	and	s.OrdNbr = p.SOOrdNbr
	and	s.LineRef = p.SOLineRef
	and	s.SchedRef = p.SOSchedRef

	where	p.CpnyID = @CpnyID
	and	p.SOOrdNbr = @SOOrdNbr
	and	p.SOLineRef like @SOLineRef
	and	p.SOSchedRef like @SOSchedRef
	and	p.PlanType <> '61'
	and	((p.InvtID <> coalesce(l.InvtID,'')) or (p.SiteID <> coalesce(s.SiteID,'')))

	group by
		p.InvtID,
		p.SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOObsolete] TO [MSDSL]
    AS [dbo];

