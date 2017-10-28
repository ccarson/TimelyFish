 create proc ADG_ProcessMgr_ShBehavior
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select		t.Behavior
	from		SOShipHeader h

	join		SOType t
	on		t.CpnyID = @CpnyID
	and		t.SOTypeID = h.SOTypeID

	where		h.CpnyID = @CpnyID
	and		h.ShipperID = @ShipperID


