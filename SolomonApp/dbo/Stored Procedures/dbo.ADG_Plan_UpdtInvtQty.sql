 create proc ADG_Plan_UpdtInvtQty
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@Qty		float
as
	update		SOPlan

	set		Qty = @Qty

	where		InvtID = @InvtID
	and		SiteID = @SiteID
	and		PlanType = '10'


