 create proc ADG_Plan_FetchKitSupplyPlan
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ShipperID	varchar(15),
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	*
	from	SOPlan

	where	CpnyID = @CpnyID
	and	SOOrdNbr = @OrdNbr
	and	SOShipperID = @ShipperID
	and	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('25', '26')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_FetchKitSupplyPlan] TO [MSDSL]
    AS [dbo];

