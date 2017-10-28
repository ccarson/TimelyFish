 create proc ADG_ProcessMgr_ShKit
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	BuildInvtID,
		SiteID

	from	SOShipHeader

	where	CpnyID = @CpnyID
	and	ShipperID = @ShipperID


