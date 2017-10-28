 create proc ADG_ProcessMgr_ShObsolete
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5)
as
	select	p.InvtID,
		p.SiteID

	from	SOPlan		p

	join	SOShipLine	l
	on	l.CpnyID = p.CpnyID
	and	l.ShipperID = p.SOShipperID

	where	p.CpnyID = @CpnyID
	and	p.SOShipperID = @ShipperID
	and	p.SOShipperLineRef like @LineRef
	and	((p.InvtID <> l.InvtID) or (p.SiteID <> l.SiteID))

	group by
		p.InvtID,
		p.SiteID


