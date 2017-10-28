 create proc ADG_Plan_PlanPostFloat
	@InvtID 	varchar(30),
	@SiteID 	varchar(10)
as
	select	*
	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('30', '32', '34', '40', '68', '70', '75')

	order by
		PlanDate


