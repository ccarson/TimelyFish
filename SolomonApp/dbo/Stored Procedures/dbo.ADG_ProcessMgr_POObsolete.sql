 create proc ADG_ProcessMgr_POObsolete
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@LineRef	varchar(5)
as
	select	p.InvtID,
		p.SiteID

	from	SOPlan	p

	join	PurOrdDet l
	on	l.PONbr = @PONbr
	and	l.LineRef = @LineRef

	where	p.PONbr = @PONbr
	and	p.POLineRef like @LineRef
	and	p.CpnyID = @CpnyID
	and	((p.InvtID <> l.InvtID) or (p.SiteID <> l.SiteID))

	group by
		p.InvtID,
		p.SiteID


