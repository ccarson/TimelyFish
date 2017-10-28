 create proc ADG_ProcessMgr_ShKitObsolete
	@CpnyID		varchar(10),
	@SOShipperID	varchar(15)
as
	select	p.InvtID,
		p.SiteID

	from	SOPlan	p

	join	SOShipHeader h
	on	h.CpnyID = p.CpnyID
	and	h.ShipperID = p.SOShipperID

	where	p.CpnyID = @CpnyID
	and	p.SOShipperID = @SOShipperID
	and	p.PlanType = '26'
	and	((p.InvtID <> h.BuildInvtID) or (p.SiteID <> h.SiteID))


