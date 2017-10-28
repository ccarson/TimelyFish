 create proc ADG_ProcessMgr_ShTrfr
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5)
as
	select	l.InvtID,
		h.ShipSiteID

	from	SOShipLine l

	join	SOShipHeader h
	on	h.CpnyID = l.CpnyID
	and	h.ShipperID = l.ShipperID

	where	l.CpnyID = @CpnyID
	and	l.ShipperID = @ShipperID
	and	l.LineRef like @LineRef

	group by
		l.InvtID,
		h.ShipSiteID


