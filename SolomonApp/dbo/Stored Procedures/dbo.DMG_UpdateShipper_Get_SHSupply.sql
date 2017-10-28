 create proc DMG_UpdateShipper_Get_SHSupply
	@CpnyID		varchar(10),
	@ShipperID   	varchar(15)

as
	select
		h.OrdNbr,
		t.Behavior

	from	SOShipHeader	h

	  join	SOType		t
	  on	t.CpnyID = h.CpnyID
	  and	t.SOTypeID = h.SOTypeID

	where	h.CpnyID = @CpnyID
		and h.ShipperID = @ShipperID
	  	and t.Behavior in ('TR', 'WO')


