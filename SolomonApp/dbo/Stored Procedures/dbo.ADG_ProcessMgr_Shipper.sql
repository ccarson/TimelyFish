 create proc ADG_ProcessMgr_Shipper
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5)
as
	select	l.InvtID,
--		h.SiteID
		l.SiteID

	from	SOShipLine	l

--	join	SOShipHeader h on l.CpnyID = h.CpnyID and l.ShipperID = h.ShipperID

	where	l.CpnyID = @CpnyID
	and	l.ShipperID = @ShipperID
	and	l.LineRef + '' like @LineRef

	group by
		l.InvtID,
--		h.SiteID
		l.SiteID


