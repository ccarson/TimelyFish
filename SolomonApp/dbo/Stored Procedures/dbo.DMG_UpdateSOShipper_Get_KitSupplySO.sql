 create proc DMG_UpdateSOShipper_Get_KitSupplySO
	@CpnyID		   varchar(10),
	@OrdNbr   		varchar(15),
	@CancelDate		smalldatetime
as
	select
		h.BuildAvailDate,
		h.BuildQty,
		h.S4Future03,						-- BuildQtyUpdated
		h.BuildInvtID,
		h.BuildSiteID

	from	SOHeader h
	  join	SOType	 t
	  on	h.CpnyID = t.CpnyID
	  and	h.SOTypeID = t.SOTypeID

	where	h.CpnyID = @CpnyID and
	      	h.OrdNbr = @OrdNbr and
	  	h.Status = 'O' and
	  	t.Behavior = 'WO' and
		h.CancelDate > @CancelDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_UpdateSOShipper_Get_KitSupplySO] TO [MSDSL]
    AS [dbo];

