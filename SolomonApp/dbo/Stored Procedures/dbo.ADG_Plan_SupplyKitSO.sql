 create proc ADG_Plan_SupplyKitSO
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@CancelDate	smalldatetime
as
	select	h.CpnyID,
		h.OrdNbr,
		h.BuildAvailDate,
		h.BuildQty,
		h.S4Future03	-- BuildQtyUpdated

	from	SOHeader h
	join	SOType	 t
	on	h.CpnyID = t.CpnyID
	and	h.SOTypeID = t.SOTypeID

	where	h.BuildInvtID = @InvtID
	and	h.BuildSiteID = @SiteID
	and	h.Status = 'O'
	and	h.CancelDate > @CancelDate
	and	t.Behavior = 'WO'

	order by
		h.BuildAvailDate


