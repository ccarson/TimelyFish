 create proc DMG_UpdateSOShipper_Get_KitSupplySH
	@CpnyID		varchar(10),
	@ShipperID   	varchar(15)
as
	select
		h.BuildCmpltDate,
		h.BuildQty,
		h.BuildInvtID,
		h.SiteID

	from	SOShipHeader h
	  join	SOType	 t
	  on	h.CpnyID = t.CpnyID
	  and	h.SOTypeID = t.SOTypeID

	where	h.CpnyID = @CpnyID and
	      	h.ShipperID = @ShipperID and
	  	h.Status = 'O' and
	  	h.OrdNbr = '' and 			-- manually-entered shippers only for now
	  	t.Behavior = 'WO'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_UpdateSOShipper_Get_KitSupplySH] TO [MSDSL]
    AS [dbo];

