 create proc ADG_ProcessMgr_SOKitObsolete
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15)
as
	select	p.InvtID,
		p.SiteID

	from	SOPlan p

	join	SOHeader h
	on	h.CpnyID = p.CpnyID
	and	h.OrdNbr = p.SOOrdNbr

	where	p.CpnyID = @CpnyID
	and	p.SOOrdNbr = @SOOrdNbr
	and	p.PlanType = '25'
	and	((p.InvtID <> h.BuildInvtID) or (p.SiteID <> h.BuildSiteID))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOKitObsolete] TO [MSDSL]
    AS [dbo];

