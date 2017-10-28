 create proc ADG_Plan_GetShipperItem
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	InvtID,
		SiteID,
		sum(Qty)

	from	SOPlan

	where	CpnyID = @CpnyID
	and	SOShipperID = @ShipperID
	and	PlanType in ('30', '32', '34')	-- reserved shippers only

	group by
		InvtID,
		SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_GetShipperItem] TO [MSDSL]
    AS [dbo];

