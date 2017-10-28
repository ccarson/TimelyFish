 create proc ADG_Plan_AdjustInvtQtyShip
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@QtyShipAdj	float
as
	update	SOPlan

	set	QtyShip = QtyShip + @QtyShipAdj

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType = '10'


