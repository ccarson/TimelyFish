 create proc DMG_UpdateSOShipper_Get_KitSupplySO_IS
	@CpnyID		varchar(10),
	@OrdNbr   	varchar(15),
	@CancelDate	smalldatetime,
	@InvtIDParm	varchar(30),
	@SiteIDParm	varchar(10)
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
		and h.BuildInvtID like @InvtIDParm
		and h.BuildSiteID like @SiteIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_UpdateSOShipper_Get_KitSupplySO_IS] TO [MSDSL]
    AS [dbo];

