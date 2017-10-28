 create proc ADG_Plan_Delete
	@InvtID 	varchar(30),
	@SiteID 	varchar(10)
as
	delete	SOPlan
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType <> '61'


