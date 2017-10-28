 create proc ADG_Plan_DelShipperItemPlan
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	delete	SOPlan

	where	CpnyID = @CpnyID
	and	SOShipperID = @ShipperID
	and	InvtID = @InvtID
	and	SiteID = @SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_DelShipperItemPlan] TO [MSDSL]
    AS [dbo];

